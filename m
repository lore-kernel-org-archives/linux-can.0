From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/8] can: at91_can: add MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:48 +0100
Message-ID: <1353586790-30791-7-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48620 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2KVTUD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:20:03 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_DEVICE_TABLE for the platform bindings, so that the
module can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index fcff73a..14b166b 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1372,6 +1372,7 @@ static const struct platform_device_id at91_can_id_table[] = {
 		/* sentinel */
 	}
 };
+MODULE_DEVICE_TABLE(platform, at91_can_id_table);
 
 static struct platform_driver at91_can_driver = {
 	.probe = at91_can_probe,
-- 
1.7.10.4

