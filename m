From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/13] dt-bindings: can: tcan4x5x: reset pin is active high
Date: Mon,  9 Dec 2019 17:32:53 +0100
Message-ID: <20191209163256.12000-11-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

Change the reset pin example to active high to be in line with
the datasheet

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 27e1b4cebfbd..e8aa21d9174e 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -36,5 +36,5 @@ tcan4x5x: tcan4x5x@0 {
 		interrupts = <14 GPIO_ACTIVE_LOW>;
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
 };
-- 
2.24.0
