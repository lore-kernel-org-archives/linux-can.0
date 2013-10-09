From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: at91-can: fix device to driver data mapping for platform devices
Date: Wed,  9 Oct 2013 12:39:04 +0200
Message-ID: <1381315144-12167-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40904 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3JIKjO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2013 06:39:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Ludovic Desroches <ludovic.desroches@atmel.com>

In commit:

    3078cde7 can: at91_can: add dt support

device tree support was added to the at91_can driver. In this commit the
mapping of device to driver data was mixed up. This results in the sam9x5
parameters being used for the sam9263 and the workaround for the broken mailbox
0 on the sam9263 not being activated.

This patch fixes the broken platform_device_id table.

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3b1ff61..693d8ff 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1405,10 +1405,10 @@ static int at91_can_remove(struct platform_device *pdev)
 
 static const struct platform_device_id at91_can_id_table[] = {
 	{
-		.name = "at91_can",
+		.name = "at91sam9x5_can",
 		.driver_data = (kernel_ulong_t)&at91_at91sam9x5_data,
 	}, {
-		.name = "at91sam9x5_can",
+		.name = "at91_can",
 		.driver_data = (kernel_ulong_t)&at91_at91sam9263_data,
 	}, {
 		/* sentinel */
-- 
1.8.4.rc3

