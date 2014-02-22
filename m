From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] can: mcp251x: Remove #ifdef CONFIG_PM_SLEEP
Date: Sat, 22 Feb 2014 09:51:14 +0400
Message-ID: <1393048274-7949-2-git-send-email-shc_work@mail.ru>
References: <1393048274-7949-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.176.42]:47148 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaBVFwA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Feb 2014 00:52:00 -0500
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id 17EB715C235
	for <linux-can@vger.kernel.org>; Sat, 22 Feb 2014 09:51:57 +0400 (MSK)
In-Reply-To: <1393048274-7949-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>, Alexander Shiyan <shc_work@mail.ru>

This patch removes #ifdef CONFIG_PM_SLEEP to improve compile
coverage.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 56e38a6..2ac02c7 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1197,9 +1197,7 @@ static int mcp251x_can_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int mcp251x_can_suspend(struct device *dev)
+static int __maybe_unused mcp251x_can_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
@@ -1229,7 +1227,7 @@ static int mcp251x_can_suspend(struct device *dev)
 	return 0;
 }
 
-static int mcp251x_can_resume(struct device *dev)
+static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
@@ -1249,7 +1247,6 @@ static int mcp251x_can_resume(struct device *dev)
 	enable_irq(spi->irq);
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
 	mcp251x_can_resume);
-- 
1.8.3.2

