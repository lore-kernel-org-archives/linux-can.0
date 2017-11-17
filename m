From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/7] pinctrl: sh-pfc: r8a77995: Add CAN support
Date: Fri, 17 Nov 2017 11:41:23 +0100
Message-ID: <1510915289-15059-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-can.vger.kernel.org

This patch adds CAN[0-1] pinmux support to the r8a77995 SoC.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 89b7541..616854d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -1057,6 +1057,45 @@ static const unsigned int avb0_avtp_capture_b_mux[] = {
 	AVB0_AVTP_CAPTURE_B_MARK,
 };
 
+/* - CAN ------------------------------------------------------------------ */
+static const unsigned int can0_data_a_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 31),
+};
+static const unsigned int can0_data_a_mux[] = {
+	CAN0_TX_A_MARK, CAN0_RX_A_MARK,
+};
+static const unsigned int can0_data_b_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 5),
+};
+static const unsigned int can0_data_b_mux[] = {
+	CAN0_TX_B_MARK, CAN0_RX_B_MARK,
+};
+static const unsigned int can1_data_a_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(4, 30), RCAR_GP_PIN(4, 29),
+};
+static const unsigned int can1_data_a_mux[] = {
+	CAN1_TX_A_MARK, CAN1_RX_A_MARK,
+};
+static const unsigned int can1_data_b_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 6),
+};
+static const unsigned int can1_data_b_mux[] = {
+	CAN1_TX_B_MARK, CAN1_RX_B_MARK,
+};
+
+/* - CAN Clock -------------------------------------------------------------- */
+static const unsigned int can_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(5, 2),
+};
+static const unsigned int can_clk_mux[] = {
+	CAN_CLK_MARK,
+};
+
 /* - I2C -------------------------------------------------------------------- */
 static const unsigned int i2c0_pins[] = {
 	/* SCL, SDA */
@@ -1504,6 +1543,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb0_avtp_pps_b),
 	SH_PFC_PIN_GROUP(avb0_avtp_match_b),
 	SH_PFC_PIN_GROUP(avb0_avtp_capture_b),
+	SH_PFC_PIN_GROUP(can0_data_a),
+	SH_PFC_PIN_GROUP(can0_data_b),
+	SH_PFC_PIN_GROUP(can1_data_a),
+	SH_PFC_PIN_GROUP(can1_data_b),
+	SH_PFC_PIN_GROUP(can_clk),
 	SH_PFC_PIN_GROUP(i2c0),
 	SH_PFC_PIN_GROUP(i2c1),
 	SH_PFC_PIN_GROUP(i2c2_a),
@@ -1581,6 +1625,18 @@ static const char * const avb0_groups[] = {
 	"avb0_avtp_capture_b",
 };
 
+static const char * const can0_groups[] = {
+	"can0_data_a",
+	"can0_data_b",
+};
+static const char * const can1_groups[] = {
+	"can1_data_a",
+	"can1_data_b",
+};
+static const char * const can_clk_groups[] = {
+	"can_clk",
+};
+
 static const char * const i2c0_groups[] = {
 	"i2c0",
 };
@@ -1691,6 +1747,9 @@ static const char * const usb0_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb0),
+	SH_PFC_FUNCTION(can0),
+	SH_PFC_FUNCTION(can1),
+	SH_PFC_FUNCTION(can_clk),
 	SH_PFC_FUNCTION(i2c0),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
-- 
2.7.4
