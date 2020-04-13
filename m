From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] can: tcan4x5x: Replace depends on REGMAP_SPI with depends on SPI
Date: Mon, 13 Apr 2020 16:10:13 +0200
Message-ID: <20200413141013.506613-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Collabora Kernel ML <kernel@collabora.com>, Dan Murphy <dmurphy@ti.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

regmap is a library function that gets selected by drivers that need
it. No driver modules should depend on it. Instead depends on SPI and
select REGMAP_SPI. Depending on REGMAP_SPI makes this driver only build
if another driver already selected REGMAP_SPI, as the symbol can't be
selected through the menu kernel configuration.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/net/can/m_can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 1ff0b7fe81d6..c10932a7f1fe 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -16,7 +16,8 @@ config CAN_M_CAN_PLATFORM
 
 config CAN_M_CAN_TCAN4X5X
 	depends on CAN_M_CAN
-	depends on REGMAP_SPI
+	depends on SPI
+	select REGMAP_SPI
 	tristate "TCAN4X5X M_CAN device"
 	---help---
 	  Say Y here if you want support for Texas Instruments TCAN4x5x
-- 
2.25.1
