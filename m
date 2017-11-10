From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/3] powerpc: dts: P1010: Add endianness property to flexcan node
Date: Fri, 10 Nov 2017 15:47:22 +0530
Message-ID: <1510309043-16777-2-git-send-email-pankaj.bansal@nxp.com>
References: <1510309043-16777-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:55243
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751063AbdKJKOT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 Nov 2017 05:14:19 -0500
In-Reply-To: <1510309043-16777-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>

The flexcan driver assumed that flexcan controller is big endian for
powerpc architecture and little endian for other architectures.

But this is not universally true. flexcan controller can be little or
big endian on any architecture.

Therefore the flexcan driver has been modified to check for "big-endian"
device tree property for controllers that are big endian.

consequently add the property to freescale P1010 SOC device tree.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index af12ead..1b4aafc 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -137,12 +137,14 @@
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1c000 0x1000>;
 		interrupts = <48 0x2 0 0>;
+		big-endian;
 	};
 
 	can1: can@1d000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1d000 0x1000>;
 		interrupts = <61 0x2 0 0>;
+		big-endian;
 	};
 
 	L2: l2-cache-controller@20000 {
-- 
2.7.4

