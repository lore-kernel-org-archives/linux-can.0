From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can: sja1000: correct indention of Kconfig help text
Date: Thu, 29 Nov 2012 14:58:11 +0100
Message-ID: <1354197491-31205-6-git-send-email-mkl@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42782 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab2K2N6O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:58:14 -0500
In-Reply-To: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch changes the indention of the Kconfig help text to the default
<tab> + 2 <space>.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 1bed54f..b39ca5b 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -99,11 +99,11 @@ config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
 	depends on ISA
 	help
-	This driver is for Technologic Systems' TSCAN-1 PC104 boards.
-	http://www.embeddedarm.com/products/board-detail.php?product=TS-CAN1
-	The driver supports multiple boards and automatically configures them:
-	PLD IO base addresses are read from jumpers JP1 and JP2,
-	IRQ numbers are read from jumpers JP4 and JP5,
-	SJA1000 IO base addresses are chosen heuristically (first that works).
+	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
+	  http://www.embeddedarm.com/products/board-detail.php?product=TS-CAN1
+	  The driver supports multiple boards and automatically configures them:
+	  PLD IO base addresses are read from jumpers JP1 and JP2,
+	  IRQ numbers are read from jumpers JP4 and JP5,
+	  SJA1000 IO base addresses are chosen heuristically (first that works).
 
 endif
-- 
1.7.10.4

