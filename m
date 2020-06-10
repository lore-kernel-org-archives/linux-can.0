From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver
Date: Wed, 10 Jun 2020 13:14:42 +0530
Message-ID: <20200610074442.10808-7-manivannan.sadhasivam@linaro.org>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-can.vger.kernel.org

Add MAINTAINERS entry for Microchip MCP25XXFD CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..591b6fc2d83a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10360,6 +10360,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD CAN NETWORK DRIVER
+M:	Martin Sperl <kernel@martin.sperl.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1
