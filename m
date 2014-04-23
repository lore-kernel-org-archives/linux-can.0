From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: fix return value from can_get_bittiming()
Date: Wed, 23 Apr 2014 22:10:55 +0200
Message-ID: <1398283855-14725-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:49380 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757564AbaDWULK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Apr 2014 16:11:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

When trying to set a data bitrate on non CAN FD devices the 'ip' tool
answers with:

	RTNETLINK answers: Unknown error 524

Rename '-ENOTSUPP' to '-EOPNOTSUPP' so that 'ip' answers correctly:

       RTNETLINK answers: Operation not supported

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c7a2604..e318e87 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -256,7 +256,7 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
 
 	/* Check if the CAN device has bit-timing parameters */
 	if (!btc)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/*
 	 * Depending on the given can_bittiming parameter structure the CAN
-- 
1.9.2

