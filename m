From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: add TX support for variable payload size
Date: Wed, 12 Dec 2018 06:46:34 +0000
Message-ID: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Now the FlexCAN driver always use last mailbox for TX, it will work well
when MB payload size is 8/16 bytes.
TX mailbox would change to 13 when MB payload size is 64 bytes to
support CANFD. So we may need to set iflag register to add support for
variable payload size.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..13fd085fcf84 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -141,7 +141,9 @@
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
 #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
 #define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIME=
STAMP + 1)
-#define FLEXCAN_IFLAG_MB(x)		BIT((x) & 0x1f)
+#define FLEXCAN_IFLAG1_MB_NUM		32
+#define FLEXCAN_IFLAG1_MB(x)		BIT(x)
+#define FLEXCAN_IFLAG2_MB(x)		BIT((x) & 0x1f)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -822,9 +824,15 @@ static inline u64 flexcan_read_reg_iflag_rx(struct fle=
xcan_priv *priv)
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 iflag1, iflag2;
=20
-	iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
-		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-	iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
+			~FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
+	} else {
+		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default;
+		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default &
+			~FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+	}
=20
 	return (u64)iflag2 << 32 | iflag1;
 }
@@ -836,7 +844,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	irqreturn_t handled =3D IRQ_NONE;
-	u32 reg_iflag2, reg_esr;
+	u32 reg_tx_iflag, tx_iflag_idx, reg_esr;
+	void __iomem *reg_iflag;
 	enum can_state last_state =3D priv->can.state;
=20
 	/* reception interrupt */
@@ -870,10 +879,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
=20
-	reg_iflag2 =3D priv->read(&regs->iflag2);
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		reg_tx_iflag =3D priv->read(&regs->iflag2);
+		tx_iflag_idx =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+		reg_iflag =3D &regs->iflag2;
+	} else {
+		reg_tx_iflag =3D priv->read(&regs->iflag1);
+		tx_iflag_idx =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+		reg_iflag =3D &regs->iflag1;
+	}
=20
 	/* transmission complete interrupt */
-	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+	if (reg_tx_iflag & tx_iflag_idx) {
 		u32 reg_ctrl =3D priv->read(&priv->tx_mb->can_ctrl);
=20
 		handled =3D IRQ_HANDLED;
@@ -885,7 +902,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
+		priv->write(tx_iflag_idx, reg_iflag);
 		netif_wake_queue(dev);
 	}
=20
@@ -1244,8 +1261,13 @@ static int flexcan_open(struct net_device *dev)
 	priv->tx_mb_idx =3D priv->mb_count - 1;
 	priv->tx_mb =3D flexcan_get_mb(priv, priv->tx_mb_idx);
=20
-	priv->reg_imask1_default =3D 0;
-	priv->reg_imask2_default =3D FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		priv->reg_imask1_default =3D 0;
+		priv->reg_imask2_default =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+	} else {
+		priv->reg_imask1_default =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+		priv->reg_imask2_default =3D 0;
+	}
=20
 	priv->offload.mailbox_read =3D flexcan_mailbox_read;
=20
--=20
2.17.1
