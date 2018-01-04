From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/4] can: gs_usb: fix return value of the "set_bittiming" callback
Date: Thu,  4 Jan 2018 16:33:53 +0100
Message-ID: <20180104153355.11243-3-mkl@pengutronix.de>
References: <20180104153355.11243-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52851 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753370AbeADPeN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 10:34:13 -0500
In-Reply-To: <20180104153355.11243-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Wolfgang Grandegger <wg@grandegger.com>

The "set_bittiming" callback treats a positive return value as error!
For that reason "can_changelink()" will quit silently after setting
the bittiming values without processing ctrlmode, restart-ms, etc.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 68ac3e88a8ce..8bf80ad9dc44 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -449,7 +449,7 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 		dev_err(netdev->dev.parent, "Couldn't set bittimings (err=%d)",
 			rc);
 
-	return rc;
+	return (rc > 0) ? 0 : rc;
 }
 
 static void gs_usb_xmit_callback(struct urb *urb)
-- 
2.15.1

