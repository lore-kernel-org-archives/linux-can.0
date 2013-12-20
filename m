From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] can: ti_hecc: Use the OMAP2PLUS dependency for omap2plus devices
Date: Fri, 20 Dec 2013 09:21:50 -0300
Message-ID: <1387542110-26596-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39553 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756251Ab3LTMVi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2013 07:21:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

OMAP's ti_hecc driver is used to support the CAN controller on many
omap2plus SoCs (OMAP2430, OMAP3, OMAP4, OMAP5 and AM335x).
Constrain the driver to OMAP2PLUS, which is the super-set of all the
other SoCs variants.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 3c06947..f0b106b 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -71,7 +71,7 @@ config CAN_AT91
 	  and AT91SAM9X5 processors.
 
 config CAN_TI_HECC
-	depends on ARCH_OMAP3
+	depends on ARCH_OMAP2PLUS
 	tristate "TI High End CAN Controller"
 	---help---
 	  Driver for TI HECC (High End CAN Controller) module found on many
-- 
1.8.1.5

