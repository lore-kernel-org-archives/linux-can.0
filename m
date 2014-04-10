From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 3/3] can: usb: Kconfig: Improve help for CAN_KVASER_USB
Date: Thu, 10 Apr 2014 21:44:23 +0200
Message-ID: <1397159063-12790-3-git-send-email-olivier@sobrie.be>
References: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:38855 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935232AbaDJTqV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Apr 2014 15:46:21 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3441032eei.28
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 12:46:20 -0700 (PDT)
In-Reply-To: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

Add two new USB devices supported by the driver and fix bad
english.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index fc96a3d..0b918eb 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -19,7 +19,7 @@ config CAN_KVASER_USB
 	  This driver adds support for Kvaser CAN/USB devices like Kvaser
 	  Leaf Light.
 
-	  The driver gives support for the following devices:
+	  The driver provides support for the following devices:
 	    - Kvaser Leaf Light
 	    - Kvaser Leaf Professional HS
 	    - Kvaser Leaf SemiPro HS
@@ -36,6 +36,8 @@ config CAN_KVASER_USB
 	    - Kvaser Leaf Light "China"
 	    - Kvaser BlackBird SemiPro
 	    - Kvaser USBcan R
+	    - Kvaser Leaf Light v2
+	    - Kvaser Mini PCI Express HS
 
 	  If unsure, say N.
 
-- 
1.9.0

