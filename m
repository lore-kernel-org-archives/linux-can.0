From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 1/4] can: flexcan: use be32_to_cpup to handle the value of dt entry
Date: Wed, 27 Jun 2012 16:19:18 +0800
Message-ID: <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64221 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab2F0ITo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:19:44 -0400
In-Reply-To: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

The freescale arm i.MX series platform can support this driver, and
usually the arm cpu works in the little endian mode by default, while
device tree entry value is stored in big endian format, we should use
be32_to_cpup() to handle them, after modification, it can work well
both on the le cpu and be cpu.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 drivers/net/can/flexcan.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 38c0690..81d4741 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -939,12 +939,12 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		return PTR_ERR(pinctrl);
 
 	if (pdev->dev.of_node) {
-		const u32 *clock_freq_p;
+		const __be32 *clock_freq_p;
 
 		clock_freq_p = of_get_property(pdev->dev.of_node,
 						"clock-frequency", NULL);
 		if (clock_freq_p)
-			clock_freq = *clock_freq_p;
+			clock_freq = be32_to_cpup(clock_freq_p);
 	}
 
 	if (!clock_freq) {
-- 
1.7.6

