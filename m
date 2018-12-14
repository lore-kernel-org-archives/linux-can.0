From: Alexander Dahl <ada@thorsis.com>
Subject: [PATCH] can: usb: Kconfig: Remove duplicate menu entry
Date: Fri, 14 Dec 2018 10:35:08 +0100
Message-ID: <20181214093508.4825-1-ada@thorsis.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This seems to have slipped in by accident when sorting the entries.

Fixes: ffbdd9172ee2f53020f763574b4cdad8d9760a4f
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/net/can/usb/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 750d04d9e2ae..928bf083f8d2 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -101,12 +101,6 @@ config CAN_PEAK_USB
 
 	  (see also http://www.peak-system.com).
 
-config CAN_MCBA_USB
-	tristate "Microchip CAN BUS Analyzer interface"
-	---help---
-	  This driver supports the CAN BUS Analyzer interface
-	  from Microchip (http://www.microchip.com/development-tools/).
-
 config CAN_UCAN
 	tristate "Theobroma Systems UCAN interface"
 	---help---
-- 
2.11.0
