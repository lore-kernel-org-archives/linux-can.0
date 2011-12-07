From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 14/14] can: cc770: consolidate bus-off handling
Date: Wed,  7 Dec 2011 15:55:28 +0100
Message-ID: <1323269728-17491-15-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49289 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab1LGOzm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:42 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

A real bus off recovery cycle is triggered by re-setting the init
bit and the netif queue is restarted not before the CAN error
has returned below bus-off (passive, warning or active).

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a bus-off recovery due to a short circiut (restart after 5s) for an
Intel 82527 on a TQM855L board:

 (000.201120)  can0   88  [8] 31 33 FE 45 58 C2 08 FE
 (000.200637)  can0  2000020C  [8] 00 0C 08 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-error-warning,tx-error-warning}
        protocol-violation{{tx-dominant-bit-error}{}}
        state-change{rx-error-warning,tx-error-warning}
 (000.001016)  can0  20000248  [8] 00 00 08 00 00 00 00 00   ERRORFRAME
        protocol-violation{{tx-dominant-bit-error}{}}
        bus-off
        state-change{}
 (005.007273)  can0  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        restarted-after-bus-off
 (000.003323)  can0  20000208  [8] 00 40 08 00 00 00 00 00   ERRORFRAME
        protocol-violation{{tx-dominant-bit-error}{}}
        state-change{back-to-error-active}
 (000.005255)  can0   A2  [3] 50 22 B6

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/cc770/cc770.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 905a3ca..6d77bbc 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -337,7 +337,16 @@ static void cc770_start(struct net_device *dev)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
 
-	/* leave reset mode */
+	if (priv->can.state == CAN_STATE_BUS_OFF) {
+		/*
+		 * Start bus-off recovery cycle by clearing the init
+		 * bit and re-enabling the interrupts
+		 */
+		cc770_write_reg(priv, control, priv->control_normal_mode);
+		return;
+	}
+
+	/* enter reset mode ? */
 	if (priv->can.state != CAN_STATE_STOPPED)
 		set_reset_mode(dev);
 
@@ -347,10 +356,13 @@ static void cc770_start(struct net_device *dev)
 
 static int cc770_set_mode(struct net_device *dev, enum can_mode mode)
 {
+	struct cc770_priv *priv = netdev_priv(dev);
+
 	switch (mode) {
 	case CAN_MODE_START:
-		netif_wake_queue(dev);
 		cc770_start(dev);
+		if (priv->can.state != CAN_STATE_BUS_OFF)
+			netif_wake_queue(dev);
 		break;
 
 	default:
@@ -529,6 +541,7 @@ static int cc770_err(struct net_device *dev, u8 status)
 		/* Disable interrupts */
 		cc770_write_reg(priv, control, CTRL_INI);
 		new_state = CAN_STATE_BUS_OFF;
+		netif_stop_queue(dev);
 		can_bus_off(dev);
 	} else if (status & STAT_WARN) {
 		/* Only the CC770 does show error passive */
@@ -541,8 +554,12 @@ static int cc770_err(struct net_device *dev, u8 status)
 		/* Back to error avtive */
 		new_state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (new_state != priv->can.state)
+	if (new_state != priv->can.state) {
+		/* Have we recovered from bus-off? */
+		if (priv->can.state == CAN_STATE_BUS_OFF)
+			netif_wake_queue(dev);
 		can_change_state(dev, cf, new_state, CAN_ERR_DIR_UNKNOWN);
+	}
 
 	lec = status & STAT_LEC_MASK;
 	if (lec < 7 && lec > 0) {
@@ -757,7 +774,6 @@ static int cc770_open(struct net_device *dev)
 	/* init and start chip */
 	cc770_start(dev);
 
-	netif_start_queue(dev);
 	return 0;
 }
 
-- 
1.7.4.1

