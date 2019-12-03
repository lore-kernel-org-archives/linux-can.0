From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/6] MAINTAINERS: add fragment for xilinx CAN driver
Date: Tue,  3 Dec 2019 11:46:58 +0100
Message-ID: <20191203104703.14620-2-mkl@pengutronix.de>
References: <20191203104703.14620-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191203104703.14620-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Added entry for xilinx CAN driver.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8608724835dd..d700e27ebf41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18103,6 +18103,14 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX CAN DRIVER
+M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/xilinx_can.txt
+F:	drivers/net/can/xilinx_can.c
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
-- 
2.24.0
