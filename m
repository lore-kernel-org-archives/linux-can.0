From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 2/4] softcan: update dead links.
Date: Mon, 13 Apr 2020 18:02:41 +0100
Message-ID: <20200413170241.13207-1-flameeyes@flameeyes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54017 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732285AbgDMRCs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Apr 2020 13:02:48 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>

BerliOS has not been operating for more than five years. linux-can appears
to have moved to GitHub.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/net/can/Kconfig         | 4 ++--
 drivers/net/can/softing/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 17c166cc8482..be1bcb012761 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -41,8 +41,8 @@ config CAN_SLCAN
 	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
 
 	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
-	  slcand) can be found in the can-utils at the SocketCAN SVN, see
-	  http://developer.berlios.de/projects/socketcan for details.
+	  slcand) can be found in the can-utils at the linux-can project, see
+	  https://github.com/linux-can/can-utils for details.
 
 	  The slcan driver supports up to 10 CAN netdevices by default which
 	  can be changed by the 'maxdev=xx' module option. This driver can
diff --git a/drivers/net/can/softing/Kconfig b/drivers/net/can/softing/Kconfig
index 0f1708f99308..70ca800c1bfa 100644
--- a/drivers/net/can/softing/Kconfig
+++ b/drivers/net/can/softing/Kconfig
@@ -24,7 +24,7 @@ config CAN_SOFTING_CS
 	  Support for PCMCIA cards from Softing Gmbh & some cards
 	  from Vector Gmbh.
 	  You need firmware for these, which you can get at
-	  http://developer.berlios.de/projects/socketcan/
+	  https://github.com/linux-can/can-firmware
 	  This version of the driver is written against
 	  firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
 	  In order to use the card as CAN device, you need the Softing generic
-- 
2.26.0
