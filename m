From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v6 6/6] dt-bindings: can: can-transceiver: Document new binding
Date: Fri, 22 Dec 2017 19:01:28 +0530
Message-ID: <1513949488-13026-7-git-send-email-faiz_abbas@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:48220 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756335AbdLVNcj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Dec 2017 08:32:39 -0500
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

From: Franklin S Cooper Jr <fcooper@ti.com>

Add documentation to describe usage of the new can-transceiver binding.
This new binding is applicable for any CAN device therefore it exists as
its own document.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../bindings/net/can/can-transceiver.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.txt b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
new file mode 100644
index 0000000..0011f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
@@ -0,0 +1,24 @@
+Generic CAN transceiver Device Tree binding
+------------------------------
+
+CAN transceiver typically limits the max speed in standard CAN and CAN FD
+modes. Typically these limitations are static and the transceivers themselves
+provide no way to detect this limitation at runtime. For this situation,
+the "can-transceiver" node can be used.
+
+Required Properties:
+ max-bitrate:	a positive non 0 value that determines the max
+		speed that CAN/CAN-FD can run. Any other value
+		will be ignored.
+
+Examples:
+
+Based on Texas Instrument's TCAN1042HGV CAN Transceiver
+
+m_can0 {
+	....
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+	...
+};
-- 
2.7.4

