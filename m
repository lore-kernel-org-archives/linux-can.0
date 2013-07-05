From: Luka Rahne <luka.rahne@gmail.com>
Subject: Re: AW: Receiving messages issue
Date: Fri, 5 Jul 2013 12:07:14 +0200
Message-ID: <CAOHwv555mUTjXQsB2KGPAEjdVkS1fOeWZxvTb+XEk-8HjkANwQ@mail.gmail.com>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
	<56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
	<51C99CE5.7070708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:60674 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab3GEKHP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Jul 2013 06:07:15 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so1134800qeb.19
        for <linux-can@vger.kernel.org>; Fri, 05 Jul 2013 03:07:14 -0700 (PDT)
In-Reply-To: <51C99CE5.7070708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: info@gerhard-bertelsmann.de, Michael Luxen <mluxen@gmx.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

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
-                       dev->stats.tx_bytes += can_get_echo_skb(dev, 0);
+                       can_get_echo_skb(dev, 0);
+                       dev->stats.tx_bytes += 8;
                        dev->stats.tx_packets++;
                }
                priv->skb = NULL;
@@ -1071,6 +1073,17 @@ static int mcp2515_remove(struct spi_device *spi)
        return 0;
 }

+enum mcp251x_model {
+       CAN_MCP251X_MCP2510     = 0x2510,
+       CAN_MCP251X_MCP2515     = 0x2515,
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

2013/6/25 Marc Kleine-Budde <mkl@pengutronix.de>:
> On 06/25/2013 02:00 PM, Gerhard Bertelsmann wrote:
>>>> On 06/24/2013 02:26 PM, Luka Rahne wrote:
>>>>> I am using MCP2515 with  i.MX27
>>>>
>>>> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is worse.
>
>> IMHO the controller isn't bad - it's the host interface (SPI).
>
> I see the CAN controller as a black box, I don't care if it doesn't
> perform under Linux due to the host interface or the fact that it has a
> rather shallow FIFO.
>
>> The MCP2515 based capes are using the BB SPI bus. As already stated before,
>> the CAN controller is not read-out fast enough. Root cause of this is mainly
>> the latency between MCP2515 interrupt and the SPI commands. I have seen
>> this on different platforms: there are gaps sometimes in the 100usec range.
>> The BBB is fast but there will be still gaps between MCP2515 attention needed
>> and SPI transfers and on heavy loaded links there will be reordered packets
>> or packet losts.
>> One solution could be running the SPI with higher priority. Second one would
>> be to tie SPI and MCP2515 driver together, but this is a quite dirty hack.
>
> You probably don't want to do this.
>
>> But the Beaglebone-CPU has a nifty thing: the PRUSS - 2x200 MHz CPUs
>> independantly running from the main CPU. Coupling one or more MCP2515s
>> to the appropiate pins could be easily served. The PRUSS doesn't have a
>> hardware SPI interface, but with old school bitbanging you could get  all
>> CAN packets even on fully loaded 1MBit link.
>
> You can port the existing CAN driver (note it's GPL'ed) or write a new
> one for the PRUSS and design a proper memory mapped interface interface
> to the CPU.
>
>> There is shared memory region between main and PRUSS CPU. Both CPU
>> domains could generate an interrupt for the other domain. So the data
>> could be easily exchanged - without any lost or reordered packets.
>
>> BTW: Which structure would be the best for this kind of data transfer ?
>
> IANAL: If you design the PRUSS firmware to be compatible to an existing
> driver e.g. a SJA10000 you don't have to write a new driver under Linux.
> However I'm not sure about the legal consequences of this.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
