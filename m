From: Anton Glukhov <anton.a.glukhov@gmail.com>
Subject: [PATCH 3/3] ARM: dts: AM35x: Add hecc node
Date: Sun,  4 Oct 2015 22:59:39 +0300
Message-ID: <1443988779-19935-3-git-send-email-anton.a.glukhov@gmail.com>
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:36357 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbJDUAz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 Oct 2015 16:00:55 -0400
Received: by lacpo6 with SMTP id po6so3874573lac.3
        for <linux-can@vger.kernel.org>; Sun, 04 Oct 2015 13:00:54 -0700 (PDT)
In-Reply-To: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org, bcousson@baylibre.com
Cc: Anton Glukhov <anton.a.glukhov@gmail.com>

HECC node description for am35x SOCs

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
---
 arch/arm/boot/dts/am3517.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 5e3f5e8..cbd6d97 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -13,6 +13,7 @@
 / {
 	aliases {
 		serial3 = &uart4;
+		can = &hecc;
 	};
 
 	ocp {
@@ -70,6 +71,17 @@
 			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0xff1f>;
+
+		hecc: can@0x5c050000 {
+			compatible = "ti,am35x-hecc";
+			status = "disabled";
+			reg = <0x5c050000 0x4000>;
+			interrupts = <24>;
+			clocks = <&hecc_ck>;
+			ti,scc-ram-offset = <0x3000>;
+			ti,hecc-ram-offset = <0x3000>;
+			ti,mbx-offset = <0x2000>;
+			ti,int-line = <0>;
 		};
 	};
 };
-- 
1.9.1

