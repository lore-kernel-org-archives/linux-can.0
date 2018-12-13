From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/2] Documentation: can: flexcan: add PE clock source property
 to device tree
Date: Thu, 13 Dec 2018 07:07:57 +0000
Message-ID: <20181213070537.25095-2-qiangqing.zhang@nxp.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The FlexCAN controller can parse clock source property from DTS file to
select PE clock source.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bc77477c6878..a04168605998 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -32,6 +32,13 @@ Optional properties:
 		 ack_gpr is the gpr register offset of CAN stop acknowledge.
 		 ack_bit is the bit offset of CAN stop acknowledge.
=20
+- fsl,clk-source: Select the clock source to the CAN Protocol Engine (PE).
+		  It's SoC Implementation dependent. Refer to RM for detailed
+		  definition. If this property is not set in device tree node
+		  then driver selects clock source 1 by default.
+		  0: clock source 0 (oscillator clock)
+		  1: clock source 1 (peripheral clock)
+
 Example:
=20
 	can@1c000 {
@@ -40,4 +47,5 @@ Example:
 		interrupts =3D <48 0x2>;
 		interrupt-parent =3D <&mpic>;
 		clock-frequency =3D <200000000>; // filled in by bootloader
+		fsl,clk-source =3D <0>; // select clock source 0 for PE
 	};
--=20
2.17.1
