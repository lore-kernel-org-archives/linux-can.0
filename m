From: Ed Spiridonov <edo.rus@gmail.com>
Subject: [PATCH v2] can: mcp251x: add message about sucessful/unsuccessful probe
Date: Mon, 20 Jun 2016 21:40:15 +0300
Message-ID: <1466448015-20392-1-git-send-email-edo.rus@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33940 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcFTS4t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 14:56:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id l184so6283256lfl.1
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 11:55:45 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Ed Spiridonov <edo.rus@gmail.com>

Silent ignorance of errors during probe procedure is a bad thing, this patch fixes it.
Extra message added for hardware initialization failure. Such common issues are mostly caused by wrong wiring.
Message about success added as well, it should be useful to debug new hardware configuration, especially in case of several CAN buses.

Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>
---
 drivers/net/can/spi/mcp251x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index cf36d26..f3f05fe 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1145,8 +1145,11 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	/* Here is OK to not lock the MCP, no one knows about it yet */
 	ret = mcp251x_hw_probe(spi);
-	if (ret)
+	if (ret) {
+		if (ret == -ENODEV)
+			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n", priv->model);
 		goto error_probe;
+	}
 
 	mcp251x_hw_sleep(spi);
 
@@ -1156,6 +1159,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
+	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
 	return 0;
 
 error_probe:
@@ -1168,6 +1172,7 @@ out_clk:
 out_free:
 	free_candev(net);
 
+	dev_err(&spi->dev, "Probe failed, err=%d\n", -ret);
 	return ret;
 }
 
-- 
2.8.1

