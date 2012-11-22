From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: flexcan: add MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:47 +0100
Message-ID: <1353586790-30791-6-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48631 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179Ab2KVTUL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:20:11 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_DEVICE_TABLE for the of and platform bindings, so that
the module can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a412bf6..9a17965 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -979,11 +979,13 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, flexcan_of_match);
 
 static const struct platform_device_id flexcan_id_table[] = {
 	{ .name = "flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
 static int __devinit flexcan_probe(struct platform_device *pdev)
 {
-- 
1.7.10.4

