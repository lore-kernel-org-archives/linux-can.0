From: Ed Spiridonov <edo.rus@gmail.com>
Subject: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
Date: Sun, 29 May 2016 04:59:16 +0300
Message-ID: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35816 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcE2B71 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 28 May 2016 21:59:27 -0400
Received: by mail-lb0-f194.google.com with SMTP id sh2so7333819lbb.2
        for <linux-can@vger.kernel.org>; Sat, 28 May 2016 18:59:27 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Ed Spiridonov <edo.rus@gmail.com>

Print error message if mcp251x_hw_probe() fails (e.g. MCP2515 isn't connected or other wiring issue).
Print information message if mcp251x_can_probe() is successful.
---
 drivers/net/can/spi/mcp251x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index cf36d26..49453f7 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1145,8 +1145,10 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	/* Here is OK to not lock the MCP, no one knows about it yet */
 	ret = mcp251x_hw_probe(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "hw_probe failed, err=%d (wrong wiring?)\n", -ret);
 		goto error_probe;
+	}
 
 	mcp251x_hw_sleep(spi);
 
@@ -1156,6 +1158,8 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
+	netdev_info(net, "successfully initialized.\n");
+
 	return 0;
 
 error_probe:
-- 
2.7.0

