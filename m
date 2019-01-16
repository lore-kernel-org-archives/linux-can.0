From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 08/11] clk: renesas: r8a774c0: Add missing CANFD clock
Date: Wed, 16 Jan 2019 18:37:51 +0000
Message-ID: <1547663874-29411-9-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.orglinux-
List-Id: linux-can.vger.kernel.org

This patch adds the missing CANFD clock to the r8a774c0 specific
clock driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c       |  4 ++++
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h | 17 +++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 10b9689..28bcc81 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -33,6 +33,7 @@ enum clk_ids {
 	CLK_PLL1,
 	CLK_PLL3,
 	CLK_PLL0D4,
+	CLK_PLL0D6,
 	CLK_PLL0D8,
 	CLK_PLL0D20,
 	CLK_PLL0D24,
@@ -61,6 +62,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 
 	DEF_FIXED(".pll0",     CLK_PLL0,           CLK_MAIN,	   1, 100),
 	DEF_FIXED(".pll0d4",   CLK_PLL0D4,         CLK_PLL0,       4, 1),
+	DEF_FIXED(".pll0d6",   CLK_PLL0D6,         CLK_PLL0,       6, 1),
 	DEF_FIXED(".pll0d8",   CLK_PLL0D8,         CLK_PLL0,       8, 1),
 	DEF_FIXED(".pll0d20",  CLK_PLL0D20,        CLK_PLL0,      20, 1),
 	DEF_FIXED(".pll0d24",  CLK_PLL0D24,        CLK_PLL0,      24, 1),
@@ -112,6 +114,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 	DEF_GEN3_PE("s3d2c",   R8A774C0_CLK_S3D2C, CLK_S3, 2, CLK_PE, 2),
 	DEF_GEN3_PE("s3d4c",   R8A774C0_CLK_S3D4C, CLK_S3, 4, CLK_PE, 4),
 
+	DEF_DIV6P1("canfd",    R8A774C0_CLK_CANFD, CLK_PLL0D6, 0x244),
 	DEF_DIV6P1("csi0",     R8A774C0_CLK_CSI0,  CLK_PLL1D2, 0x00c),
 	DEF_DIV6P1("mso",      R8A774C0_CLK_MSO,   CLK_PLL1D2, 0x014),
 
@@ -187,6 +190,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("gpio2",		 910,	R8A774C0_CLK_S3D4),
 	DEF_MOD("gpio1",		 911,	R8A774C0_CLK_S3D4),
 	DEF_MOD("gpio0",		 912,	R8A774C0_CLK_S3D4),
+	DEF_MOD("can-fd",		 914,	R8A774C0_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774C0_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774C0_CLK_S3D4),
 	DEF_MOD("i2c6",			 918,	R8A774C0_CLK_S3D2),
diff --git a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
index 8fe51b6..f269ce3 100644
--- a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
@@ -48,13 +48,14 @@
 #define R8A774C0_CLK_ZA2		37
 #define R8A774C0_CLK_ZA8		38
 #define R8A774C0_CLK_Z2D		39
-#define R8A774C0_CLK_MSO		40
-#define R8A774C0_CLK_R			41
-#define R8A774C0_CLK_OSC		42
-#define R8A774C0_CLK_LV0		43
-#define R8A774C0_CLK_LV1		44
-#define R8A774C0_CLK_CSI0		45
-#define R8A774C0_CLK_CP			46
-#define R8A774C0_CLK_CPEX		47
+#define R8A774C0_CLK_CANFD		40
+#define R8A774C0_CLK_MSO		41
+#define R8A774C0_CLK_R			42
+#define R8A774C0_CLK_OSC		43
+#define R8A774C0_CLK_LV0		44
+#define R8A774C0_CLK_LV1		45
+#define R8A774C0_CLK_CSI0		46
+#define R8A774C0_CLK_CP			47
+#define R8A774C0_CLK_CPEX		48
 
 #endif /* __DT_BINDINGS_CLOCK_R8A774C0_CPG_MSSR_H__ */
-- 
2.7.4
