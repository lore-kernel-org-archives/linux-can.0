From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] flexcan: Add MODULE_ALIAS
Date: Mon, 22 Jul 2013 11:23:01 -0300
Message-ID: <1374502981-16282-2-git-send-email-fabio.estevam@freescale.com>
References: <1374502981-16282-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:37592
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213Ab3GVOXW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2013 10:23:22 -0400
In-Reply-To: <1374502981-16282-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

Add MODULE_ALIAS, so that auto module loading can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/net/can/flexcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0516fd8..cd25af0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1156,6 +1156,7 @@ static struct platform_driver flexcan_driver = {
 
 module_platform_driver(flexcan_driver);
 
+MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Sascha Hauer <kernel@pengutronix.de>, "
 	      "Marc Kleine-Budde <kernel@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.2


