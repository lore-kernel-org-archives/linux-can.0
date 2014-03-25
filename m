From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 2/3] CAN: moved SPI drivers into a separate directory
Date: Tue, 25 Mar 2014 15:30:21 +0100
Message-ID: <1395757822-22283-3-git-send-email-sbabic@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:52658 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbaCYOau (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Mar 2014 10:30:50 -0400
In-Reply-To: <1395757822-22283-1-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>

Create a directory for all CAN drivers using SPI
and move mcp251x driver there.

Signed-off-by: Stefano Babic <sbabic@denx.de>

---

Changes in v2:
- added patch to move SPI drivers into a separate directory

 drivers/net/can/Kconfig             |    8 ++------
 drivers/net/can/Makefile            |    2 +-
 drivers/net/can/spi/Kconfig         |   10 ++++++++++
 drivers/net/can/spi/Makefile        |    8 ++++++++
 drivers/net/can/{ => spi}/mcp251x.c |    0
 5 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/can/spi/Kconfig
 create mode 100644 drivers/net/can/spi/Makefile
 rename drivers/net/can/{ => spi}/mcp251x.c (100%)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 9e7d95d..4aacaa9 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -77,12 +77,6 @@ config CAN_TI_HECC
 	  Driver for TI HECC (High End CAN Controller) module found on many
 	  TI devices. The device specifications are available from www.ti.com
 
-config CAN_MCP251X
-	tristate "Microchip MCP251x SPI CAN controllers"
-	depends on SPI && HAS_DMA
-	---help---
-	  Driver for the Microchip MCP251x SPI CAN controllers.
-
 config CAN_BFIN
 	depends on BF534 || BF536 || BF537 || BF538 || BF539 || BF54x
 	tristate "Analog Devices Blackfin on-chip CAN"
@@ -133,6 +127,8 @@ source "drivers/net/can/c_can/Kconfig"
 
 source "drivers/net/can/cc770/Kconfig"
 
+source "drivers/net/can/spi/Kconfig"
+
 source "drivers/net/can/usb/Kconfig"
 
 source "drivers/net/can/softing/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index c744039..c420588 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -10,6 +10,7 @@ can-dev-y			:= dev.o
 
 can-dev-$(CONFIG_CAN_LEDS)	+= led.o
 
+obj-y				+= spi/
 obj-y				+= usb/
 obj-y				+= softing/
 
@@ -19,7 +20,6 @@ obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_AT91)		+= at91_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
-obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
 obj-$(CONFIG_CAN_BFIN)		+= bfin_can.o
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan.o
diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
new file mode 100644
index 0000000..148cae5
--- /dev/null
+++ b/drivers/net/can/spi/Kconfig
@@ -0,0 +1,10 @@
+menu "CAN SPI interfaces"
+	depends on SPI
+
+config CAN_MCP251X
+	tristate "Microchip MCP251x SPI CAN controllers"
+	depends on HAS_DMA
+	---help---
+	  Driver for the Microchip MCP251x SPI CAN controllers.
+
+endmenu
diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
new file mode 100644
index 0000000..90bcacf
--- /dev/null
+++ b/drivers/net/can/spi/Makefile
@@ -0,0 +1,8 @@
+#
+#  Makefile for the Linux Controller Area Network SPI drivers.
+#
+
+
+obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
+
+ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/spi/mcp251x.c
similarity index 100%
rename from drivers/net/can/mcp251x.c
rename to drivers/net/can/spi/mcp251x.c
-- 
1.7.9.5

