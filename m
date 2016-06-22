From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v2 1/2] can: rcar_canfd: Add Classical CAN only mode support
Date: Wed, 22 Jun 2016 13:31:46 +0100
Message-ID: <1466598707-44076-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mkl@pengutronix.de, wg@grandegger.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, chris.paterson2@renesas.com, socketcan@hartkopp.net, magnus.damm@gmail.com, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms@verge.net.au, ulrich.hecht+renesas@gmail.com, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

The controller can operate in one of the two global modes
 - CAN FD only mode (default)
 - Classical CAN (CAN2.0) only mode

This patch adds support for Classical CAN only mode. It can be enabled
by defining the optional device tree property "renesas,no-can-fd" of this
node.

Note: R-Car Gen3 h/w manual v0.51E shows bit6 of RSCFDnCFDGCFG as
reserved, which is incorrect. This bit is same as RSCFDnGCFG.

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-
 drivers/net/can/rcar/rcar_canfd.c                  | 355 ++++++++++++++-------
 2 files changed, 255 insertions(+), 121 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index d45182b..22a6f10 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -32,6 +32,12 @@ below properties.
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
 
+Optional property:
+The controller can operate in either CAN FD only mode (default) or
+Classical CAN only mode. The mode is global to both the channels. In order to
+enable the later, define the following optional property.
+ - renesas,no-can-fd: puts the controller in Classical CAN only mode.
+
 Example
 -------
 
@@ -63,12 +69,13 @@ SoC common .dtsi file:
 
 Board specific .dts file:
 
-E.g. below enables Channel 1 alone in the board.
+E.g. below enables Channel 1 alone in the board in Classical CAN only mode.
 
 &canfd {
-        pinctrl-0 = <&canfd1_pins>;
-        pinctrl-names = "default";
-        status = "okay";
+	pinctrl-0 = <&canfd1_pins>;
+	pinctrl-names = "default";
+	renesas,no-can-fd;
+	status = "okay";
 
 	channel1 {
 		status = "okay";
@@ -79,9 +86,9 @@ E.g. below enables Channel 0 alone in the board using External clock
 as fCAN clock.
 
 &canfd {
-        pinctrl-0 = <&canfd0_pins &can_clk_pins>;
-        pinctrl-names = "default";
-        status = "okay";
+	pinctrl-0 = <&canfd0_pins &can_clk_pins>;
+	pinctrl-names = "default";
+	status = "okay";
 
 	channel0 {
 		status = "okay";
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a39d922..6bcc474 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -16,8 +16,9 @@
  * mode, the controller acts as a CAN FD node that can also interoperate with
  * CAN 2.0 nodes.
  *
- * As of now, this driver does not support the Classical CAN (CAN 2.0) mode,
- * which is handled by a different register map compared to CAN FD only mode.
+ * To switch the controller to Classical CAN (CAN 2.0) only mode, add
+ * "renesas,no-can-fd" optional property to the device tree node. A h/w reset is
+ * also required to switch modes.
  *
  * Note: The h/w manual register naming convention is clumsy and not acceptable
  * to use as it is in the driver. However, those names are added as comments
@@ -48,15 +49,16 @@
 /* RSCFDnCFDGRMCFG */
 #define RCANFD_GRMCFG_RCMC		BIT(0)
 
-/* RSCFDnCFDGCFG */
-#define RCANFD_GCFG_CMPOC		BIT(5)
+/* RSCFDnCFDGCFG / RSCFDnGCFG */
+#define RCANFD_GCFG_EEFE		BIT(6)
+#define RCANFD_GCFG_CMPOC		BIT(5)	/* CAN FD only */
 #define RCANFD_GCFG_DCS			BIT(4)
 #define RCANFD_GCFG_DCE			BIT(1)
 #define RCANFD_GCFG_TPRI		BIT(0)
 
-/* RSCFDnCFDGCTR */
+/* RSCFDnCFDGCTR / RSCFDnGCTR */
 #define RCANFD_GCTR_TSRST		BIT(16)
-#define RCANFD_GCTR_CFMPOFIE		BIT(11)
+#define RCANFD_GCTR_CFMPOFIE		BIT(11)	/* CAN FD only */
 #define RCANFD_GCTR_THLEIE		BIT(10)
 #define RCANFD_GCTR_MEIE		BIT(9)
 #define RCANFD_GCTR_DEIE		BIT(8)
@@ -66,7 +68,7 @@
 #define RCANFD_GCTR_GMDC_GRESET		(0x1)
 #define RCANFD_GCTR_GMDC_GTEST		(0x2)
 
-/* RSCFDnCFDGSTS */
+/* RSCFDnCFDGSTS / RSCFDnGSTS */
 #define RCANFD_GSTS_GRAMINIT		BIT(3)
 #define RCANFD_GSTS_GSLPSTS		BIT(2)
 #define RCANFD_GSTS_GHLTSTS		BIT(1)
@@ -74,44 +76,50 @@
 /* Non-operational status */
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
-/* RSCFDnCFDGERFL */
+/* RSCFDnCFDGERFL / RSCFDnGERFL */
 #define RCANFD_GERFL_EEF1		BIT(17)
 #define RCANFD_GERFL_EEF0		BIT(16)
-#define RCANFD_GERFL_CMPOF		BIT(3)
+#define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
-#define RCANFD_GERFL_ERR(x)		((x) & (RCANFD_GERFL_EEF1 |\
-						RCANFD_GERFL_EEF0 |\
-						RCANFD_GERFL_MES |\
-						RCANFD_GERFL_CMPOF))
+#define RCANFD_GERFL_ERR(gpriv, x)	((x) & (RCANFD_GERFL_EEF1 |\
+					RCANFD_GERFL_EEF0 | RCANFD_GERFL_MES |\
+					(gpriv->fdmode ?\
+					 RCANFD_GERFL_CMPOF : 0)))
 
 /* AFL Rx rules registers */
 
-/* RSCFDnCFDGAFLCFG0 */
+/* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(n, x)	(((x) & 0xff) << (24 - n * 8))
 #define RCANFD_GAFLCFG_GETRNC(n, x)	(((x) >> (24 - n * 8)) & 0xff)
 
-/* RSCFDnCFDGAFLECTR */
+/* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(x)	((x) & 0x1f)
 
-/* RSCFDnCFDGAFLIDj */
+/* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
 
-/* RSCFDnCFDGAFLP1_j */
+/* RSCFDnCFDGAFLP1_j / RSCFDnGAFLP1_j */
 #define RCANFD_GAFLP1_GAFLFDP(x)	(1 << (x))
 
 /* Channel register bits */
 
-/* RSCFDnCFDCmNCFG */
+/* RSCFDnCmCFG - Classical CAN only */
+#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
+#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
+#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
+#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+
+/* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(x)		(((x) & 0x1f) << 24)
 #define RCANFD_NCFG_NTSEG1(x)		(((x) & 0x7f) << 16)
 #define RCANFD_NCFG_NSJW(x)		(((x) & 0x1f) << 11)
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
-/* RSCFDnCFDCmCTR */
+/* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
 #define RCANFD_CCTR_ERRD		BIT(23)
 #define RCANFD_CCTR_BOM_MASK		(0x3 << 21)
@@ -136,7 +144,7 @@
 #define RCANFD_CCTR_CHDMC_CRESET	(0x1)
 #define RCANFD_CCTR_CHDMC_CHLT		(0x2)
 
-/* RSCFDnCFDCmSTS */
+/* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
 #define RCANFD_CSTS_RECSTS		BIT(6)
 #define RCANFD_CSTS_TRMSTS		BIT(5)
@@ -149,7 +157,7 @@
 #define RCANFD_CSTS_TECCNT(x)		(((x) >> 24) & 0xff)
 #define RCANFD_CSTS_RECCNT(x)		(((x) >> 16) & 0xff)
 
-/* RSCFDnCFDCmERFL */
+/* RSCFDnCFDCmERFL / RSCFDnCmERFL */
 #define RCANFD_CERFL_ADERR		BIT(14)
 #define RCANFD_CERFL_B0ERR		BIT(13)
 #define RCANFD_CERFL_B1ERR		BIT(12)
@@ -239,14 +247,14 @@
 #define RCANFD_CFFDCSTS_CFBRS		BIT(1)
 #define RCANFD_CFFDCSTS_CFESI		BIT(0)
 
-/* This controller supports classical CAN only mode or CAN FD only mode. These
- * modes are supported in two separate set of register maps & names. However,
- * some of the register offsets are common for both modes. Those offsets are
- * listed below as Common registers.
+/* This controller supports either Classical CAN only mode or CAN FD only mode.
+ * These modes are supported in two separate set of register maps & names.
+ * However, some of the register offsets are common for both modes. Those
+ * offsets are listed below as Common registers.
  *
- * The CAN FD only specific registers are listed separately and their names
- * starts with RCANFD_F_xxx names. When classical CAN only specific registers
- * are added, those specific registers can be prefixed as RCANFD_C_xxx.
+ * The CAN FD only mode specific registers & Classical CAN only mode specific
+ * registers are listed separately. Their register names starts with
+ * RCANFD_F_xxx & RCANFD_C_xxx respectively.
  */
 
 /* Common registers */
@@ -353,7 +361,7 @@
 #define RCANFD_GTSTCTR			(0x046c)
 /* RSCFDnCFDGLOCKK / RSCFDnGLOCKK */
 #define RCANFD_GLOCKK			(0x047c)
-/* RSCFDnCFDGRMCFG / RSCFDnGRMCFG */
+/* RSCFDnCFDGRMCFG */
 #define RCANFD_GRMCFG			(0x04fc)
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
@@ -365,6 +373,46 @@
 /* RSCFDnCFDGAFLP1j / RSCFDnGAFLP1j */
 #define RCANFD_GAFLP1(offset, j)	((offset) + 0x0c + (0x10 * (j)))
 
+/* Classical CAN only mode register map */
+
+/* RSCFDnGAFLXXXj offset */
+#define RCANFD_C_GAFL_OFFSET		(0x0500)
+
+/* RSCFDnRMXXXq -> RCANFD_C_RMXXX(q) */
+#define RCANFD_C_RMID(q)		(0x0600 + (0x10 * (q)))
+#define RCANFD_C_RMPTR(q)		(0x0604 + (0x10 * (q)))
+#define RCANFD_C_RMDF0(q)		(0x0608 + (0x10 * (q)))
+#define RCANFD_C_RMDF1(q)		(0x060c + (0x10 * (q)))
+
+/* RSCFDnRFXXx -> RCANFD_C_RFXX(x) */
+#define RCANFD_C_RFOFFSET		(0x0e00)
+#define RCANFD_C_RFID(x)		(RCANFD_C_RFOFFSET + (0x10 * (x)))
+#define RCANFD_C_RFPTR(x)		(RCANFD_C_RFOFFSET + 0x04 + \
+					 (0x10 * (x)))
+#define RCANFD_C_RFDF(x, df)		(RCANFD_C_RFOFFSET + 0x08 + \
+					 (0x10 * (x)) + (0x04 * (df)))
+
+/* RSCFDnCFXXk -> RCANFD_C_CFXX(ch, k) */
+#define RCANFD_C_CFOFFSET		(0x0e80)
+#define RCANFD_C_CFID(ch, idx)		(RCANFD_C_CFOFFSET + (0x30 * (ch)) + \
+					 (0x10 * (idx)))
+#define RCANFD_C_CFPTR(ch, idx)		(RCANFD_C_CFOFFSET + 0x04 + \
+					 (0x30 * (ch)) + (0x10 * (idx)))
+#define RCANFD_C_CFDF(ch, idx, df)	(RCANFD_C_CFOFFSET + 0x08 + \
+					 (0x30 * (ch)) + (0x10 * (idx)) + \
+					 (0x04 * (df)))
+
+/* RSCFDnTMXXp -> RCANFD_C_TMXX(p) */
+#define RCANFD_C_TMID(p)		(0x1000 + (0x10 * (p)))
+#define RCANFD_C_TMPTR(p)		(0x1004 + (0x10 * (p)))
+#define RCANFD_C_TMDF0(p)		(0x1008 + (0x10 * (p)))
+#define RCANFD_C_TMDF1(p)		(0x100c + (0x10 * (p)))
+
+/* RSCFDnTHLACCm */
+#define RCANFD_C_THLACC(m)		(0x1800 + (0x04 * (m)))
+/* RSCFDnRPGACCr */
+#define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
+
 /* CAN FD mode specific regsiter map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
@@ -468,6 +516,7 @@ struct rcar_canfd_global {
 	struct clk *can_clk;		/* fCAN clock */
 	enum rcar_canfd_fcanclk fcan;	/* CANFD or Ext clock */
 	unsigned long channels_mask;	/* Enabled channels mask */
+	bool fdmode;			/* CAN FD or Classical CAN only mode */
 };
 
 /* CAN FD mode nominal rate constants */
@@ -496,6 +545,19 @@ static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* Classical CAN mode bitrate constants */
+static const struct can_bittiming_const rcar_canfd_bittiming_const = {
+	.name = RCANFD_DRV_NAME,
+	.tseg1_min = 4,
+	.tseg1_max = 16,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -593,8 +655,13 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
-	/* Set the controller into FD mode */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG, RCANFD_GRMCFG_RCMC);
+	/* Set the controller into appropriate mode */
+	if (gpriv->fdmode)
+		rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
+				   RCANFD_GRMCFG_RCMC);
+	else
+		rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
+				     RCANFD_GRMCFG_RCMC);
 
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS) {
@@ -624,8 +691,12 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 
 	/* Global configuration settings */
 
-	/* Truncate payload to configured message size RFPLS */
-	cfg = RCANFD_GCFG_CMPOC;
+	/* ECC Error flag Enable */
+	cfg = RCANFD_GCFG_EEFE;
+
+	if (gpriv->fdmode)
+		/* Truncate payload to configured message size RFPLS */
+		cfg |= RCANFD_GCFG_CMPOC;
 
 	/* Set External Clock if selected */
 	if (gpriv->fcan != RCANFD_CANFDCLK)
@@ -647,7 +718,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 					   u32 ch)
 {
 	u32 cfg;
-	int start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	if (ch == 0) {
@@ -667,19 +738,19 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 	/* Write number of rules for channel */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG0,
 			   RCANFD_GAFLCFG_SETRNC(ch, num_rules));
+	if (gpriv->fdmode)
+		offset = RCANFD_F_GAFL_OFFSET;
+	else
+		offset = RCANFD_C_GAFL_OFFSET;
 
 	/* Accept all IDs */
-	rcar_canfd_write(gpriv->base,
-			 RCANFD_GAFLID(RCANFD_F_GAFL_OFFSET, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
 	/* IDE or RTR is not considered for matching */
-	rcar_canfd_write(gpriv->base,
-			 RCANFD_GAFLM(RCANFD_F_GAFL_OFFSET, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
 	/* Any data length accepted */
-	rcar_canfd_write(gpriv->base,
-			 RCANFD_GAFLP0(RCANFD_F_GAFL_OFFSET, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
 	/* Place the msg in corresponding Rx FIFO entry */
-	rcar_canfd_write(gpriv->base,
-			 RCANFD_GAFLP1(RCANFD_F_GAFL_OFFSET, start),
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP1(offset, start),
 			 RCANFD_GAFLP1_GAFLFDP(ridx));
 
 	/* Disable write access to page */
@@ -697,7 +768,10 @@ static void rcar_canfd_configure_rx(struct rcar_canfd_global *gpriv, u32 ch)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	rfdc = 2;		/* b010 - 8 messages Rx FIFO depth */
-	rfpls = 7;		/* b111 - Max 64 bytes payload */
+	if (gpriv->fdmode)
+		rfpls = 7;	/* b111 - Max 64 bytes payload */
+	else
+		rfpls = 0;	/* b000 - Max 8 bytes payload */
 
 	cfg = (RCANFD_RFCC_RFIM | RCANFD_RFCC_RFDC(rfdc) |
 		RCANFD_RFCC_RFPLS(rfpls) | RCANFD_RFCC_RFIE);
@@ -718,16 +792,20 @@ static void rcar_canfd_configure_tx(struct rcar_canfd_global *gpriv, u32 ch)
 	cftml = 0;		/* 0th buffer */
 	cfm = 1;		/* b01 - Transmit mode */
 	cfdc = 2;		/* b010 - 8 messages Tx FIFO depth */
-	cfpls = 7;		/* b111 - Max 64 bytes payload */
+	if (gpriv->fdmode)
+		cfpls = 7;	/* b111 - Max 64 bytes payload */
+	else
+		cfpls = 0;	/* b000 - Max 8 bytes payload */
 
 	cfg = (RCANFD_CFCC_CFTML(cftml) | RCANFD_CFCC_CFM(cfm) |
 		RCANFD_CFCC_CFIM | RCANFD_CFCC_CFDC(cfdc) |
 		RCANFD_CFCC_CFPLS(cfpls) | RCANFD_CFCC_CFTXIE);
 	rcar_canfd_write(gpriv->base, RCANFD_CFCC(ch, RCANFD_CFFIFO_IDX), cfg);
 
-	/* Clear FD mode specific control/status register */
-	rcar_canfd_write(gpriv->base,
-			 RCANFD_F_CFFDCSTS(ch, RCANFD_CFFIFO_IDX), 0);
+	if (gpriv->fdmode)
+		/* Clear FD mode specific control/status register */
+		rcar_canfd_write(gpriv->base,
+				 RCANFD_F_CFFDCSTS(ch, RCANFD_CFFIFO_IDX), 0);
 }
 
 static void rcar_canfd_enable_global_interrupts(struct rcar_canfd_global *gpriv)
@@ -739,7 +817,8 @@ static void rcar_canfd_enable_global_interrupts(struct rcar_canfd_global *gpriv)
 
 	/* Global interrupts setup */
 	ctr = RCANFD_GCTR_MEIE;
-	ctr |= RCANFD_GCTR_CFMPOFIE;
+	if (gpriv->fdmode)
+		ctr |= RCANFD_GCTR_CFMPOFIE;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, ctr);
 }
@@ -790,6 +869,7 @@ static void rcar_canfd_disable_channel_interrupts(struct rcar_canfd_channel
 static void rcar_canfd_global_error(struct net_device *ndev)
 {
 	struct rcar_canfd_channel *priv = netdev_priv(ndev);
+	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct net_device_stats *stats = &ndev->stats;
 	u32 ch = priv->channel;
 	u32 gerfl, sts;
@@ -823,7 +903,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 					 sts & ~RCANFD_RFSTS_RFMLT);
 		}
 	}
-	if (gerfl & RCANFD_GERFL_CMPOF) {
+	if (gpriv->fdmode && gerfl & RCANFD_GERFL_CMPOF) {
 		/* Message Lost flag will be set for respective channel
 		 * when this condition happens with counters and flags
 		 * already updated.
@@ -1018,7 +1098,7 @@ static irqreturn_t rcar_canfd_global_interrupt(int irq, void *dev_id)
 
 		/* Global error interrupts */
 		gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-		if (RCANFD_GERFL_ERR(gerfl))
+		if (RCANFD_GERFL_ERR(gpriv, gerfl))
 			rcar_canfd_global_error(ndev);
 
 		/* Handle Rx interrupts */
@@ -1077,25 +1157,37 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	cfg = (RCANFD_NCFG_NTSEG1(tseg1) | RCANFD_NCFG_NBRP(brp) |
-	       RCANFD_NCFG_NSJW(sjw) | RCANFD_NCFG_NTSEG2(tseg2));
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		/* CAN FD only mode */
+		cfg = (RCANFD_NCFG_NTSEG1(tseg1) | RCANFD_NCFG_NBRP(brp) |
+		       RCANFD_NCFG_NSJW(sjw) | RCANFD_NCFG_NTSEG2(tseg2));
 
-	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-	netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-		   brp, sjw, tseg1, tseg2);
+		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
+			   brp, sjw, tseg1, tseg2);
 
-	/* Data bit timing settings */
-	brp = dbt->brp - 1;
-	sjw = dbt->sjw - 1;
-	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-	tseg2 = dbt->phase_seg2 - 1;
+		/* Data bit timing settings */
+		brp = dbt->brp - 1;
+		sjw = dbt->sjw - 1;
+		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+		tseg2 = dbt->phase_seg2 - 1;
 
-	cfg = (RCANFD_DCFG_DTSEG1(tseg1) | RCANFD_DCFG_DBRP(brp) |
-	       RCANFD_DCFG_DSJW(sjw) | RCANFD_DCFG_DTSEG2(tseg2));
+		cfg = (RCANFD_DCFG_DTSEG1(tseg1) | RCANFD_DCFG_DBRP(brp) |
+		       RCANFD_DCFG_DSJW(sjw) | RCANFD_DCFG_DTSEG2(tseg2));
 
-	rcar_canfd_write(priv->base, RCANFD_F_DCFG(ch), cfg);
-	netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-		   brp, sjw, tseg1, tseg2);
+		rcar_canfd_write(priv->base, RCANFD_F_DCFG(ch), cfg);
+		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
+			   brp, sjw, tseg1, tseg2);
+	} else {
+		/* Classical CAN only mode */
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+			RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+
+		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+		netdev_dbg(priv->ndev,
+			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
+			   brp, sjw, tseg1, tseg2);
+	}
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1233,27 +1325,37 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 	if (cf->can_id & CAN_RTR_FLAG)
 		id |= RCANFD_CFID_CFRTR;
 
-	rcar_canfd_write(priv->base,
-			 RCANFD_F_CFID(ch, RCANFD_CFFIFO_IDX), id);
 	dlc = RCANFD_CFPTR_CFDLC(can_len2dlc(cf->len));
-	rcar_canfd_write(priv->base,
-			 RCANFD_F_CFPTR(ch, RCANFD_CFFIFO_IDX), dlc);
 
-	if (can_is_canfd_skb(skb)) {
-		/* CAN FD frame format */
-		sts |= RCANFD_CFFDCSTS_CFFDF;
-		if (cf->flags & CANFD_BRS)
-			sts |= RCANFD_CFFDCSTS_CFBRS;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		rcar_canfd_write(priv->base,
+				 RCANFD_F_CFID(ch, RCANFD_CFFIFO_IDX), id);
+		rcar_canfd_write(priv->base,
+				 RCANFD_F_CFPTR(ch, RCANFD_CFFIFO_IDX), dlc);
 
-		if (priv->can.state == CAN_STATE_ERROR_PASSIVE)
-			sts |= RCANFD_CFFDCSTS_CFESI;
-	}
+		if (can_is_canfd_skb(skb)) {
+			/* CAN FD frame format */
+			sts |= RCANFD_CFFDCSTS_CFFDF;
+			if (cf->flags & CANFD_BRS)
+				sts |= RCANFD_CFFDCSTS_CFBRS;
 
-	rcar_canfd_write(priv->base, RCANFD_F_CFFDCSTS(ch, RCANFD_CFFIFO_IDX),
-			 sts);
+			if (priv->can.state == CAN_STATE_ERROR_PASSIVE)
+				sts |= RCANFD_CFFDCSTS_CFESI;
+		}
+
+		rcar_canfd_write(priv->base,
+				 RCANFD_F_CFFDCSTS(ch, RCANFD_CFFIFO_IDX), sts);
 
-	rcar_canfd_put_data(priv, cf,
-			    RCANFD_F_CFDF(ch, RCANFD_CFFIFO_IDX, 0));
+		rcar_canfd_put_data(priv, cf,
+				    RCANFD_F_CFDF(ch, RCANFD_CFFIFO_IDX, 0));
+	} else {
+		rcar_canfd_write(priv->base,
+				 RCANFD_C_CFID(ch, RCANFD_CFFIFO_IDX), id);
+		rcar_canfd_write(priv->base,
+				 RCANFD_C_CFPTR(ch, RCANFD_CFFIFO_IDX), dlc);
+		rcar_canfd_put_data(priv, cf,
+				    RCANFD_C_CFDF(ch, RCANFD_CFFIFO_IDX, 0));
+	}
 
 	priv->tx_len[priv->tx_head % RCANFD_FIFO_DEPTH] = cf->len;
 	can_put_echo_skb(skb, ndev, priv->tx_head % RCANFD_FIFO_DEPTH);
@@ -1280,47 +1382,61 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 	struct net_device_stats *stats = &priv->ndev->stats;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
-	u32 sts = 0, id, ptr;
+	u32 sts = 0, id, dlc;
 	u32 ch = priv->channel;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	id = rcar_canfd_read(priv->base, RCANFD_F_RFID(ridx));
-	ptr = rcar_canfd_read(priv->base, RCANFD_F_RFPTR(ridx));
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		id = rcar_canfd_read(priv->base, RCANFD_F_RFID(ridx));
+		dlc = rcar_canfd_read(priv->base, RCANFD_F_RFPTR(ridx));
 
-	sts = rcar_canfd_read(priv->base, RCANFD_F_RFFDSTS(ridx));
-	if (sts & RCANFD_RFFDSTS_RFFDF)
-		skb = alloc_canfd_skb(priv->ndev, &cf);
-	else
-		skb = alloc_can_skb(priv->ndev,
-				    (struct can_frame **)&cf);
+		sts = rcar_canfd_read(priv->base, RCANFD_F_RFFDSTS(ridx));
+		if (sts & RCANFD_RFFDSTS_RFFDF)
+			skb = alloc_canfd_skb(priv->ndev, &cf);
+		else
+			skb = alloc_can_skb(priv->ndev,
+					    (struct can_frame **)&cf);
+	} else {
+		id = rcar_canfd_read(priv->base, RCANFD_C_RFID(ridx));
+		dlc = rcar_canfd_read(priv->base, RCANFD_C_RFPTR(ridx));
+		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&cf);
+	}
 
 	if (!skb) {
 		stats->rx_dropped++;
 		return;
 	}
 
-	if (sts & RCANFD_RFFDSTS_RFFDF)
-		cf->len = can_dlc2len(RCANFD_RFPTR_RFDLC(ptr));
-	else
-		cf->len = get_can_dlc(RCANFD_RFPTR_RFDLC(ptr));
-
-	if (sts & RCANFD_RFFDSTS_RFESI) {
-		cf->flags |= CANFD_ESI;
-		netdev_dbg(priv->ndev, "ESI Error\n");
-	}
-
 	if (id & RCANFD_RFID_RFIDE)
 		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
 		cf->can_id = id & CAN_SFF_MASK;
 
-	if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-		cf->can_id |= CAN_RTR_FLAG;
-	} else {
-		if (sts & RCANFD_RFFDSTS_RFBRS)
-			cf->flags |= CANFD_BRS;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		if (sts & RCANFD_RFFDSTS_RFFDF)
+			cf->len = can_dlc2len(RCANFD_RFPTR_RFDLC(dlc));
+		else
+			cf->len = get_can_dlc(RCANFD_RFPTR_RFDLC(dlc));
+
+		if (sts & RCANFD_RFFDSTS_RFESI) {
+			cf->flags |= CANFD_ESI;
+			netdev_dbg(priv->ndev, "ESI Error\n");
+		}
+
+		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
+			cf->can_id |= CAN_RTR_FLAG;
+		} else {
+			if (sts & RCANFD_RFFDSTS_RFBRS)
+				cf->flags |= CANFD_BRS;
 
-		rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(ridx, 0));
+			rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(ridx, 0));
+		}
+	} else {
+		cf->len = get_can_dlc(RCANFD_RFPTR_RFDLC(dlc));
+		if (id & RCANFD_RFID_RFRTR)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			rcar_canfd_get_data(priv, cf, RCANFD_C_RFDF(ridx, 0));
 	}
 
 	/* Write 0xff to RFPC to increment the CPU-side
@@ -1428,13 +1544,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->can.clock.freq = fcan_freq;
 	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
-	priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
-	priv->can.data_bittiming_const =
-		&rcar_canfd_data_bittiming_const;
+	if (gpriv->fdmode) {
+		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
+		priv->can.data_bittiming_const =
+			&rcar_canfd_data_bittiming_const;
 
-	/* Controller starts in CAN FD only mode */
-	can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+		/* Controller starts in CAN FD only mode */
+		can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+	} else {
+		/* Controller starts in Classical CAN only mode */
+		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+	}
 
 	priv->can.do_set_mode = rcar_canfd_do_set_mode;
 	priv->can.do_get_berr_counter = rcar_canfd_get_berr_counter;
@@ -1482,6 +1604,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	struct device_node *of_child;
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
+	bool fdmode = true;			/* CAN FD only mode - default */
+
+	if (of_property_read_bool(pdev->dev.of_node, "renesas,no-can-fd"))
+		fdmode = false;			/* Classical CAN only mode */
 
 	of_child = of_get_child_by_name(pdev->dev.of_node, "channel0");
 	if (of_child && of_device_is_available(of_child))
@@ -1513,6 +1639,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 	gpriv->pdev = pdev;
 	gpriv->channels_mask = channels_mask;
+	gpriv->fdmode = fdmode;
 
 	/* Peripheral clock */
 	gpriv->clkp = devm_clk_get(&pdev->dev, "fck");
@@ -1623,8 +1750,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, gpriv);
-	dev_info(&pdev->dev, "global operational state (clk %d)\n",
-		 gpriv->fcan);
+	dev_info(&pdev->dev, "global operational state (clk %d, fdmode %d)\n",
+		 gpriv->fcan, gpriv->fdmode);
 	return 0;
 
 fail_channel:
-- 
1.9.1
