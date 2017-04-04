From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PATCH v4 6/6] ARM: dts: sun7i: Add can0_pins_a pinctrl settings
Date: Tue,  4 Apr 2017 20:36:32 +0200
Message-ID: <1491330992-9876-7-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:53530 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755364AbdDDShA (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 Apr 2017 14:37:00 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 63F5020E5C
        for <linux-can@vger.kernel.org>; Tue,  4 Apr 2017 20:36:59 +0200 (CEST)
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc: Patrick Menschel <menschel.p@posteo.de>

The A20 SoC has an on-board CAN controller. This patch adds
the pinctrl settings for pins PH20 and PH21.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index edf85ca..31aaa02 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1096,6 +1096,11 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			can0_pins_a: can0@0 {
+				pins = "PH20", "PH21";
+				function = "can";
+			};
+
 			clk_out_a_pins_a: clk_out_a@0 {
 				pins = "PI12";
 				function = "clk_out_a";
-- 
2.7.4

