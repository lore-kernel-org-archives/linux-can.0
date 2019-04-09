From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] dt-bindings: can: flexcan: add can wakeup property
Date: Tue,  9 Apr 2019 10:39:49 +0200
Message-ID: <20190409083949.27917-2-sean@geanix.com>
References: <20190409083949.27917-1-sean@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190409083949.27917-1-sean@geanix.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de, robh+dt@kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

add wakeup-source boolean property.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bc77477c6878..17453be840d8 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -32,6 +32,8 @@ Optional properties:
 		 ack_gpr is the gpr register offset of CAN stop acknowledge.
 		 ack_bit is the bit offset of CAN stop acknowledge.
 
+- wakeup-source: enable CAN remote wakeup
+
 Example:
 
 	can@1c000 {
-- 
2.21.0
