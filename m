From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 16:39:24 +0100
Message-ID: <4F353A2C.10401@hartkopp.net>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F34F8BC.3030903@peak-system.com> <4F34FC8F.4000104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:50883 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2BJPjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 10:39:37 -0500
In-Reply-To: <4F34FC8F.4000104@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 10.02.2012 12:16, Marc Kleine-Budde wrote:

> On 02/10/2012 12:00 PM, Stephane Grosjean wrote:
>> Hi all,
>>
>> While always fighting against pcmcia Oliver (very hot) unplug issue, I
>> decided to have a look to the sja1000 lib, since the pcmcia driver ISR
>> does call "sja1000_interrupt()",
>>
>> Unfortunately, I found that:
>>
>>                 if (isrc & IRQ_RI) {
>>                         /* receive interrupt */
>>                         while (status & SR_RBS) {
>>                                 sja1000_rx(dev);
>>                                 status = priv->read_reg(priv, REG_SR);
>>                         }
>>                 }
>>
>> My problem is, once the card is unplugged, every ioread in its
>> corresponding io space does return 0xff...
>> I just change this potential infinite while() into a corresponding
>> for(;;) loop to test, like this:
>>
>> -                        while (status & SR_RBS) {
>> +                        int i;
>> +                        for (i = 0; (status & SR_RBS) && (i < 10); i++) {
>>
>> And no more PC hang!
>>
>> Can you confirm this, please?
>>
>> @Oliver: IMHO, the 0xff (invalid) value is also the reason of the
>> "wakeup interrupt" message you got when unplugging the cards from their
>> slots...


Yes. I've also seen that now in the code ... should have looked earlier 8-)

> Is 0xff a valid value for REG_SR in the first place? If not we can for
> example exit the interrupt handler.


The question is, if a RX interrupt can occur, when the sja1000 is in bus-off
state.

The used status register has a bit for bus-off which is "1" in the bus-off
case. Assuming RX interrupts can only occur in a 'bus-on' state, this bit can
be assumed to be '0'.

Therefore checking for 0xFF should make it.

We can check it here

http://lxr.linux.no/#linux+v3.2.5/drivers/net/can/sja1000/sja1000.c#L495

and here

http://lxr.linux.no/#linux+v3.2.5/drivers/net/can/sja1000/sja1000.c#L511

So it could look like this:

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ebbcfca..f7526a7 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
                n++;
                status = priv->read_reg(priv, REG_SR);

+               /* check for absent controller due to hw unplug */
+               if (status == 0xFF)
+                       break;
+
                if (isrc & IRQ_WUI)
                        netdev_warn(dev, "wakeup interrupt\n");

@@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
                        netif_wake_queue(dev);
                }
                if (isrc & IRQ_RI) {
-                       /* receive interrupt */
-                       while (status & SR_RBS) {
+                       /* receive interrupt / check for absent controller */
+                       while (status & SR_RBS && status != 0xFF) {
                                sja1000_rx(dev);
                                status = priv->read_reg(priv, REG_SR);
                        }

@Stephane: Can you check that patch? I'm out of hw right now.

Regards,
Oliver
