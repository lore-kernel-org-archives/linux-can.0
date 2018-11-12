From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/20] can: flexcan: Always use last mailbox for TX
Date: Mon, 12 Nov 2018 12:57:19 +0100
Message-ID: <20181112115728.18331-12-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Alexander Stein <alexander.stein@systec-electronic.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Alexander Stein <alexander.stein@systec-electronic.com>

Essentially this patch moves the TX mailbox to position 63, regardless
of timestamp based offloading or RX FIFO. So mainly the iflag register
usage regarding TX has changed. The rest is consolidating RX FIFO and
timestamp offloading as they now use both the same TX mailbox.

The reason is a very annoying behavior regarding sending RTR frames when
_not_ using RX FIFO:

If a TX mailbox sent a RTR frame it becomes a RX mailbox. For that
reason flexcan_irq disables the TX mailbox again. But if during the time
the RTR was sent and the TX mailbox is disabled a new CAN frames is
received, it is lost without notice. The reason is that so-called
"Move-in" process starts from the lowest mailbox which happen to be a TX
mailbox set to EMPTY.

Steps to reproduce (I used an imx7d):
1. generate regular bursts of messages
2. send a RTR from flexcan with higher priority than burst messages every
   1ms, e.g. cangen -I 0x100 -L 0 -g 1 -R can0
3. notice a lost message without notification after some seconds

When running an iperf in parallel this problem is occurring even more
frequently. Using filters is not possible as at least one single CAN-ID
is allowed. Handling the TX MB during RX is also not possible as there
is no race-free disable of RX MB.

There is still a slight window when the described problem can occur. But
for that all RX MB must be in use which is essentially next to an
overrun. Still there will be no indication if it ever occurs.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 67 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0431f8d05518..677c41701cf3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -135,13 +135,12 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO	8
-#define FLEXCAN_TX_MB_OFF_FIFO		9
+#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
 #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
-#define FLEXCAN_TX_MB_OFF_TIMESTAMP		1
-#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_OFF_TIMESTAMP + 1)
-#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	63
-#define FLEXCAN_IFLAG_MB(x)		BIT(x)
+#define FLEXCAN_TX_MB				63
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP + 1)
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	(FLEXCAN_TX_MB - 1)
+#define FLEXCAN_IFLAG_MB(x)		BIT(x & 0x1f)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -737,9 +736,9 @@ static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 iflag1, iflag2;
 
-	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default;
-	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default &
+	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default &
 		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default;
 
 	return (u64)iflag2 << 32 | iflag1;
 }
@@ -751,11 +750,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_iflag2, reg_esr;
 	enum can_state last_state = priv->can.state;
 
-	reg_iflag1 = priv->read(&regs->iflag1);
-
 	/* reception interrupt */
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		u64 reg_iflag;
@@ -769,6 +766,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 				break;
 		}
 	} else {
+		u32 reg_iflag1;
+
+		reg_iflag1 = priv->read(&regs->iflag1);
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 			handled = IRQ_HANDLED;
 			can_rx_offload_irq_offload_fifo(&priv->offload);
@@ -784,8 +784,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	reg_iflag2 = priv->read(&regs->iflag2);
+
 	/* transmission complete interrupt */
-	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
 		handled = IRQ_HANDLED;
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
@@ -794,7 +796,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
+		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
 		netif_wake_queue(dev);
 	}
 
@@ -936,15 +938,13 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
 		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
-		FLEXCAN_MCR_IDAM_C;
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		reg_mcr &= ~FLEXCAN_MCR_FEN;
-		reg_mcr |= FLEXCAN_MCR_MAXMB(priv->offload.mb_last);
-	} else {
-		reg_mcr |= FLEXCAN_MCR_FEN |
-			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
-	}
+	else
+		reg_mcr |= FLEXCAN_MCR_FEN;
+
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
 
@@ -987,16 +987,17 @@ static int flexcan_chip_start(struct net_device *dev)
 		priv->write(reg_ctrl2, &regs->ctrl2);
 	}
 
-	/* clear and invalidate all mailboxes first */
-	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
-		priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			    &regs->mb[i].can_ctrl);
-	}
-
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++)
+		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++) {
 			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
 				    &regs->mb[i].can_ctrl);
+		}
+	} else {
+		/* clear and invalidate unused mailboxes first */
+		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i <= ARRAY_SIZE(regs->mb); i++) {
+			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
+				    &regs->mb[i].can_ctrl);
+		}
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
@@ -1360,17 +1361,15 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_TIMESTAMP;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP];
-	} else {
-		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_FIFO;
+	else
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
-	}
+	priv->tx_mb_idx = FLEXCAN_TX_MB;
 	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
 
-	priv->reg_imask1_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-	priv->reg_imask2_default = 0;
+	priv->reg_imask1_default = 0;
+	priv->reg_imask2_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
-- 
2.19.1
