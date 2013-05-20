From: Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH] net/can/mcp251x: Use module_spi_driver to register driver
Date: Mon, 20 May 2013 21:49:59 +0200
Message-ID: <1369079399-6031-1-git-send-email-peterhuewe@gmx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59439 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008Ab3ETTov (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 May 2013 15:44:51 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LaIM4-1UCYmN3W9O-00m2sx for
 <linux-can@vger.kernel.org>; Mon, 20 May 2013 21:44:49 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>

Removing some boilerplate by using module_spi_driver instead of calling
register and unregister in the otherwise empty init/exit functions

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/net/can/mcp251x.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index f32b9fc..7a42e0f 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1218,19 +1218,7 @@ static struct spi_driver mcp251x_can_driver = {
 	.resume = mcp251x_can_resume,
 };
 
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
-
+module_spi_driver(mcp251x_can_driver);
 MODULE_AUTHOR("Chris Elston <celston@katalix.com>, "
 	      "Christian Pellegrin <chripell@evolware.org>");
 MODULE_DESCRIPTION("Microchip 251x CAN driver");
-- 
1.8.1.5

