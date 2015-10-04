From: Anton Glukhov <anton.a.glukhov@gmail.com>
Subject: [PATCH 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Sun,  4 Oct 2015 22:59:38 +0300
Message-ID: <1443988779-19935-2-git-send-email-anton.a.glukhov@gmail.com>
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36344 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbJDUAw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 Oct 2015 16:00:52 -0400
Received: by lacpo6 with SMTP id po6so3874159lac.3
        for <linux-can@vger.kernel.org>; Sun, 04 Oct 2015 13:00:50 -0700 (PDT)
In-Reply-To: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org, bcousson@baylibre.com
Cc: Anton Glukhov <anton.a.glukhov@gmail.com>

DT binding documentation for TI High End CAN Controller

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
---
 .../devicetree/bindings/net/can/ti_hecc.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
new file mode 100644
index 0000000..e29b0ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
@@ -0,0 +1,31 @@
+* Texas Instruments High End CAN Controller
+
+This file provides information, what the device node
+for the hecc interface contains.
+
+Required properties:
+- compatible: "ti,am35x-hecc"
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
+		compatible = "ti,am35x-hecc";
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
1.9.1

