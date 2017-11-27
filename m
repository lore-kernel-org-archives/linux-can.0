From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH v2 1/2] can: mcba_usb: fix typo
Date: Mon, 27 Nov 2017 15:49:15 -0800
Message-ID: <20171127234916.25865-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:30880
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752635AbdK0XtZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 27 Nov 2017 18:49:25 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Martin Kelly <mkelly@xevo.com>

Fix typo "analizer" --> "Analyzer".

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/net/can/usb/mcba_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 7f0272558bef..c4355f0a20d5 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -862,7 +862,7 @@ static int mcba_usb_probe(struct usb_interface *intf,
 		goto cleanup_unregister_candev;
 	}
 
-	dev_info(&intf->dev, "Microchip CAN BUS analizer connected\n");
+	dev_info(&intf->dev, "Microchip CAN BUS Analyzer connected\n");
 
 	return 0;
 
-- 
2.11.0

