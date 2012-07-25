From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/4] arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
Date: Wed, 25 Jul 2012 11:53:36 +0530
Message-ID: <1343197417-27481-4-git-send-email-anilkumar@ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55464 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767Ab2GYGYN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Jul 2012 02:24:13 -0400
In-Reply-To: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Add D_CAN1 pinctrl node to am3358_pinmux master node to export
D_CAN functionality on AM335x EVM according to pinctrl-single
driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e4e1ccb..7f0fd6c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -46,3 +46,16 @@
 	regulator-boot-on;
 	regulator-always-on;
 };
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&d_can1_pins>;
+
+	d_can1_pins: pinmux_d_can_pins {
+		pinctrl-single,pins = <
+			0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
+			0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
+		>;
+	};
+};
-- 
1.7.9.5

