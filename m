From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak_canfd: fix uninitialized symbol warnings
Date: Wed,  3 May 2017 10:35:04 +0200
Message-ID: <1493800504-17529-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:26245 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbdECIfY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 May 2017 04:35:24 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch fixes two uninitialized symbol warnings in the new code adding
support of the PEAK-System PCAN-PCI Express FD boards, in the socket-CAN
network protocol family.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 0d57be5..912bd81 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -399,8 +399,9 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 	} else if (priv->can.state != CAN_STATE_ERROR_ACTIVE) {
 		/* back to ERROR_ACTIVE */
 		netdev_dbg(ndev, "Error active status\n");
-		can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
-				 CAN_STATE_ERROR_ACTIVE);
+		if (skb)
+			can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
+					 CAN_STATE_ERROR_ACTIVE);
 	} else {
 		dev_kfree_skb(skb);
 		return 0;
@@ -489,7 +490,7 @@ int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
 				struct pucan_rx_msg *msg_list, int msg_count)
 {
 	void *msg_ptr = msg_list;
-	int i, msg_size;
+	int i, msg_size = 0;
 
 	for (i = 0; i < msg_count; i++) {
 		msg_size = peak_canfd_handle_msg(priv, msg_ptr);
-- 
2.7.4

