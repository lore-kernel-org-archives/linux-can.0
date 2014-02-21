From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 6/7] can: fix bitrate check semantics at interface open time
Date: Fri, 21 Feb 2014 19:57:04 +0100
Message-ID: <1393009025-4903-7-git-send-email-socketcan@hartkopp.net>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:41524 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbaBUS5U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 13:57:20 -0500
In-Reply-To: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

When the expert mode is used to configure the bit-timing with
'tq' and friends, the bitrate is provided by can_fixup_bittiming().
When the bitrate calculation is used, can_calc_bittiming() provides
'tq' and friends. So in any case both values need to be not zero.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 6aa8897..d9f7281 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -641,8 +641,14 @@ int open_candev(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	if (!priv->bittiming.tq && !priv->bittiming.bitrate) {
-		netdev_err(dev, "bit-timing not yet defined\n");
+	/*
+	 * When the expert mode is used to configure the bit-timing with
+	 * 'tq' and friends, the bitrate is provided by can_fixup_bittiming().
+	 * When the bitrate calculation is used, can_calc_bittiming() provides
+	 * 'tq' and friends. So in any case both values need to be not zero.
+	 */
+	if (!priv->bittiming.tq || !priv->bittiming.bitrate) {
+		netdev_err(dev, "incorrect/missing bit-timing\n");
 		return -EINVAL;
 	}
 
-- 
1.9.0

