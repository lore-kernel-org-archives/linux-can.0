From: <ludovic.desroches@atmel.com>
Subject: [PATCH v2 2/2] can: Kconfig: CAN_AT91 depends on ARM
Date: Mon, 11 Mar 2013 18:26:04 +0100
Message-ID: <1363022764-7647-2-git-send-email-ludovic.desroches@atmel.com>
References: <1363022764-7647-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:54516 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3CKR1r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 13:27:47 -0400
In-Reply-To: <1363022764-7647-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, mkl@pengutronix.de, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

SAMA5D3 devices also embed CAN feature. Moreover if we want to produce a single
kernel image it is not useful to be too restrictive.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
Changes in v2:
- depends on ARM instead of ARCH_AT91 (compilation tested with
exynos4_defconfig and imx_v6_v7_defconfig)

 driver/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 9862b2e..e456b70 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -65,7 +65,7 @@ config CAN_LEDS
 
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
-	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
+	depends on ARM
 	---help---
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
-- 
1.7.11.3

