Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D53E0234;
	Tue,  7 Jul 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419871; cv=none; b=fIv7KsQICEfvK/NDAyqD8RMa07YJrx/wH1hjzSbNEVFchVkbsYBtwpLc/dLlByxflOKXzaej+8L27XF0qnEOsdGvf9hWv2tjWtGo1IC5gu6mUjZgiMzrCgTMPmyOC4UA25xNf0wTEj99akR1pOeGodgi67fjTAwxvDI024pGTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419871; c=relaxed/simple;
	bh=5mUpocPjpC6daFLfX8N0a0kp2mHj3lKjSpJfrm9gFaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auAQe3BOPsnEVxOCoHORnko+5d+kNMbShtc9SZTqL8+wLKqL8aWt1Xt7jbbSNp5Xu8vKPoBWTtNrF5PhB/IcjSARNabO0L/zQSHdEfZW3UFq5G7NMbgDVcvBpuvAG7bdT91IWrOehB+j6Y1/bC3BleRgZT7esqt/VyT4LGs/bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF66E1F00A3D;
	Tue,  7 Jul 2026 10:24:25 +0000 (UTC)
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
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/8] clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
Date: Tue,  7 Jul 2026 13:24:11 +0300
Message-ID: <20260707102418.1646159-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 624fc5e6fb24..8d28f2d02064 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -77,6 +77,8 @@ enum clk_ids {
 	CLK_SEL_PLL4,
 	CLK_P1_DIV2,
 	CLK_P3_DIV2,
+	CLK_P4,
+	CLK_P4_DIV2,
 	CLK_SD0_DIV4,
 	CLK_SD1_DIV4,
 	CLK_SD2_DIV4,
@@ -171,6 +173,8 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 		    dtable_1_32, 0, 0, 0, NULL),
 	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
 		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_FIXED("P4", CLK_P4, CLK_PLL2_DIV2, 1, 5),
+	DEF_FIXED("P4_DIV2", CLK_P4_DIV2, CLK_P4, 1, 2),
 	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
 	DEF_FIXED("P5", R9A08G045_CLK_P5, CLK_PLL2_DIV2, 1, 4),
 	DEF_FIXED("ZT", R9A08G045_CLK_ZT, CLK_PLL3_DIV2_8, 1, 1),
@@ -274,6 +278,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
+	DEF_MOD("canfd_pclk",		R9A08G045_CANFD_PCLK, CLK_P4_DIV2, 0x594, 0,
+					MSTOP(BUS_MCPU2, BIT(9))),
+	DEF_MOD("canfd_clk_ram",	R9A08G045_CANFD_CLK_RAM, CLK_P4, 0x594, 1,
+					MSTOP(BUS_MCPU2, BIT(9))),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,
 					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
@@ -324,6 +332,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
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

