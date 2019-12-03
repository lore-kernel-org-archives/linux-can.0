From: Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH] MAINTAINERS: add myself as maintainer of MCAN MMIO device
 driver
Date: Tue,  3 Dec 2019 09:59:09 +0530
Message-ID: <1575347349-32689-1-git-send-email-sriram.dash@samsung.com>
References: <CGME20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27@epcas5p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com
Cc: mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, robh@kernel.org, dmurphy@ti.com, rcsekar@samsung.com, pankaj.dubey@samsung.com, pankj.sharma@samsung.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

Since we are actively working on MMIO MCAN device driver,
as discussed with Marc, I am adding myself as a maintainer.

Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc36fe5..64ecf11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10082,6 +10082,15 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-maxiradio*
 
+MCAN MMIO DEVICE DRIVER
+M:	Sriram Dash <sriram.dash@samsung.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/m_can.txt
+F:	drivers/net/can/m_can/m_can_platform.c
+F:	drivers/net/can/m_can/m_can.c
+F:	drivers/net/can/m_can/m_can.h
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4
