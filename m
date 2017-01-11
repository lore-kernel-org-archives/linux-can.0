From: yegorslists@googlemail.com
Subject: [PATCH v2 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Wed, 11 Jan 2017 15:05:20 +0100
Message-ID: <1484143521-4898-3-git-send-email-yegorslists@googlemail.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34082 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757114AbdAKOFs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2017 09:05:48 -0500
In-Reply-To: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, jean-michel.hautbois@vodalys.com, andrej.skvortzov@gmail.com, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>

From: Anton Glukhov <anton.a.glukhov@gmail.com>

DT binding documentation for TI High End CAN Controller

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
Changes v1 -> v2:
	change compatible to "ti,am3505"

 .../devicetree/bindings/net/can/ti_hecc.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
new file mode 100644
index 0000000..ce015cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
@@ -0,0 +1,31 @@
+* Texas Instruments High End CAN Controller (HECC)
+
+This file provides information, what the device node
+for the hecc interface contains.
+
+Required properties:
+- compatible: "ti,am3505"
+- reg: offset and length of the register set for the device
+- interrupts: interrupt mapping for the hecc interrupts sources
+- clocks: clock phandles (see clock bindings for details)
+- ti,scc-ram-offset: offset to scc module ram
+- ti,hecc-ram-offset: offset to hecc module ram
+- ti,mbx-offset: offset to mailbox ram
+
+Optional properties:
+- ti,int-line: interrupt line
+
+Example:
+
+For am3517evm board:
+	hecc: can@0x5c050000 {
+		compatible = "ti,am3505";
+		status = "disabled";
+		reg = <0x5c050000 0x4000>;
+		interrupts = <24>;
+		clocks = <&hecc_ck>;
+		ti,scc-ram-offset = <0x3000>;
+		ti,hecc-ram-offset = <0x3000>;
+		ti,mbx-offset = <0x2000>;
+		ti,int-line = <0>;
+	};
-- 
2.1.4

