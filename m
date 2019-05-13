From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 1/2] arm64: dts: fsl: lx2160a: add flexcan node
Date: Mon, 13 May 2019 06:02:47 +0000
Message-ID: <20190513112612.11036-2-pankaj.bansal@nxp.com>
References: <20190513112612.11036-1-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190513112612.11036-1-pankaj.bansal@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Add flexcan node in LX2160A SOC file as well as in QDS and RDB files.
The device tree bindings used can be referred from
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes (dts):
    Dependencies:
    - https://www.spinics.net/lists/linux-can/msg01562.html

 .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 10 ++++++++-
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts   | 18 +++++++++++++++-
 .../boot/dts/freescale/fsl-lx2160a.dtsi      | 20 +++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 99a22abbe725..849edac27b61 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -2,7 +2,7 @@
 //
 // Device Tree file for LX2160AQDS
 //
-// Copyright 2018 NXP
+// Copyright 2018-2019 NXP
 
 /dts-v1/;
 
@@ -31,6 +31,14 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &crypto {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 9df37b159415..97cbe9e67abf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -2,7 +2,7 @@
 //
 // Device Tree file for LX2160ARDB
 //
-// Copyright 2018 NXP
+// Copyright 2018-2019 NXP
 
 /dts-v1/;
 
@@ -31,6 +31,22 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&can1 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
 &crypto {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index fe87204850b5..75c350927dc0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -2,7 +2,7 @@
 //
 // Device Tree Include file for Layerscape-LX2160A family SoC.
 //
-// Copyright 2018 NXP
+// Copyright 2018-2019 NXP
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -581,6 +581,24 @@
 			status = "disabled";
 		};
 
+		can0: can@2180000 {
+			compatible = "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 7>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@2190000 {
+			compatible = "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 7>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
 		uart0: serial@21c0000 {
 			compatible = "arm,sbsa-uart","arm,pl011";
 			reg = <0x0 0x21c0000 0x0 0x1000>;
-- 
2.17.1
