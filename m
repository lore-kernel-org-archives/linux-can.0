From: <ludovic.desroches@atmel.com>
Subject: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
Date: Fri, 8 Mar 2013 18:30:42 +0100
Message-ID: <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:1260 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933140Ab3CHRbt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 12:31:49 -0500
In-Reply-To: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, mkl@pengutronix.de, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

SAMA5D3 devices also embed CAN feature. Moreover if we want to produce a single
kernel image (at least for Atmel devices) it is not useful to be too
restrictive.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 9862b2e..27311c3 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -65,7 +65,7 @@ config CAN_LEDS
 
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
-	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
+	depends on ARCH_AT91
 	---help---
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
-- 
1.7.11.3

