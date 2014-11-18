From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/17] can: esd_usb2: fix memory leak on disconnect
Date: Tue, 18 Nov 2014 21:37:34 +0100
Message-ID: <1416343067-9810-5-git-send-email-mkl@pengutronix.de>
References: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

It seems struct esd_usb2 dev is not deallocated on disconnect. The patch adds
the missing deallocation.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Matthias Fuchs <matthias.fuchs@esd.eu>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index b7c9e8b11460..7a90075529c3 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -1143,6 +1143,7 @@ static void esd_usb2_disconnect(struct usb_interface *intf)
 			}
 		}
 		unlink_all_urbs(dev);
+		kfree(dev);
 	}
 }
 
-- 
2.1.3
