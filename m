From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/5] can: Kconfig: convert 'depends on CAN_DEV' into 'if CAN_DEV...endif' block
Date: Thu, 29 Nov 2012 14:58:08 +0100
Message-ID: <1354197491-31205-3-git-send-email-mkl@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42776 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab2K2N6N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:58:13 -0500
In-Reply-To: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds an 'if CAN_DEV...endif' Block around the CAN driver
symbols in drivers/net/can/Kconfig. So the 'depends on CAN' dependencies
can be removed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig         |   21 ++++++++++++---------
 drivers/net/can/c_can/Kconfig   |    2 +-
 drivers/net/can/cc770/Kconfig   |    2 +-
 drivers/net/can/mscan/Kconfig   |    2 +-
 drivers/net/can/sja1000/Kconfig |    2 +-
 drivers/net/can/softing/Kconfig |    2 +-
 drivers/net/can/usb/Kconfig     |    2 +-
 7 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 8088d8f..0c5a656 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -36,9 +36,10 @@ config CAN_DEV
 	  support. This is the standard library for CAN drivers.
 	  If unsure, say Y.
 
+if CAN_DEV
+
 config CAN_CALC_BITTIMING
 	bool "CAN bit-timing calculation"
-	depends on CAN_DEV
 	default y
 	---help---
 	  If enabled, CAN bit-timing parameters will be calculated for the
@@ -52,13 +53,13 @@ config CAN_CALC_BITTIMING
 
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
-	depends on CAN_DEV && (ARCH_AT91SAM9263 || ARCH_AT91SAM9X5)
+	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
 	---help---
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
 
 config CAN_TI_HECC
-	depends on CAN_DEV && ARCH_OMAP3
+	depends on ARCH_OMAP3
 	tristate "TI High End CAN Controller"
 	---help---
 	  Driver for TI HECC (High End CAN Controller) module found on many
@@ -66,12 +67,12 @@ config CAN_TI_HECC
 
 config CAN_MCP251X
 	tristate "Microchip MCP251x SPI CAN controllers"
-	depends on CAN_DEV && SPI && HAS_DMA
+	depends on SPI && HAS_DMA
 	---help---
 	  Driver for the Microchip MCP251x SPI CAN controllers.
 
 config CAN_BFIN
-	depends on CAN_DEV && (BF534 || BF536 || BF537 || BF538 || BF539 || BF54x)
+	depends on BF534 || BF536 || BF537 || BF538 || BF539 || BF54x
 	tristate "Analog Devices Blackfin on-chip CAN"
 	---help---
 	  Driver for the Analog Devices Blackfin on-chip CAN controllers
@@ -81,7 +82,7 @@ config CAN_BFIN
 
 config CAN_JANZ_ICAN3
 	tristate "Janz VMOD-ICAN3 Intelligent CAN controller"
-	depends on CAN_DEV && MFD_JANZ_CMODIO
+	depends on MFD_JANZ_CMODIO
 	---help---
 	  Driver for Janz VMOD-ICAN3 Intelligent CAN controller module, which
 	  connects to a MODULbus carrier board.
@@ -94,13 +95,13 @@ config HAVE_CAN_FLEXCAN
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on CAN_DEV && HAVE_CAN_FLEXCAN
+	depends on HAVE_CAN_FLEXCAN
 	---help---
 	  Say Y here if you want to support for Freescale FlexCAN.
 
 config PCH_CAN
 	tristate "Intel EG20T PCH CAN controller"
-	depends on CAN_DEV && PCI
+	depends on PCI
 	---help---
 	  This driver is for PCH CAN of Topcliff (Intel EG20T PCH) which
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
@@ -108,7 +109,7 @@ config PCH_CAN
 
 config CAN_GRCAN
 	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
-	depends on CAN_DEV && OF
+	depends on OF
 	---help---
 	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
 	  Note that the driver supports little endian, even though little
@@ -127,6 +128,8 @@ source "drivers/net/can/usb/Kconfig"
 
 source "drivers/net/can/softing/Kconfig"
 
+endif
+
 config CAN_DEBUG_DEVICES
 	bool "CAN devices debugging messages"
 	---help---
diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 3b83baf..61ffc12 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -1,6 +1,6 @@
 menuconfig CAN_C_CAN
 	tristate "Bosch C_CAN/D_CAN devices"
-	depends on CAN_DEV && HAS_IOMEM
+	depends on HAS_IOMEM
 
 if CAN_C_CAN
 
diff --git a/drivers/net/can/cc770/Kconfig b/drivers/net/can/cc770/Kconfig
index 22c07a8..6a9a5ba 100644
--- a/drivers/net/can/cc770/Kconfig
+++ b/drivers/net/can/cc770/Kconfig
@@ -1,6 +1,6 @@
 menuconfig CAN_CC770
 	tristate "Bosch CC770 and Intel AN82527 devices"
-	depends on CAN_DEV && HAS_IOMEM
+	depends on HAS_IOMEM
 
 if CAN_CC770
 
diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
index d387069..f19be52 100644
--- a/drivers/net/can/mscan/Kconfig
+++ b/drivers/net/can/mscan/Kconfig
@@ -1,5 +1,5 @@
 config CAN_MSCAN
-	depends on CAN_DEV && (PPC || M68K)
+	depends on PPC || M68K
 	tristate "Support for Freescale MSCAN based chips"
 	---help---
 	  The Motorola Scalable Controller Area Network (MSCAN) definition
diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 92f73c7..1bed54f 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -1,6 +1,6 @@
 menuconfig CAN_SJA1000
 	tristate "Philips/NXP SJA1000 devices"
-	depends on CAN_DEV && HAS_IOMEM
+	depends on HAS_IOMEM
 
 if CAN_SJA1000
 
diff --git a/drivers/net/can/softing/Kconfig b/drivers/net/can/softing/Kconfig
index 5de46a9..96b6fe1 100644
--- a/drivers/net/can/softing/Kconfig
+++ b/drivers/net/can/softing/Kconfig
@@ -1,6 +1,6 @@
 config CAN_SOFTING
 	tristate "Softing Gmbh CAN generic support"
-	depends on CAN_DEV && HAS_IOMEM
+	depends on HAS_IOMEM
 	---help---
 	  Support for CAN cards from Softing Gmbh & some cards
 	  from Vector Gmbh.
diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index a4e4bee..acba33d 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -1,5 +1,5 @@
 menu "CAN USB interfaces"
-	depends on USB && CAN_DEV
+	depends on USB
 
 config CAN_EMS_USB
 	tristate "EMS CPC-USB/ARM7 CAN/USB interface"
-- 
1.7.10.4

