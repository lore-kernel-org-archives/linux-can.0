From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 2/4] arm/dts: AM33XX: Add D_CAN device tree data
Date: Wed, 25 Jul 2012 11:53:35 +0530
Message-ID: <1343197417-27481-3-git-send-email-anilkumar@ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53852 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767Ab2GYGYK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Jul 2012 02:24:10 -0400
In-Reply-To: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Add Bosch D_CAN controller device tree data to AM33XX dtsi file
by adding d_can device node with all the necessary parameters.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9b974dc..2db2ffb 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -163,5 +163,10 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		dcan1: d_can@481D0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can1";
+		};
 	};
 };
-- 
1.7.9.5

