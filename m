From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: sja1000: limit PEAK PCAN-PC Card to HAS_IOPORT
Date: Wed, 27 Mar 2013 15:05:28 +0100
Message-ID: <1364393128-19701-3-git-send-email-mkl@pengutronix.de>
References: <1364393128-19701-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48906 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3C0OFd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 10:05:33 -0400
In-Reply-To: <1364393128-19701-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Paul Mundt <lethal@linux-sh.org>

This patch limits the PEAK PCAN-PC Card driver to systems with ioports. Fixes a
compile time breakage on SH:

    drivers/net/can/sja1000/peak_pcmcia.c:626:2: error:
        implicit declaration of function 'ioport_unmap'

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index b39ca5b..ff2ba86 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -46,6 +46,7 @@ config CAN_EMS_PCI
 config CAN_PEAK_PCMCIA
 	tristate "PEAK PCAN-PC Card"
 	depends on PCMCIA
+	depends on HAS_IOPORT
 	---help---
 	  This driver is for the PCAN-PC Card PCMCIA adapter (1 or 2 channels)
 	  from PEAK-System (http://www.peak-system.com). To compile this
-- 
1.8.2.rc2

