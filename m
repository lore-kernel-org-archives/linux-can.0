From: Zhao Qiang <B45475@freescale.com>
Subject: [PATCH 2/2] flexcan: add err interrupt for p1010rdb
Date: Thu, 19 Jun 2014 15:46:13 +0800
Message-ID: <1403163973-48239-2-git-send-email-B45475@freescale.com>
References: <1403163973-48239-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:47167
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755362AbaFSHtt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Jun 2014 03:49:49 -0400
In-Reply-To: <1403163973-48239-1-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, B07421@freescale.com
Cc: Zhao Qiang <B45475@freescale.com>

add err interrupt for p1010rdb into dts.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 4313ff6..bcd95ba 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -141,13 +141,15 @@
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

