From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v6 3/7] can: move sanity check for bitrate and tq into can_get_bittiming
Date: Thu, 27 Feb 2014 19:15:08 +0100
Message-ID: <1393524912-12970-4-git-send-email-socketcan@hartkopp.net>
References: <1393524912-12970-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:24701 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbaB0SPX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 13:15:23 -0500
In-Reply-To: <1393524912-12970-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This patch moves a sanity check in order to have a second user for CAN FD.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index de04eac..89fc798 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -263,12 +263,19 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	if (priv->bittiming_const) {
 
 		/* Non-expert mode? Check if the bitrate has been pre-defined */
-		if (!bt->tq)
+		if (!bt->tq) {
 			/* Determine bit-timing parameters */
-			err = can_calc_bittiming(dev, bt);
-		else
+			if (bt->bitrate)
+				err = can_calc_bittiming(dev, bt);
+			else
+				return -EINVAL;
+		} else {
 			/* Check bit-timing params and calculate proper brp */
-			err = can_fixup_bittiming(dev, bt);
+			if (!bt->bitrate)
+				err = can_fixup_bittiming(dev, bt);
+			else
+				return -EINVAL;
+		}
 		if (err)
 			return err;
 	}
@@ -667,8 +674,6 @@ static int can_changelink(struct net_device *dev,
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
-			return -EINVAL;
 		err = can_get_bittiming(dev, &bt);
 		if (err)
 			return err;
-- 
1.9.0

