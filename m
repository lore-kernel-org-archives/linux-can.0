From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V6 1/2] Documentation: can: flexcan: add stop mode property to
 device tree
Date: Fri, 23 Nov 2018 08:35:29 +0000
Message-ID: <20181123083304.3232-2-qiangqing.zhang@nxp.com>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

The FlexCAN controller can parse the stop mode property to enable CAN
self wakeup feature.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V6:
	*no change.
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bfc0c433654f..bc77477c6878 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -24,6 +24,14 @@ Optional properties:
               if this property is present then controller is assumed to be=
 big
               endian.
=20
+- fsl,stop-mode: register bits of stop mode control, the format is
+		 <&gpr req_gpr req_bit ack_gpr ack_bit>.
+		 gpr is the phandle to general purpose register node.
+		 req_gpr is the gpr register offset of CAN stop request.
+		 req_bit is the bit offset of CAN stop request.
+		 ack_gpr is the gpr register offset of CAN stop acknowledge.
+		 ack_bit is the bit offset of CAN stop acknowledge.
+
 Example:
=20
 	can@1c000 {
--=20
2.17.1
