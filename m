From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: mpc5xxx_can: add MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:50 +0100
Message-ID: <1353586790-30791-9-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48590 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2KVTTq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:46 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_DEVICE_TABLE for the of bindings, so that the module
can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 799c354..514d020 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -396,6 +396,7 @@ static const struct of_device_id __devinitconst mpc5xxx_can_table[] = {
 	{ .compatible = "fsl,mpc5121-mscan", .data = &mpc5121_can_data, },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc5xxx_can_table);
 
 static struct platform_driver mpc5xxx_can_driver = {
 	.driver = {
-- 
1.7.10.4

