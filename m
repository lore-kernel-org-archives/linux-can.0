From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH] can: flexcan: use of_property_read_u32 to avoid endian problem
Date: Thu, 28 Jun 2012 10:58:57 +0800
Message-ID: <1340852337-19840-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54390 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab2F1C7M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 22:59:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org, wg@grandegger.com
Cc: linux-can@vger.kernel.org

Use of_property_read_u32() to get DT value can avoid endian problems,
this is needed since this driver can run on powerpc (be) and arm (le).

No need to check ret value here since we will check the got value to
verify if users pass a valid value in the DT.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
This is the patch to replace the one "can: flexcan: use be32_to_cpup
to handle the value of dt entry", if you already applied that patch
and can't revert, please ignore this patch and let me know,i will
prepare an incremental patch basing on that one.

 drivers/net/can/flexcan.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 38c0690..f63f826 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -938,14 +938,9 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl))
 		return PTR_ERR(pinctrl);
 
-	if (pdev->dev.of_node) {
-		const u32 *clock_freq_p;
-
-		clock_freq_p = of_get_property(pdev->dev.of_node,
-						"clock-frequency", NULL);
-		if (clock_freq_p)
-			clock_freq = *clock_freq_p;
-	}
+	if (pdev->dev.of_node)
+		of_property_read_u32(pdev->dev.of_node,
+						"clock-frequency", &clock_freq);
 
 	if (!clock_freq) {
 		clk = clk_get(&pdev->dev, NULL);
-- 
1.7.6

