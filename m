From: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v4 6/6] arm/dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC
Date: Fri, 24 Nov 2017 18:52:13 +0530
Message-ID: <1511529733-27942-7-git-send-email-pankaj.bansal@nxp.com>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This patch adds the device nodes for flexcan controller(s) present on
LS1021A-Rev2 SoC.

Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Zhengxiong Jin <Jason.Jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
  - Merged device tree changes and driver changes in one series
Changes in v3:
  - No change.
Changes in v2:
  - No change.
  - Added one more patch in series.

 arch/arm/boot/dts/ls1021a-qds.dts | 16 +++++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts | 16 +++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 36 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9408753..4f211e3 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -331,3 +331,19 @@
 &uart1 {
 	status = "okay";
 };
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&can3 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a8b148a..7202d9c 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -243,3 +243,19 @@
 &uart1 {
 	status = "okay";
 };
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&can3 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..7789031 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -730,5 +730,41 @@
 					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		can0: can@2a70000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a70000 0x0 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can1: can@2a80000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a80000 0x0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can2: can@2a90000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a90000 0x0 0x1000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can3: can@2aa0000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2aa0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
 	};
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
