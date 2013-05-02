From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, RFC 01/22] can: move CONFIG_HAVE_CAN_FLEXCAN out of CAN_DEV
Date: Thu,  2 May 2013 17:16:05 +0200
Message-ID: <1367507786-505303-2-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49626 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555Ab3EBPQg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 11:16:36 -0400
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

CONFIG_HAVE_CAN_FLEXCAN is a silect symbol that is meant to be selected
by platforms that support this driver, but that is not possible without
also selecting CAN_DEV, unless we move it out of the "if CAN_DEV"
section of the Kconfig file.

warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 &&
 IMX_HAVE_PLATFORM_FLEXCAN && SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
 which has unmet direct dependencies (NET && CAN && CAN_DEV)

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e456b70..3941a7d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -29,6 +29,9 @@ config CAN_SLCAN
 	  can be changed by the 'maxdev=xx' module option. This driver can
 	  also be built as a module. If so, the module will be called slcan.
 
+config HAVE_CAN_FLEXCAN
+	bool
+
 config CAN_DEV
 	tristate "Platform CAN drivers with Netlink support"
 	default y
@@ -102,9 +105,6 @@ config CAN_JANZ_ICAN3
 	  This driver can also be built as a module. If so, the module will be
 	  called janz-ican3.ko.
 
-config HAVE_CAN_FLEXCAN
-	bool
-
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on HAVE_CAN_FLEXCAN
-- 
1.8.1.2

