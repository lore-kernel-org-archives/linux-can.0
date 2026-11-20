Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162129;
	b=hijqwKNdCRSo8qqBBIShLntOMhj+s2lcSexxawoCki9BWftB+95uwXSPbH3NnIP2uFc5
	 jIacjCX2ufNsnBo8P/1pkeoCbquu33M7vVb2+Yh0U37d6bCNoOie/SvIxUuZ36vJHc7tz
	 ctUIiUoQxcYRUt3aTR+VgbEj9CpCl+7xCp6YK+sQgDCtcTe1MFY0Bpt58x6ZJdd+65NUG
	 SRYIOgc2nDvQRsCiSSFmuS97lczHfUDp+H4jXBrHpRhAOQzkoLbYw6ApSLo6zpg1SQmgp
	 VZEJngOaVvQZ3jShwhM64VU+IO2PgA+qyFIXSAvqXNzK2pl74uUpoxdgj+mR6z3b5Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162129;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=cYchM3oZ++2Ujm+8cyxvkhBnotq5TY4DS45oyevJ/6I=;
	b=MlzOjoTyELfuFocFgBDsrDDxoPw1rzDPIkJKaEmePqnLTIS4m5JYMVQmuWt/907ja3DE
	 Iq6CRDG8l73F8hVXdsWyfHmQ69Csj8/IjZa8PKDKOMbwR1peAEHX6pJlWG9V1s75aZuhY
	 yBcSvAJmVWrkkVoREOdQFyEf33jFlWgDk+OX7tkXGcJg+2XBHiu9BeFgC4SwDVMi0bsat
	 I1z57ieUa0F+oYQFiqWg5nsoCHd9HUKdmyAz4d2+lRQbgEkUFz9QMH21nwy8vz1nTiix0
	 AbPM/SM0BTVUCdnka0uvT8/oTawX7aFh6TSVWLWQEoIW4IS1l/4vvQsVQr3BSHsw0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55A606A334;
	Fri, 20 Nov 2026 08:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E55A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 00:08:46 -0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-can@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 3/3] arm64: dts: amlogic: a9: add CAN controller node
Date: Fri, 20 Nov 2026 16:08:20 +0800
Message-ID: <20261120080820.3340646-4-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261120080820.3340646-1-zelong.dong@amlogic.com>
References: <20261120080820.3340646-1-zelong.dong@amlogic.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Zelong Dong <zelong.dong@amlogic.com>

Add the CAN controller node and its pinmux states to the Amlogic A9
SoC device tree. Enable the controller on the A311Y3 BY401 board.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 .../dts/amlogic/amlogic-a9-a311y3-by401.dts   |  7 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi   | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
index 503e38a29ce6..dffcdd4c35d0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
@@ -136,3 +136,10 @@ &spisg_e {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spisg_e_pins_z>;
 };
+
+&canbus {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-1 = <&can0_pins_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
index 509dd1c37a5d..7c3734c4d23f 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
@@ -605,6 +605,20 @@ spisg_e_pins_z: group-spisg-e-pins {
 						drive-strength-microamp = <3000>;
 					};
 				};
+
+				func-can0 {
+					can0_pins: group-can0-pins {
+						pinmux = <AML_PINMUX(AMLOGIC_GPIO_A, 18, 3)>,
+							 <AML_PINMUX(AMLOGIC_GPIO_A, 19, 3)>;
+						bias-disable;
+					};
+
+					can0_pins_sleep: group-can0-pins-sleep {
+						pinmux = <AML_PINMUX(AMLOGIC_GPIO_A, 18, 0)>,
+							 <AML_PINMUX(AMLOGIC_GPIO_A, 19, 0)>;
+						input-enable;
+					};
+				};
 			};
 
 			spisg_e: spi@50100 {
@@ -677,6 +691,17 @@ i2c8: i2c@3a4800 {
 				clocks = <&clkc_periphs CLKID_SYS_I2C_M_I>;
 				status = "disabled";
 			};
+
+			canbus: can@3a8000 {
+				compatible = "amlogic,a9-can";
+				reg = <0x0 0x3a8000 0x0 0x383c>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_CAN0_PE>,
+					 <&clkc_periphs CLKID_CAN0_FILTER>;
+				clock-names = "can_pe", "can_filter";
+				power-domains = <&pwrc PWRC_A9_CAN0_ID>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff800000 {
-- 
2.47.1

