From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND V2] Documentation: can: flexcan: add stop mode property
Date: Fri, 23 Nov 2018 07:25:17 +0000
Message-ID: <20181123072305.18236-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The FlexCAN controller can parse the stop mode property to enable CAN
self wakeup feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
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
