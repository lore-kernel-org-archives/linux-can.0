From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
Date: Wed, 18 Oct 2017 13:25:14 +0200
Message-ID: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp01.htp-tel.de ([212.59.41.8]:39105 "EHLO mxpout01.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753416AbdJRLZX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Oct 2017 07:25:23 -0400
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

The original author of the module left our company. Replaced the email
in the MODULE_AUTHOR() macro with a valid one.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index be928ce62d32..6183b7707ad7 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -2,6 +2,7 @@
  * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
+ * Copyright (C)      2017 Stefan Maetje <stefan.maetje@esd.eu>, esd gmbh
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published
@@ -26,7 +27,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>

-MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
+MODULE_AUTHOR("Stefan Maetje <stefan.maetje@esd.eu>");
 MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro
interfaces");
 MODULE_LICENSE("GPL v2");

-- 
2.11.0

