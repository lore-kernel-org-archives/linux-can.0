From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/13] MAINTAINERS: Add myself as a maintainer for TCAN4x5x
Date: Mon,  9 Dec 2019 17:32:45 +0100
Message-ID: <20191209163256.12000-3-mkl@pengutronix.de>
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

Adding myself to support the TI TCAN4X5X SPI CAN device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d50632f7662..cdeabd4ee1a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16498,6 +16498,13 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
+TI TCAN4X5X DEVICE DRIVER
+M:	Dan Murphy <dmurphy@ti.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+F:	drivers/net/can/m_can/tcan4x5x.c
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.24.0
