From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/2] arm64: dts: fsl: ls1028a: add flexcan node
Date: Mon, 13 May 2019 06:02:49 +0000
Message-ID: <20190513112612.11036-3-pankaj.bansal@nxp.com>
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

Add flexcan node in LS1028A SOC file as well as in QDS and RDB files.
The device tree bindings used can be referred from
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes (dts):
    Dependencies:
    - https://www.spinics.net/lists/linux-can/msg01562.html

 .../boot/dts/freescale/fsl-ls1028a-qds.dts   | 10 +++++++-
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts   | 18 +++++++++++++-
 .../boot/dts/freescale/fsl-ls1028a.dtsi      | 22 +++++++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 14c79f4691ea..c1895be5d523 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for NXP LS1028A QDS Board.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2019 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -34,6 +34,14 @@
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
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index f86b054a74ae..7dc75d584ada 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for NXP LS1028A RDB Board.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2019 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -64,6 +64,22 @@
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
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2896bbcfa3bb..016121e86d4d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1028A family SoC.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2019 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -219,6 +219,26 @@
 			status = "disabled";
 		};
 
+		can0: can@2180000 {
+			compatible = "fsl,ls1028ar1-flexcan",
+				     "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@2190000 {
+			compatible = "fsl,ls1028ar1-flexcan",
+				     "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-- 
2.17.1
