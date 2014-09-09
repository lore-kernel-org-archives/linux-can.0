From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 09/12] ARM: dts: am4372: Add control module syscon node
Date: Tue, 9 Sep 2014 17:55:31 +0300
Message-ID: <1410274534-22826-10-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60953 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756678AbaIIO4X (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Sep 2014 10:56:23 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Use syscon regmap to expose the Control module register space.
This register space is shared between many users e.g. DCAN, USB, display, etc.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index a705e50..d38a0ed 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -59,6 +59,11 @@
 		cache-level = <2>;
 	};
 
+	am43xx_control_module: control_module@4a002000 {
+		compatible = "syscon";
+		reg = <0x44e10000 0x7f4>;
+	};
+
 	am43xx_pinmux: pinmux@44e10800 {
 		compatible = "pinctrl-single";
 		reg = <0x44e10800 0x31c>;
-- 
1.8.3.2

