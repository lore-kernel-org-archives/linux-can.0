From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as a maintainer for TCAN4x5x
Date: Thu, 5 Dec 2019 11:57:16 -0600
Message-ID: <20191205175716.9905-2-dmurphy@ti.com>
References: <20191205175716.9905-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205175716.9905-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, robh@kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Adding myself to support the TI TCAN4X5X SPI CAN device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f51f312707..cbd8764dcec3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16498,6 +16498,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
+TI TCAN4X5X DEVICE DRIVER
+M:	Dan Murphy <dmurphy@ti.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/m_can/tcan4x5x.c
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.23.0
