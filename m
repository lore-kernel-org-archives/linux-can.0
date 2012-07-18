From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] ARM i.MX53: register CAN clocks
Date: Wed, 18 Jul 2012 11:42:42 +0200
Message-ID: <1342604563-18915-2-git-send-email-mkl@pengutronix.de>
References: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56684 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2GRJnO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:43:14 -0400
In-Reply-To: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Sascha Hauer <s.hauer@pengutronix.de>

On the imx53, the flexcan core has two clocks, the ipg and the per clock.
This patch adds these clocks for both flexcans on the imx53.

An updated flexcan driver, taking advantage of these clocks, is currently
in the review process.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index a2200c7..37eb420 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -49,6 +49,7 @@ static const char *mx53_tve_ext_sel[] = { "pll4_sw", "ckih1", };
 static const char *tve_sel[] = { "tve_pred", "tve_ext_sel", };
 static const char *ipu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
 static const char *vpu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
+static const char *mx53_can_sel[] = { "ipg", "ckih1", "ckih2", "lp_apm", };
 
 enum imx5_clks {
 	dummy, ckil, osc, ckih1, ckih2, ahb, ipg, axi_a, axi_b, uart_pred,
@@ -81,6 +82,7 @@ enum imx5_clks {
 	ssi1_root_podf, ssi2_root_pred, ssi2_root_podf, ssi_ext1_pred,
 	ssi_ext1_podf, ssi_ext2_pred, ssi_ext2_podf, ssi1_root_gate,
 	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
+	can_sel, can1_serial_gate, can1_ipg_gate,
 	clk_max
 };
 
@@ -411,8 +413,12 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk[esdhc4_per_gate] = imx_clk_gate2("esdhc4_per_gate", "esdhc_d_sel", MXC_CCM_CCGR3, 14);
 	clk[usb_phy1_gate] = imx_clk_gate2("usb_phy1_gate", "usb_phy_sel", MXC_CCM_CCGR4, 10);
 	clk[usb_phy2_gate] = imx_clk_gate2("usb_phy2_gate", "usb_phy_sel", MXC_CCM_CCGR4, 12);
-	clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate", "ipg", MXC_CCM_CCGR4, 6);
-	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 8);
+	clk[can_sel] = imx_clk_mux("can_sel", MXC_CCM_CSCMR2, 6, 2,
+				mx53_can_sel, ARRAY_SIZE(mx53_can_sel));
+	clk[can1_serial_gate] = imx_clk_gate2("can1_serial_gate", "can_sel", MXC_CCM_CCGR6, 22);
+	clk[can1_ipg_gate] = imx_clk_gate2("can1_ipg_gate", "ipg", MXC_CCM_CCGR6, 20);
+	clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate", "can_sel", MXC_CCM_CCGR4, 8);
+	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 6);
 	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
@@ -445,6 +451,10 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
+	clk_register_clkdev(clk[can1_ipg_gate], "ipg", "53fc8000.can");
+	clk_register_clkdev(clk[can1_serial_gate], "per", "53fc8000.can");
+	clk_register_clkdev(clk[can2_ipg_gate], "ipg", "53fcc000.can");
+	clk_register_clkdev(clk[can2_serial_gate], "per", "53fcc000.can");
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[esdhc_a_podf], 200000000);
-- 
1.7.10.4

