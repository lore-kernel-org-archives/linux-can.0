From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/8] can: bfin_can: add MODULE_ALIAS
Date: Thu, 22 Nov 2012 13:19:43 +0100
Message-ID: <1353586790-30791-2-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48598 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2KVTTx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:53 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_ALIAS for the platform bindings, so that the module
can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bfin_can.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index f2d6d25..a3f8de9 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -691,3 +691,4 @@ module_platform_driver(bfin_can_driver);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Blackfin on-chip CAN netdevice driver");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.10.4

