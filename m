From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH] MAINTAINERS: Add fragment for xilinx CAN driver
Date: Thu, 21 Nov 2019 14:09:24 +0530
Message-ID: <1574325564-30529-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

Added entry for xilinx CAN driver.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e57fc1d9962..d0f590517eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17890,6 +17890,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX CAN DRIVER
+M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
+S:	Maintained
+F:	drivers/net/can/xilinx_can.c
+F:	Documentation/devicetree/bindings/net/can/xilinx_can.txt
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
-- 
2.7.4
