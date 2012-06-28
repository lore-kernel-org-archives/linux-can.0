From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 1/2] can: flexcan: use of_property_read_u32 to get DT entry value
Date: Thu, 28 Jun 2012 16:21:34 +0800
Message-ID: <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34237 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab2F1IVy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 04:21:54 -0400
In-Reply-To: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

of_property_read_u32() can auto handle endian problems, use this
function can make code clean and simple.

No need to check return value here since the following got value
check will handle this.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 drivers/net/can/flexcan.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 81d4741..f63f826 100644
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
1.7.6

