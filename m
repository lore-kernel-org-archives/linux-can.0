From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: c_can_platform: add MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:49 +0100
Message-ID: <1353586790-30791-8-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48601 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2KVTTy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:54 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_DEVICE_TABLE for the of and platform bindings, so that
the module can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 75c3f47..0044fd8 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -97,12 +97,14 @@ static struct platform_device_id c_can_id_table[] = {
 	}, {
 	}
 };
+MODULE_DEVICE_TABLE(platform, c_can_id_table);
 
 static const struct of_device_id c_can_of_table[] = {
 	{ .compatible = "bosch,c_can", .data = &c_can_id_table[BOSCH_C_CAN] },
 	{ .compatible = "bosch,d_can", .data = &c_can_id_table[BOSCH_D_CAN] },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, c_can_of_table);
 
 static int __devinit c_can_plat_probe(struct platform_device *pdev)
 {
-- 
1.7.10.4

