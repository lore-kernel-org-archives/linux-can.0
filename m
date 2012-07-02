From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] can: flexcan: use of_property_read_u32 to get DT entry value
Date: Mon,  2 Jul 2012 14:40:24 +0200
Message-ID: <1341232825-4604-6-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57326 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GBMkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:32 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Hui Wang <jason77.wang@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

From: Hui Wang <jason77.wang@gmail.com>

of_property_read_u32() can auto handle endian problems, use this
function can make code clean and simple.

No need to check return value here since the following got value
check will handle this.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f88cd3..b429b3f 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -938,14 +938,9 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl))
 		return PTR_ERR(pinctrl);
 
-	if (pdev->dev.of_node) {
-		const __be32 *clock_freq_p;
-
-		clock_freq_p = of_get_property(pdev->dev.of_node,
-						"clock-frequency", NULL);
-		if (clock_freq_p)
-			clock_freq = be32_to_cpup(clock_freq_p);
-	}
+	if (pdev->dev.of_node)
+		of_property_read_u32(pdev->dev.of_node,
+						"clock-frequency", &clock_freq);
 
 	if (!clock_freq) {
 		clk = clk_get(&pdev->dev, NULL);
-- 
1.7.10

