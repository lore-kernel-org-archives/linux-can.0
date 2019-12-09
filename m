From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/13] MAINTAINERS: Add myself as a maintainer for MMIO m_can
Date: Mon,  9 Dec 2019 17:32:44 +0100
Message-ID: <20191209163256.12000-2-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

Since I refactored the code to create a m_can framework and we
have a MMIO MCAN IP as well add myself to help maintain the code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc354f4b692..1d50632f7662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10095,6 +10095,7 @@ S:	Maintained
 F:	drivers/media/radio/radio-maxiradio*
 
 MCAN MMIO DEVICE DRIVER
+M:	Dan Murphy <dmurphy@ti.com>
 M:	Sriram Dash <sriram.dash@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-- 
2.24.0
