From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/7] can: dev: sort can_changelink() by IFLA_CAN_*
Date: Mon,  7 Oct 2013 16:40:37 +0200
Message-ID: <1381156840-24071-5-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab3JGOkq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:46 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch sorts the handling of data[IFLA_CAN_*] by IFLA_CAN_*.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8d6f721..bda1888 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -645,19 +645,6 @@ static int can_changelink(struct net_device *dev,
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_CTRLMODE]) {
-		struct can_ctrlmode *cm;
-
-		/* Do not allow changing controller mode while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		if (cm->flags & ~priv->ctrlmode_supported)
-			return -EOPNOTSUPP;
-		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= cm->flags;
-	}
-
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
 
@@ -680,6 +667,19 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_CTRLMODE]) {
+		struct can_ctrlmode *cm;
+
+		/* Do not allow changing controller mode while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+		if (cm->flags & ~priv->ctrlmode_supported)
+			return -EOPNOTSUPP;
+		priv->ctrlmode &= ~cm->mask;
+		priv->ctrlmode |= cm->flags;
+	}
+
 	if (data[IFLA_CAN_RESTART_MS]) {
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
-- 
1.8.4.rc3

