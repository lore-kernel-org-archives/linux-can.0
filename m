From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/6] dt-bindings: phy: phy-of-simple: Document new binding
Date: Sat, 3 Nov 2018 00:56:12 +0530
Message-ID: <20181102192616.28291-3-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

Add documentation for the generic simple phy implementation.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/phy/phy-of-simple.txt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-of-simple.txt b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
new file mode 100644
index 000000000000..696f2763395c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
@@ -0,0 +1,29 @@
+Generic simple phy device tree binding
+--------------------------------------
+
+A good number of phy implementations merely read dts properties,
+enable clocks, regulators or do resets without having a dedicated register
+map. This binding implements a generic phy driver which can be used for
+such simple implementations and avoid boilerplate code duplication.
+
+Required Properties:
+-  compatible	: must be "simple-phy"
+-  phy-cells    : must be 0
+
+Optional Properties:
+-  bus-width	: generic bus-width. Must be positive.
+-  max-bitrate	: generic max-bitrate. Must be positive.
+-  pwr		: phandle to phy pwr regulator node.
+
+Example:
+
+The following example is a can transceiver implemented as a generic phy.
+It has a max-bitrate property and a pwr regulator.
+
+
+transceiver1: can-transceiver {
+	compatible = "simple-phy";
+	max-bitrate = <5000000>;
+	pwr-supply = <&transceiver1_fixed>;
+	#phy-cells = <0>;
+};
-- 
2.18.0
