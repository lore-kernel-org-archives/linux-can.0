Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392E4A2635;
	Wed,  2 Sep 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358579; cv=none; b=F2lBj5Ob4B4+NNgTJvoL7Pg/ydINia3vaFTl9WBY4Nya61dWtw44k0ks8POs5tSRodqQMQpPKZmoDs0Pv5PHu2rallfORPheFHUZ0jaiiiM7kP3XabfPFtTyF2t7+b1TznvRIWyz8/EhHrptboHVhDxtFge+g6iUqPH9t/QF4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358579; c=relaxed/simple;
	bh=tC7VaQNN9hlI33al52NTfppaebOFNfYClbwSPR+Khas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/fvdmCrlmQM/CKrcuxhzZJoZhzDAWhQNqmYYmihKmu0ZN8IuoDninKSV/XwKYluNSwiOT67W5xxf1Hy2Y1nrHSMUsjPdWzW1oExOreyH75Fg1pRIgsmPQdvQkddGitdVucnati4SECF2SVbdvaFMMNSkzOrIm2eBpViERkoKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0B1F000E9;
	Wed,  2 Sep 2026 14:16:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 7/7] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Date: Wed,  2 Sep 2026 17:15:44 +0300
Message-ID: <20260902141544.565763-8-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The two CAN FD channels available on the Renesas RZ/G3S SoC are routed
through the Renesas SMARC Carrier II board when used with the Renesas
RZ/G3S SMARC Module.

The CAN transceiver on the Carrier II board has its standby pins connected
to GPIOs that are selected through the SW_GPIO_CAN_PMOD switches. By
default, these switches route the GPIOs to the PMOD interfaces.

Enable the CAN FD controller and its two available channels.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags
- used ti,tcan1046 compatible
- adjusted the standby-gpio property along with CAN PHY node name and label
- adjusted the CAN channels phy phandles

Changes in v3:
- none

Changes in v2:
- collected tags

 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 +++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 45 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
index 9cccc87da057..d3fd18626773 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -41,4 +41,16 @@
  */
 #define SW_OPT_MUX4	SW_ON
 
+/*
+ * SW_GPIO_CAN_PMOD[x] switches' states:
+ * @SW_GPIO_CAN_PMOD1:
+ *	SW_OFF - GPIO8 connected to CAN0_STB (position 1-2)
+ *	SW_ON  - GPIO8 connected to PMOD1 (position 2-3)
+ * @SW_GPIO_CAN_PMOD2:
+ *	SW_OFF - GPIO9 connected to CAN1_STB (position 4-5)
+ *	SW_ON  - GPIO9 connected to PMOD1 (position 5-6)
+ */
+#define SW_GPIO_CAN_PMOD1	SW_ON
+#define SW_GPIO_CAN_PMOD2	SW_ON
+
 #endif /* __RZG3S_SMARC_SWITCHES_H__ */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index e3821d8c01e3..ef24b6cbd690 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -68,6 +68,23 @@ codec_dai: simple-audio-card,codec {
 		};
 	};
 
+	can_transceiver: can-phy {
+		compatible = "ti,tcan1046", "nxp,tja1048";
+		#phy-cells = <1>;
+		max-bitrate = <8000000>;
+		standby-gpios =
+#if SW_GPIO_CAN_PMOD1 == SW_OFF
+				<&pinctrl RZG2L_GPIO(13, 0) GPIO_ACTIVE_HIGH>,
+#else
+				<0>,
+#endif
+#if SW_GPIO_CAN_PMOD2 == SW_OFF
+				<&pinctrl RZG2L_GPIO(13, 1) GPIO_ACTIVE_HIGH>;
+#else
+				<0>;
+#endif
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
@@ -92,6 +109,22 @@ &audio_clk2 {
 	clock-frequency = <12288000>;
 };
 
+&canfd {
+	pinctrl-0 = <&canfd_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		phys = <&can_transceiver 0>;
+		status = "okay";
+	};
+
+	channel1 {
+		phys = <&can_transceiver 1>;
+		status = "okay";
+	};
+};
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -171,6 +204,18 @@ audio_clock_pins: audio-clock {
 		input-enable;
 	};
 
+	canfd_pins: canfd {
+		can0_pins: can0 {
+			pinmux = <RZG2L_PORT_PINMUX(6, 1, 3)>, /* CAN0_TX */
+				 <RZG2L_PORT_PINMUX(6, 2, 3)>; /* CAN0_RX */
+		};
+
+		can1_pins: can1 {
+			pinmux = <RZG2L_PORT_PINMUX(17, 0, 3)>, /* CAN1_TX */
+				 <RZG2L_PORT_PINMUX(17, 1, 3)>; /* CAN1_RX */
+		};
+	};
+
 	key-1-gpio-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
-- 
2.43.0

