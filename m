Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D233E2768;
	Tue,  7 Jul 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419902; cv=none; b=Lc3ssc97N5GHW3y2NrtVRcbPTOO2MduN/PxfWidfHEP7fUArypsfj/e7dbAQ9X8AsPV9+8RJIGLeWJdZUTtKeknlC8hABxL+dTHW7LFeG4Q7YvbrPukZ4Ldy9ewJBDT1wXnp2di1Jivh0DfJNhawhIfyykuY42fn9hA7IHEIaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419902; c=relaxed/simple;
	bh=Bf9n4g7Nb0yfZEVNcSCDaR0vz5U63uuyFbZ9NcNtKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAXPdcv0kSwox5sdeNqescpcBNWNvI3su4rNnqwnLjDKPOEr1mvFTQaDmD4R1l1xq075dh6HG6zXwM32XeibodqsbmwPh6B1MeB9E0hiRfv00Xuhmn9E/7gN5sB0OvKAJkJeWlBT8xmrXqyZHtu/DLolfiNhpHgFICgGnhJWRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14571F000E9;
	Tue,  7 Jul 2026 10:24:56 +0000 (UTC)
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
Subject: [PATCH 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Date: Tue,  7 Jul 2026 13:24:18 +0300
Message-ID: <20260707102418.1646159-9-claudiu.beznea+renesas@tuxon.dev>
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

The two CAN FD channels available on the Renesas RZ/G3S SoC are routed
through the Renesas SMARC Carrier II board when used with the Renesas
RZ/G3S SMARC Module.

The CAN transceiver on the Carrier II board has its standby pins connected
to GPIOs that are selected through the SW_GPIO_CAN_PMOD switches. By
default, these switches route the GPIOs to the PMOD interfaces.

Enable the CAN FD controller and its two available channels.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 +++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
index bbf908a5322c..198874ad9a65 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -37,4 +37,16 @@
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
index 70af605168b0..2be684f55914 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -68,6 +68,24 @@ codec_dai: simple-audio-card,codec {
 		};
 	};
 
+	can_transceiver0: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+#if SW_GPIO_CAN_PMOD1 == SW_OFF
+		standby-gpios = <&pinctrl RZG2L_GPIO(13, 0) GPIO_ACTIVE_HIGH>;
+#endif
+	};
+
+	can_transceiver1: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+#if SW_GPIO_CAN_PMOD2 == SW_OFF
+		standby-gpios = <&pinctrl RZG2L_GPIO(13, 1) GPIO_ACTIVE_HIGH>;
+#endif
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
@@ -92,6 +110,22 @@ &audio_clk2 {
 	clock-frequency = <12288000>;
 };
 
+&canfd {
+	pinctrl-0 = <&canfd_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		phys = <&can_transceiver0>;
+		status = "okay";
+	};
+
+	channel1 {
+		phys = <&can_transceiver1>;
+		status = "okay";
+	};
+};
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -171,6 +205,18 @@ audio_clock_pins: audio-clock {
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

