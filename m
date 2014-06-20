From: Zhao Qiang <B45475@freescale.com>
Subject: [PATCH v2 2/2] flexcan: add err interrupt for p1010rdb
Date: Fri, 20 Jun 2014 10:01:04 +0800
Message-ID: <1403229664-33912-2-git-send-email-B45475@freescale.com>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:34434
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754325AbaFTCEZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Jun 2014 22:04:25 -0400
In-Reply-To: <1403229664-33912-1-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, B07421@freescale.com
Cc: Zhao Qiang <B45475@freescale.com>

add err interrupt for p1010rdb into dts.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
Changes for v2:
	- add binding documentation update

 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 7 +++++--
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi               | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..81929e5 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -10,7 +10,9 @@ Required properties:
   - fsl,p1010-flexcan
 
 - reg : Offset and length of the register set for this device
-- interrupts : Interrupt tuple for this device
+- interrupts : Interrupt tuple for this device.
+	The first interrupt is for FlexCAN(Message Buffer and Wake Up)
+	The second is for error(Shared with IFC, PEX1 and some other device)
 
 Optional properties:
 
@@ -23,7 +25,8 @@ Example:
 	can@1c000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1c000 0x1000>;
-		interrupts = <48 0x2>;
+		interrupts = <48 0x2 0 0
+			      16 0x2 0 0>;
 		interrupt-parent = <&mpic>;
 		clock-frequency = <200000000>; // filled in by bootloader
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index af12ead..47125a6 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -136,13 +136,15 @@
 	can0: can@1c000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1c000 0x1000>;
-		interrupts = <48 0x2 0 0>;
+		interrupts = <48 0x2 0 0
+			      16 0x2 0 0>;
 	};
 
 	can1: can@1d000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1d000 0x1000>;
-		interrupts = <61 0x2 0 0>;
+		interrupts = <61 0x2 0 0
+			      16 0x2 0 0>;
 	};
 
 	L2: l2-cache-controller@20000 {
-- 
1.8.5

