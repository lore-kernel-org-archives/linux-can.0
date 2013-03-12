From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] can: mcp251x: Use module_spi_driver
Date: Tue, 12 Mar 2013 13:13:52 +0100
Message-ID: <1363090433-11461-2-git-send-email-lars@metafoo.de>
References: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1131 "EHLO
	smtp-out-038.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab3CLMSz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Mar 2013 08:18:55 -0400
In-Reply-To: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

By using module_spi_driver we can eliminate a few lines of boilerplate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/net/can/mcp251x.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 05e93e8..4dc7b9d 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1216,19 +1216,7 @@ static struct spi_driver mcp251x_can_driver = {
 	.suspend = mcp251x_can_suspend,
 	.resume = mcp251x_can_resume,
 };
-
-static int __init mcp251x_can_init(void)
-{
-	return spi_register_driver(&mcp251x_can_driver);
-}
-
-static void __exit mcp251x_can_exit(void)
-{
-	spi_unregister_driver(&mcp251x_can_driver);
-}
-
-module_init(mcp251x_can_init);
-module_exit(mcp251x_can_exit);
+module_spi_driver(mcp251x_can_driver);
 
 MODULE_AUTHOR("Chris Elston <celston@katalix.com>, "
 	      "Christian Pellegrin <chripell@evolware.org>");
-- 
1.8.0

