From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] can: gs_usb: fix return value of the "set_bittiming" callback
Date: Wed, 13 Dec 2017 19:52:23 +0100
Message-ID: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:40136 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdLMSwZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Dec 2017 13:52:25 -0500
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Maximilian Schneider <max@schneidersoft.net>

The "set_bittiming" callback treats a positive return value as error!
For that reason "can_changelink()" will quit silently after setting
the bittiming values without processing ctrlmode, restart-ms, etc.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 68ac3e8..52907d4 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -449,7 +449,7 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 		dev_err(netdev->dev.parent, "Couldn't set bittimings (err=%d)",
 			rc);
 
-	return rc;
+	return rc < 0 ? rc : 0;
 }
 
 static void gs_usb_xmit_callback(struct urb *urb)
-- 
2.7.4

