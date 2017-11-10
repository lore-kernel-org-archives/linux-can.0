From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 1/3] Documentation : can : flexcan : Add big-endian property to device tree
Date: Fri, 10 Nov 2017 15:47:21 +0530
Message-ID: <1510309043-16777-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:19392
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751063AbdKJKOO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 Nov 2017 05:14:14 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>

The FlexCAN controller can be modelled as little or big endian
depending on SOC design. This device tree property identifies the
controller endianness and the driver reads/writes controller registers
based on that.

This is optional property. i.e. if this property is not present in
device tree node then controller is assumed to be little endian. if
this property is present then controller is assumed to be big endian.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..b9693c7 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -18,6 +18,8 @@ Optional properties:
 
 - xceiver-supply: Regulator that powers the CAN transceiver
 
+- big-endian: This means the registers of FlexCAN controller are big endian
+
 Example:
 
 	can@1c000 {
@@ -26,4 +28,5 @@ Example:
 		interrupts = <48 0x2>;
 		interrupt-parent = <&mpic>;
 		clock-frequency = <200000000>; // filled in by bootloader
+		big-endian;
 	};
-- 
2.7.4

