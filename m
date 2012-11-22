From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/8] can: ti_hecc: add MODULE_ALIAS
Date: Thu, 22 Nov 2012 13:19:44 +0100
Message-ID: <1353586790-30791-3-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48592 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab2KVTTt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:49 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_ALIAS for the platform bindings, so that
the module can be loaded automatically udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 9ded21e..1267b36 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -1055,3 +1055,4 @@ module_platform_driver(ti_hecc_driver);
 MODULE_AUTHOR("Anant Gole <anantgole@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION(DRV_DESC);
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.10.4

