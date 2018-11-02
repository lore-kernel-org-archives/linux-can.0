From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 4/6] dt-bindings: can: m_can: Document transceiver implementation as a phy
Date: Sat, 3 Nov 2018 00:56:14 +0530
Message-ID: <20181102192616.28291-5-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

Some transceivers need a configuration step (for example, pulling
a standby line low) for them to start sending messages. Instead of a
parent child relationship, the transceiver can be implemented as a
phy with the configuration done in the phy driver. The bitrate
limitations can then be obtained by the driver using said phy
node.

Document the above implementation.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/net/can/m_can.txt     | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
index ed614383af9c..c11548e74278 100644
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
@@ -42,12 +42,14 @@ Required properties:
 
 			  Please refer to 2.4.1 Message RAM Configuration in
 			  Bosch M_CAN user manual for details.
+Optional properties:
+- phy-names		: must be "can_transceiver". The transceiver
+			  typically limits the maximum bitrate of the
+			  system. The phy node is used to discover this
+			  limitation.
+- phys			: phandle to the transceiver implemented as a phy
+			  node.
 
-Optional Subnode:
-- can-transceiver	: Can-transceiver subnode describing maximum speed
-			  that can be used for CAN/CAN-FD modes. See
-			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
-			  for details.
 Example:
 SoC dtsi:
 m_can1: can@20e8000 {
@@ -64,12 +66,18 @@ m_can1: can@20e8000 {
 };
 
 Board dts:
+
 &m_can1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_m_can1>;
 	status = "enabled";
+	phy-names = "can_transceiver";
+	phys = <&transceiver1>;
+};
 
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
+transceiver1: can-transceiver {
+	compatible = "simple-phy";
+	max-bitrate = <5000000>;
+	pwr-supply = <&transceiver1_fixed>;
+	#phy-cells = <0>;
 };
-- 
2.18.0
