Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864E448D01;
	Tue, 14 Jul 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050415; cv=none; b=H0BTlHIgcrAVIEAVet4NXlJkqxSCjv0KK2EP160IC6f8wm8CdDo8x1LNZD5P6hAPcHIcXJRFSavTNqimFPzN+E5RUfbSILRMIsWl6R0o/yIyKLqfieGnJQfaPp7uncq7eOp0tMPGTBMYBBiMGUiBCq8QsU4Dd9RDfg0vdAQ+WQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050415; c=relaxed/simple;
	bh=fpnyT2P6jLx3GA1z2t3fW28sbeVdXN+YjwrNxL3NFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZegRmj1WLt5Hxk0tlHAZEPrlXrM2x/bRMb04l/0uCEsf+BMm5u7trH6lcfngD5PryifPygMswIuxd3m1syWLEiTOo3xraGUXsnpNzl7lndAW1n880nf7wZ/gEmJAPdqq1UcnQqlqVEhealeIWzi2rb9fJkQQKfc+RvLBf05hRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618041F00A3A;
	Tue, 14 Jul 2026 17:33:30 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 1/8] clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
Date: Tue, 14 Jul 2026 20:33:08 +0300
Message-ID: <20260714173315.1981708-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- used R9A08G045_CLK_P4 ID for P4 clock
- still collected the tags; Biju, Geert, please let me know if you consider
  otherwise

 drivers/clk/renesas/r9a08g045-cpg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 624fc5e6fb24..ea2a6a71aebd 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -77,6 +77,7 @@ enum clk_ids {
 	CLK_SEL_PLL4,
 	CLK_P1_DIV2,
 	CLK_P3_DIV2,
+	CLK_P4_DIV2,
 	CLK_SD0_DIV4,
 	CLK_SD1_DIV4,
 	CLK_SD2_DIV4,
@@ -172,6 +173,8 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
 		    dtable_1_32, 0, 0, 0, NULL),
 	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
+	DEF_FIXED("P4", R9A08G045_CLK_P4, CLK_PLL2_DIV2, 1, 5),
+	DEF_FIXED("P4_DIV2", CLK_P4_DIV2, R9A08G045_CLK_P4, 1, 2),
 	DEF_FIXED("P5", R9A08G045_CLK_P5, CLK_PLL2_DIV2, 1, 4),
 	DEF_FIXED("ZT", R9A08G045_CLK_ZT, CLK_PLL3_DIV2_8, 1, 1),
 	DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
@@ -274,6 +277,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
+	DEF_MOD("canfd_pclk",		R9A08G045_CANFD_PCLK, CLK_P4_DIV2, 0x594, 0,
+					MSTOP(BUS_MCPU2, BIT(9))),
+	DEF_MOD("canfd_clk_ram",	R9A08G045_CANFD_CLK_RAM, R9A08G045_CLK_P4, 0x594, 1,
+					MSTOP(BUS_MCPU2, BIT(9))),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,
 					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
@@ -324,6 +331,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SCIF3_RST_SYSTEM_N, 0x884, 3),
 	DEF_RST(R9A08G045_SCIF4_RST_SYSTEM_N, 0x884, 4),
 	DEF_RST(R9A08G045_SCIF5_RST_SYSTEM_N, 0x884, 5),
+	DEF_RST(R9A08G045_CANFD_RSTP_N, 0x894, 0),
+	DEF_RST(R9A08G045_CANFD_RSTC_N, 0x894, 1),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
-- 
2.43.0

