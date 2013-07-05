From: Luka Rahne <luka.rahne@gmail.com>
Subject: Re: AW: Receiving messages issue
Date: Fri, 5 Jul 2013 12:04:20 +0200
Message-ID: <CAOHwv57ErvSAsGro04ELsNCnR2Np3HNFPshF6VSvz5h5O3-Gew@mail.gmail.com>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
	<56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
	<51C99CE5.7070708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:52632 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab3GEKEV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Jul 2013 06:04:21 -0400
Received: by mail-qa0-f51.google.com with SMTP id f11so1142888qae.3
        for <linux-can@vger.kernel.org>; Fri, 05 Jul 2013 03:04:21 -0700 (PDT)
In-Reply-To: <51C99CE5.7070708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I was able to include this driver in my project but first test shows
that there is no significant improvement.

I also had to patch driver in order to compile and work.
Can someone more experienced check patch for some fatal issues?


 Testing results:
Test -> sending 520 messages in total (each burst had 65 unique ID
messages of length 8 ) @ 100k baud.
USB-PEAK-CAN used for listening only, confirms all messages on sent bus.

New spi async drivers mcp2515.c had 3% packet loss and stable stock
driver mcp251x.c included in kernel 3.0.81 had 5% losts messages.

Decreasing baud on 50k had no packet loss for handling packets of
length 8 bytes (stock driver), but there is still issue on receiving
messages of length 0. (tested with stock driver only)
As expected shorter messages generates more interrupts, since they
takes less time to transfer.

Does anyone has any ideas what should I try, because I dont have lot
more ideas to try with.

Is there any chip on market that has more than few RX buffers and can
better handle high baud bus?


---
 drivers/net/can/mcp2515.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mcp2515.c b/drivers/net/can/mcp2515.c
index b6f9cbc..584d44e 100644
--- a/drivers/net/can/mcp2515.c
+++ b/drivers/net/can/mcp2515.c
@@ -55,6 +55,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/platform/mcp251x.h>
+#include <linux/sched.h>

 MODULE_DESCRIPTION("Driver for Microchip MCP2515 SPI CAN controller");
 MODULE_AUTHOR("Andre B. Oliveira <anbadeol@gmail.com>, "
@@ -690,7 +691,8 @@ static void mcp2515_clear_canintf_complete(void *context)
 	if (priv->canintf & CANINTF_TX0IF) {
 		struct sk_buff *skb = priv->skb;
 		if (skb) {
-			dev->stats.tx_bytes += can_get_echo_skb(dev, 0);
+			can_get_echo_skb(dev, 0);
+			dev->stats.tx_bytes += 8;
 			dev->stats.tx_packets++;
 		}
 		priv->skb = NULL;
@@ -1071,6 +1073,17 @@ static int mcp2515_remove(struct spi_device *spi)
 	return 0;
 }

+enum mcp251x_model {
+	CAN_MCP251X_MCP2510	= 0x2510,
+	CAN_MCP251X_MCP2515	= 0x2515,
+};
+
+static const struct spi_device_id mcp2515_id_table[] = {
+        { "mcp2515",    CAN_MCP251X_MCP2515 },
+        { },
+};
+
+
 static struct spi_driver mcp2515_can_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
@@ -1078,6 +1091,20 @@ static struct spi_driver mcp2515_can_driver = {
 	},
 	.probe = mcp2515_probe,
 	.remove = mcp2515_remove,
+        .id_table = mcp2515_id_table,
+
 };

-module_spi_driver(mcp2515_can_driver);
+static int __init mcp2515_can_init(void)
+{
+        return spi_register_driver(&mcp2515_can_driver);
+}
+
+static void __exit mcp2515_can_exit(void)
+{
+        spi_unregister_driver(&mcp2515_can_driver);
+}
+
+module_init(mcp2515_can_init);
+module_exit(mcp2515_can_exit);
+//module_spi_driver(mcp2515_can_driver);
-- 
1.7.9.5
