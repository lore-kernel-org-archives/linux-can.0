From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: mcba_usb: fix typo
Date: Fri,  1 Dec 2017 15:17:38 +0100
Message-ID: <20171201141739.5816-9-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Martin Kelly <mkelly@xevo.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Martin Kelly <mkelly@xevo.com>

Fix typo "analizer" --> "Analyzer".

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.15.0
