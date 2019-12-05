From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as a maintainer for MMIO m_can
Date: Thu, 5 Dec 2019 11:57:15 -0600
Message-ID: <20191205175716.9905-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, robh@kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Since I refactored the code to create a m_can framework and we
have a MMIO MCAN IP as well add myself to help maintain the code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc354f4b692..64f51f312707 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10096,6 +10096,7 @@ F:	drivers/media/radio/radio-maxiradio*
 
 MCAN MMIO DEVICE DRIVER
 M:	Sriram Dash <sriram.dash@samsung.com>
+M:	Dan Murphy <dmurphy@ti.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/m_can.txt
-- 
2.23.0
