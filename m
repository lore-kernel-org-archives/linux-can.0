From: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 2/4] powerpc: dts: P1010: Add endianness property to flexcan node
Date: Thu, 23 Nov 2017 15:25:33 +0530
Message-ID: <1511430935-29783-2-git-send-email-pankaj.bansal@nxp.com>
References: <1511430935-29783-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511430935-29783-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-can.vger.kernel.org

The flexcan driver assumed that flexcan controller is big endian for
powerpc architecture and little endian for other architectures.

But this is not universally true. flexcan controller can be little or
big endian on any architecture.

Therefore the flexcan driver has been modified to check for "big-endian"
device tree property for controllers that are big endian.

consequently add the property to freescale P1010 SOC device tree.

Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
---
Changes in v2:
  - No change.
  - Added one more patch in series.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
