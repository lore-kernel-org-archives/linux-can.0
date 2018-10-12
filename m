From: <shubhrajyoti.datta@gmail.com>
Subject: [PATCHv2 2/2] dt-bindings: can: xilinx_can: add Xilinx CAN FD 2.0  bindings
Date: Fri, 12 Oct 2018 09:55:09 +0530
Message-ID: <1539318309-13715-2-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539318309-13715-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1539318309-13715-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, michal.simek@xilinx.com, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-can.vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add compatible string and new attributes to support the Xilinx CAN
FD 2.0.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 Documentation/devicetree/bindings/net/can/xilinx_can.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx_can.txt b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
index 060e2d4..100cc40b 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx_can.txt
+++ b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
@@ -6,6 +6,7 @@ Required properties:
 			  - "xlnx,zynq-can-1.0" for Zynq CAN controllers
 			  - "xlnx,axi-can-1.00.a" for Axi CAN controllers
 			  - "xlnx,canfd-1.0" for CAN FD controllers
+			  - "xlnx,canfd-2.0" for CAN FD 2.0 controllers
 - reg			: Physical base address and size of the controller
 			  registers map.
 - interrupts		: Property with a value describing the interrupt
-- 
2.1.1
