From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH 3/3] can: c_can: Enable clock before first use
Date: Thu, 20 Dec 2012 15:35:44 +0530
Message-ID: <3ce526df6a4f9e71f8b05132689db7426bae6bbb.1355996839.git.amit.virdi@st.com>
References: <cover.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:54346 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301Ab2LTKGP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 05:06:15 -0500
In-Reply-To: <cover.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com, Amit Virdi <amit.virdi@st.com>

Current implementation assumes clock to be always enabled. Instead,
explicitly enable device clock before usage.

Signed-off-by: Amit Virdi <amit.virdi@st.com>
Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 6e8dc56..d0bd6e6 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -194,6 +194,12 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare CAN clock\n");
+		goto exit_no_clk_en;
+	}
+
 	/* get the platform data */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -295,6 +301,8 @@ exit_iounmap:
 exit_release_mem:
 	release_mem_region(mem->start, resource_size(mem));
 exit_free_clk:
+	clk_disable_unprepare(clk);
+exit_no_clk_en:
 	clk_put(clk);
 exit:
 	dev_err(&pdev->dev, "probe failed\n");
-- 
1.8.0

