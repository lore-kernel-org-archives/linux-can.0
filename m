From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 13/14] can: cc770: consolidate error state handling
Date: Wed,  7 Dec 2011 15:55:27 +0100
Message-ID: <1323269728-17491-14-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49283 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab1LGOzm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:42 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Allow state to decrease bus-off->passive->warning->active.
Use the common function can_chage_state().

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for an Intel 82527 on a TQM855L board:

 (000.200637)  can0   58  [4] 51 C0 12 C4
 (000.202869)  can0  20000224  [8] 00 0C 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-error-warning,tx-error-warning}
        no-acknowledgement-on-tx
        state-change{rx-error-warning,tx-error-warning}
 (004.928599)  can0   59  [8] 50 69 F9 1F 6A 88 4B 3A
 (000.000429)  can0   5A  [8] 29 1C 44 49 06 8C F8 07
 ...
 (000.200789)  can0   8A  [8] 38 6B F1 09 0B A2 6D 80
 (000.200831)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.000021)  can0   8B  [7] 4B 9A 8A E7 5B C5 CD

The Intel 82527 does not report state changes to error passive.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/cc770/cc770.c |   37 ++++++++++++-------------------------
 1 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 7668967..905a3ca 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -349,8 +349,8 @@ static int cc770_set_mode(struct net_device *dev, enum can_mode mode)
 {
 	switch (mode) {
 	case CAN_MODE_START:
-		cc770_start(dev);
 		netif_wake_queue(dev);
+		cc770_start(dev);
 		break;
 
 	default:
@@ -513,6 +513,7 @@ static int cc770_err(struct net_device *dev, u8 status)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
+	enum can_state new_state;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u8 lec;
@@ -523,38 +524,25 @@ static int cc770_err(struct net_device *dev, u8 status)
 	if (!skb)
 		return -ENOMEM;
 
-	/* Use extended functions of the CC770 */
-	if (priv->control_normal_mode & CTRL_EAF) {
-		cf->data[6] = cc770_read_reg(priv, tx_error_counter);
-		cf->data[7] = cc770_read_reg(priv, rx_error_counter);
-	}
-
+	/* Handle state changes */
 	if (status & STAT_BOFF) {
 		/* Disable interrupts */
 		cc770_write_reg(priv, control, CTRL_INI);
-		cf->can_id |= CAN_ERR_BUSOFF;
-		priv->can.state = CAN_STATE_BUS_OFF;
+		new_state = CAN_STATE_BUS_OFF;
 		can_bus_off(dev);
 	} else if (status & STAT_WARN) {
-		cf->can_id |= CAN_ERR_CRTL;
 		/* Only the CC770 does show error passive */
-		if (cf->data[7] > 127) {
-			cf->data[1] = CAN_ERR_CRTL_RX_PASSIVE |
-				CAN_ERR_CRTL_TX_PASSIVE;
-			priv->can.state = CAN_STATE_ERROR_PASSIVE;
-			priv->can.can_stats.error_passive++;
-		} else {
-			cf->data[1] = CAN_ERR_CRTL_RX_WARNING |
-				CAN_ERR_CRTL_TX_WARNING;
-			priv->can.state = CAN_STATE_ERROR_WARNING;
-			priv->can.can_stats.error_warning++;
-		}
+		if (priv->control_normal_mode & CTRL_EAF &&
+		    cc770_read_reg(priv, rx_error_counter) > 127)
+			new_state = CAN_STATE_ERROR_PASSIVE;
+		else
+			new_state = CAN_STATE_ERROR_WARNING;
 	} else {
 		/* Back to error avtive */
-		cf->can_id |= CAN_ERR_PROT;
-		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		new_state = CAN_STATE_ERROR_ACTIVE;
 	}
+	if (new_state != priv->can.state)
+		can_change_state(dev, cf, new_state, CAN_ERR_DIR_UNKNOWN);
 
 	lec = status & STAT_LEC_MASK;
 	if (lec < 7 && lec > 0) {
@@ -770,7 +758,6 @@ static int cc770_open(struct net_device *dev)
 	cc770_start(dev);
 
 	netif_start_queue(dev);
-
 	return 0;
 }
 
-- 
1.7.4.1

