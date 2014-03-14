From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] can: mcp251x: Fix regulators operation without CONFIG_REGULATOR
Date: Fri, 14 Mar 2014 12:46:20 +0400
Message-ID: <1394786780-24083-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:32941 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbaCNIqx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Mar 2014 04:46:53 -0400
Received: from smtp21.mail.ru (smtp21.mail.ru [94.100.176.174])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 3C65D1106AF12
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2014 12:46:52 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

If CONFIG_REGULATOR is not set, devm_regulator_get() returns NULL,
so use IS_ERR_OR_NULL() macro for checks.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index cdb9808..1b6acb1 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -672,7 +672,7 @@ static int mcp251x_hw_probe(struct spi_device *spi)
 
 static int mcp251x_power_enable(struct regulator *reg, int enable)
 {
-	if (IS_ERR(reg))
+	if (IS_ERR_OR_NULL(reg))
 		return 0;
 
 	if (enable)
@@ -1221,7 +1221,7 @@ static int mcp251x_can_suspend(struct device *dev)
 		priv->after_suspend = AFTER_SUSPEND_DOWN;
 	}
 
-	if (!IS_ERR(priv->power)) {
+	if (!IS_ERR_OR_NULL(priv->power)) {
 		regulator_disable(priv->power);
 		priv->after_suspend |= AFTER_SUSPEND_POWER;
 	}
-- 
1.8.3.2

