From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: ems_usb: cancel urb on -EPIPE and -EPROTO
Date: Fri,  8 Dec 2017 16:58:13 +0100
Message-ID: <20171208155817.9364-3-mkl@pengutronix.de>
References: <20171208155817.9364-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41527 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754536AbdLHP60 (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 8 Dec 2017 10:58:26 -0500
In-Reply-To: <20171208155817.9364-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Martin Kelly <mkelly@xevo.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Martin Kelly <mkelly@xevo.com>

In mcba_usb, we have observed that when you unplug the device, the driver will
endlessly resubmit failing URBs, which can cause CPU stalls. This issue
is fixed in mcba_usb by catching the codes seen on device disconnect
(-EPIPE and -EPROTO).

This driver also resubmits in the case of -EPIPE and -EPROTO, so fix it
in the same way.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index b3d02759c226..b00358297424 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -288,6 +288,8 @@ static void ems_usb_read_interrupt_callback(struct urb *urb)
 
 	case -ECONNRESET: /* unlink */
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
-- 
2.15.0

