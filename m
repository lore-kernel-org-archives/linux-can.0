From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] arm: mxs: enable flexcan on imx28
Date: Sun,  1 Jul 2012 22:46:05 +0200
Message-ID: <1341175565-13218-3-git-send-email-mkl@pengutronix.de>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51209 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab2GAUqN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 16:46:13 -0400
In-Reply-To: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 91cf062..ccdf83b 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -16,6 +16,7 @@ config SOC_IMX28
 	bool
 	select ARM_AMBA
 	select CPU_ARM926T
+	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_PWM
 	select PINCTRL_IMX28
 
-- 
1.7.10

