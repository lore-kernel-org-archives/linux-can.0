From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/8] can: sja1000_platform: add MODULE_ALIAS
Date: Thu, 22 Nov 2012 13:19:45 +0100
Message-ID: <1353586790-30791-4-git-send-email-mkl@pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48608 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab2KVTT6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:58 -0500
In-Reply-To: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a MODULE_ALIAS for the platform bindings, so that the module
can be loaded automatically by udev.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 662c5f7..21619bb 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -34,6 +34,7 @@
 
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus");
+MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_LICENSE("GPL v2");
 
 static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
-- 
1.7.10.4

