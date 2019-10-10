From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 24/29] can: ti_hecc: add fifo underflow error reporting
Date: Thu, 10 Oct 2019 14:17:45 +0200
Message-ID: <20191010121750.27237-25-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

When the rx fifo overflows the ti_hecc would silently drop them since
the overwrite protection is enabled for all mailboxes. So disable it
for the lowest priority mailbox and increment the rx_fifo_errors when
receive message lost is set. Drop the message itself in that case,
since it might be partially updated.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6ea29126c60b..c2d83ada203a 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -82,7 +82,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANTA		0x10	/* Transmission acknowledge */
 #define HECC_CANAA		0x14	/* Abort acknowledge */
 #define HECC_CANRMP		0x18	/* Receive message pending */
-#define HECC_CANRML		0x1C	/* Remote message lost */
+#define HECC_CANRML		0x1C	/* Receive message lost */
 #define HECC_CANRFP		0x20	/* Remote frame pending */
 #define HECC_CANGAM		0x24	/* SECC only:Global acceptance mask */
 #define HECC_CANMC		0x28	/* Master control */
@@ -385,8 +385,17 @@ static void ti_hecc_start(struct net_device *ndev)
 	/* Enable tx interrupts */
 	hecc_set_bit(priv, HECC_CANMIM, BIT(HECC_MAX_TX_MBOX) - 1);
 
-	/* Prevent message over-write & Enable interrupts */
-	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
+	/* Prevent message over-write to create a rx fifo, but not for
+	 * the lowest priority mailbox, since that allows detecting
+	 * overflows instead of the hardware silently dropping the
+	 * messages. The lowest rx mailbox is one above the tx ones,
+	 * hence its mbxno is the number of tx mailboxes.
+	 */
+	mbxno = HECC_MAX_TX_MBOX;
+	mbx_mask = ~BIT(mbxno);
+	hecc_write(priv, HECC_CANOPC, mbx_mask);
+
+	/* Enable interrupts */
 	if (priv->use_hecc1int) {
 		hecc_write(priv, HECC_CANMIL, HECC_SET_REG);
 		hecc_write(priv, HECC_CANGIM, HECC_CANGIM_DEF_MASK |
@@ -531,6 +540,7 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 {
 	struct ti_hecc_priv *priv = rx_offload_to_priv(offload);
 	u32 data, mbx_mask;
+	int lost;
 
 	mbx_mask = BIT(mbxno);
 	data = hecc_read_mbx(priv, mbxno, HECC_CANMID);
@@ -552,9 +562,12 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 	}
 
 	*timestamp = hecc_read_stamp(priv, mbxno);
+	lost = hecc_read(priv, HECC_CANRML) & mbx_mask;
+	if (unlikely(lost))
+		priv->offload.dev->stats.rx_fifo_errors++;
 	hecc_write(priv, HECC_CANRMP, mbx_mask);
 
-	return 1;
+	return !lost;
 }
 
 static int ti_hecc_error(struct net_device *ndev, int int_status,
-- 
2.23.0
