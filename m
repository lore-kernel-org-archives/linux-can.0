From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 0/4] URB disconnect bug fixes
Date: Tue,  5 Dec 2017 11:15:46 -0800
Message-ID: <20171205191550.703-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:29120
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751286AbdLETQG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 5 Dec 2017 14:16:06 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>, Jimmy Assarsson <jimmyassarsson@gmail.com>, Martin Kelly <mkelly@xevo.com>

This patch series is to fix a common bug I found in mcba_usb that appears to
also exist in these drivers. Because I don't own the hardware, I cannot test the
changes, but I wanted to send the change so that others could do so.

The bug is that, when you disconnect the device, you get -EPIPE and -EPROTO
error codes (exactly which depends on the timing and the system) in the URB read
callback. The driver then resubmits the URB, which immediately fails because the
device is unplugged. On a slower system like a Raspberry Pi, this can cause a
kernel stall, while on a desktop, the disconnect code runs fast enough to
prevent a stall and it's easy not to notice the issue.

Fix this by not resubmitting an URB that receives an -EPIPE/-EPROTO code.

Martin Kelly (4):
  can: ems_usb: cancel urb on -EPIPE and -EPROTO
  can: esd_usb2: cancel urb on -EPIPE and -EPROTO
  can: kvaser_usb: cancel urb on -EPIPE and -EPROTO
  can: usb_8dev: cancel urb on -EPIPE and -EPROTO

 drivers/net/can/usb/ems_usb.c    | 2 ++
 drivers/net/can/usb/esd_usb2.c   | 2 ++
 drivers/net/can/usb/kvaser_usb.c | 2 ++
 drivers/net/can/usb/usb_8dev.c   | 2 ++
 4 files changed, 8 insertions(+)

--
2.11.0

