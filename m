From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 1/2] dt-bindinsg: net: can: Convert can-transceiver to json-schema
Date: Fri, 7 Feb 2020 10:51:12 +0100
Message-ID: <20200207095113.14489-2-benjamin.gaignard@st.com>
References: <20200207095113.14489-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207095113.14489-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, sriram.dash@samsung.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-can.vger.kernel.org

Convert can-transceiver property to json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 3:
- only declare max-bitrate property in can-transceiver.yaml

 .../bindings/net/can/can-transceiver.txt           | 24 ----------------------
 .../bindings/net/can/can-transceiver.yaml          | 18 ++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.yaml

diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.txt b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
deleted file mode 100644
index 0011f53ff159..000000000000
--- a/Documentation/devicetree/bindings/net/can/can-transceiver.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Generic CAN transceiver Device Tree binding
-------------------------------
-
-CAN transceiver typically limits the max speed in standard CAN and CAN FD
-modes. Typically these limitations are static and the transceivers themselves
-provide no way to detect this limitation at runtime. For this situation,
-the "can-transceiver" node can be used.
-
-Required Properties:
- max-bitrate:	a positive non 0 value that determines the max
-		speed that CAN/CAN-FD can run. Any other value
-		will be ignored.
-
-Examples:
-
-Based on Texas Instrument's TCAN1042HGV CAN Transceiver
-
-m_can0 {
-	....
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
-	...
-};
diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.yaml b/Documentation/devicetree/bindings/net/can/can-transceiver.yaml
new file mode 100644
index 000000000000..6396977d29e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/can-transceiver.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/can-transceiver.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CAN transceiver Bindings
+
+description: CAN transceiver generic properties bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  max-bitrate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: a positive non 0 value that determines the max speed that CAN/CAN-FD can run.
+    minimum: 1
-- 
2.15.0
