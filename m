From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 8 Oct 2012 12:10:36 +0530
Message-ID: <1349678436-747-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52647 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab2JHGkw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 8 Oct 2012 02:40:52 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Fix "received wrong sequence count. expected: x, got: y" errors
reported by cansequence in a stress test (--verbose).

While processing the receive packets in mailboxes, upper mailboxes
need to enable while processing 12th (RX_BUFFER mailbox) mailbox.
This requires a status check to identify whether the receiving of
packets in progress or not. If the mailboxes are enabled before the
receive packet status is cleared then there is a possibility of
receiving out of order packets.

With this patch mailboxes are enabled once the receive status is
cleared.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/ti_hecc.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 39293e9..2417a2d 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -169,6 +169,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANES_SMA		BIT(5)	/* suspend mode ack */
 #define HECC_CANES_CCE		BIT(4)	/* Change config enabled */
 #define HECC_CANES_PDA		BIT(3)	/* Power down mode ack */
+#define HECC_CANES_RM		BIT(1)	/* Receive Mode bit */
 
 #define HECC_CANBTC_SAM		BIT(7)	/* sample points */
 
@@ -194,6 +195,13 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANGIM_DEF_MASK	0x700	/* only busoff/warning/passive */
 #define HECC_CANGIM_SIL		BIT(2)	/* system interrupts to int line 1 */
 
+/*
+ * Receive Mode bit reflects what the CAN protocol kernel (CPK) is
+ * actually doing regardless of mailbox configuration. CPK receive
+ * mode timeout. Tried from 1 - 5us and kept 10 as a safety value.
+ */
+#define RM_TIMEOUT_US		10
+
 /* CAN Bittiming constants as per HECC specs */
 static struct can_bittiming_const ti_hecc_bittiming_const = {
 	.name = DRV_NAME,
@@ -615,7 +623,7 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 	struct ti_hecc_priv *priv = netdev_priv(ndev);
 	u32 num_pkts = 0;
 	u32 mbx_mask;
-	unsigned long pending_pkts, flags;
+	unsigned long pending_pkts, flags, timeout;
 
 	if (!netif_running(ndev))
 		return 0;
@@ -633,6 +641,15 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 		--priv->rx_next;
 		if (priv->rx_next == HECC_RX_BUFFER_MBOX) {
 			/* enable high bank mailboxes */
+			timeout = jiffies + usecs_to_jiffies(RM_TIMEOUT_US);
+			while (hecc_get_bit(priv, HECC_CANES, HECC_CANES_RM)) {
+				cpu_relax();
+				if (time_after(jiffies, timeout)) {
+					netdev_warn(ndev, "receiving pkt\n");
+					break;
+				}
+			}
+
 			spin_lock_irqsave(&priv->mbx_lock, flags);
 			mbx_mask = hecc_read(priv, HECC_CANME);
 			mbx_mask |= HECC_RX_HIGH_MBOX_MASK;
-- 
1.7.0.4

