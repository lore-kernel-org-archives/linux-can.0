From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
Date: Mon,  7 May 2012 08:53:58 +0800
Message-ID: <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33196 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab2EGAyD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 May 2012 20:54:03 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so591064dad.19
        for <linux-can@vger.kernel.org>; Sun, 06 May 2012 17:54:02 -0700 (PDT)
In-Reply-To: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/net/can/flexcan.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1efb083..38c0690 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DRV_NAME			"flexcan"
 
@@ -927,11 +928,16 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	struct flexcan_priv *priv;
 	struct resource *mem;
 	struct clk *clk = NULL;
+	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t mem_size;
 	int err, irq;
 	u32 clock_freq = 0;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
+
 	if (pdev->dev.of_node) {
 		const u32 *clock_freq_p;
 
-- 
1.7.5.4

