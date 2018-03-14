From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 30/47] can: remove bfin_can driver
Date: Wed, 14 Mar 2018 16:35:43 +0100
Message-ID: <20180314153603.3127932-31-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The blackfin architecture is getting removed, so this one is now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/Kconfig    |   9 -
 drivers/net/can/Makefile   |   1 -
 drivers/net/can/bfin_can.c | 784 ---------------------------------------------
 3 files changed, 794 deletions(-)
 delete mode 100644 drivers/net/can/bfin_can.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index ac4ff394bc56..2cb75988b328 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -88,15 +88,6 @@ config CAN_AT91
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
 
-config CAN_BFIN
-	depends on BF534 || BF536 || BF537 || BF538 || BF539 || BF54x
-	tristate "Analog Devices Blackfin on-chip CAN"
-	---help---
-	  Driver for the Analog Devices Blackfin on-chip CAN controllers
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_can.
-
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on ARM || PPC
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 02b8ed794564..44922bf29b6a 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -19,7 +19,6 @@ obj-y				+= usb/
 obj-y				+= softing/
 
 obj-$(CONFIG_CAN_AT91)		+= at91_can.o
-obj-$(CONFIG_CAN_BFIN)		+= bfin_can.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan.o
diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
deleted file mode 100644
index 1deb8ff90a89..000000000000
-- 
2.9.0
