From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: usb: Kconfig: Add PCAN-USB X6 device in help text
Date: Tue, 25 Apr 2017 14:16:44 +0200
Message-ID: <20170425121645.9946-3-mkl@pengutronix.de>
References: <20170425121645.9946-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51497 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1429036AbdDYMQ4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 08:16:56 -0400
In-Reply-To: <20170425121645.9946-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds a text line in the help section of the CAN_PEAK_USB
config item describing the support of the PCAN-USB X6 adapter, which is
already included in the Kernel since 4.9.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 3f8adc366af4..5f9e0e6301d0 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -73,6 +73,7 @@ config CAN_PEAK_USB
 	  PCAN-USB FD          single CAN-FD channel USB adapter
 	  PCAN-USB Pro FD      dual CAN-FD channels USB adapter
 	  PCAN-Chip USB        CAN-FD to USB stamp module
+	  PCAN-USB X6          6 CAN-FD channels USB adapter
 
 	  (see also http://www.peak-system.com).
 
-- 
2.11.0

