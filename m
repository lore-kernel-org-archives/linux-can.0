From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: peak_usb: fix mem leak in pcan_usb_pro_init()
Date: Sat, 14 Dec 2013 14:59:57 +0100
Message-ID: <1387029597-16783-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40995 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab3LNOAB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Dec 2013 09:00:01 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, s.grosjean@peak-system.com, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>

This patch fixes a memory leak in pcan_usb_pro_init(). In patch

    f14e224 net: can: peak_usb: Do not do dma on the stack

the struct pcan_usb_pro_fwinfo *fi and struct pcan_usb_pro_blinfo *bi were
converted from stack to dynamic allocation va kmalloc(). However the
corresponding kfree() was not introduced.

This patch adds the missing kfree().

Reported-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org> # v3.10
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 8ee9d15..263dd92 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -927,6 +927,9 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 	/* set LED in default state (end of init phase) */
 	pcan_usb_pro_set_led(dev, 0, 1);
 
+	kfree(bi);
+	kfree(fi);
+
 	return 0;
 
  err_out:
-- 
1.8.5.1

