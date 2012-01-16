From: Steven Miao <realmz6@gmail.com>
Subject: [PATCH] socket-can: bit-timing calculation
Date: Mon, 16 Jan 2012 18:50:24 +0800
Message-ID: <1326711025-6629-1-git-send-email-realmz6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:42379 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab2APKpJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2012 05:45:09 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: Steven Miao <realmz6@gmail.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

just use first found best bit rate prescaler

Signed-off-by: Steven Miao <realmz6@gmail.com>
---
 drivers/net/can/dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 25695bd..9d4afe6 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -106,7 +106,7 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 		/* tseg brp biterror */
 		if (error < 0)
 			error = -error;
-		if (error > best_error)
+		if (error >= best_error)
 			continue;
 		best_error = error;
 		if (error == 0) {
-- 
1.7.0.4


