From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: cc770_platform: add MODULE_ALIAS and MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:46 +0100
Message-ID: <1353586790-30791-5-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48596 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab2KVTTv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:51 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_ALIAS for the platform bindings and a
MODULE_DEVICE_TABLE for of bindings, so that the module can be loaded
automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 688371c..3da6cbb 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -60,6 +60,7 @@
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for CC770 on the platform bus");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
 
 #define CC770_PLATFORM_CAN_CLOCK  16000000
 
@@ -258,6 +259,7 @@ static struct of_device_id __devinitdata cc770_platform_table[] = {
 	{.compatible = "intc,82527"},  /* AN82527 from Intel CP */
 	{},
 };
+MODULE_DEVICE_TABLE(of, cc770_platform_table);
 
 static struct platform_driver cc770_platform_driver = {
 	.driver = {
-- 
1.7.10.4

