From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] MAINTAINERS: add myself as maintainer of MCAN MMIO device driver
Date: Tue,  3 Dec 2019 11:46:59 +0100
Message-ID: <20191203104703.14620-3-mkl@pengutronix.de>
References: <20191203104703.14620-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191203104703.14620-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Sriram Dash <sriram.dash@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Sriram Dash <sriram.dash@samsung.com>

Since we are actively working on MMIO MCAN device driver,
as discussed with Marc, I am adding myself as a maintainer.

Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d700e27ebf41..ecc354f4b692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10094,6 +10094,15 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-maxiradio*
 
+MCAN MMIO DEVICE DRIVER
+M:	Sriram Dash <sriram.dash@samsung.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/m_can.txt
+F:	drivers/net/can/m_can/m_can.c
+F:	drivers/net/can/m_can/m_can.h
+F:	drivers/net/can/m_can/m_can_platform.c
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.24.0
