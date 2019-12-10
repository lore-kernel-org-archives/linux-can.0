From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] can: gs_usb: use descriptors of current altsetting
Date: Tue, 10 Dec 2019 12:32:31 +0100
Message-ID: <20191210113231.3797-3-johan@kernel.org>
References: <20191210113231.3797-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210113231.3797-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-can.vger.kernel.org

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
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
2.24.0
