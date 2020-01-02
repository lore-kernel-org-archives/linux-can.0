From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: gs_usb: gs_usb_probe(): use descriptors of current altsetting
Date: Thu,  2 Jan 2020 17:09:33 +0100
Message-ID: <20200102160934.1524-9-mkl@pengutronix.de>
References: <20200102160934.1524-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200102160934.1524-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Johan Hovold <johan@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Johan Hovold <johan@kernel.org>

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 2f74f6704c12..a4b4b742c80c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -918,7 +918,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     GS_USB_BREQ_HOST_FORMAT,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     hconf,
 			     sizeof(*hconf),
 			     1000);
@@ -941,7 +941,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     GS_USB_BREQ_DEVICE_CONFIG,
 			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     dconf,
 			     sizeof(*dconf),
 			     1000);
-- 
2.24.1
