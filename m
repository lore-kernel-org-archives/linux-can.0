From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Tue, 14 Feb 2012 10:59:24 +0100
Message-ID: <4F3A307C.1050706@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:65449 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759879Ab2BNJ7h (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 04:59:37 -0500
In-Reply-To: <4F397145.8040007@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 13.02.2012 21:23, Wolfgang Grandegger wrote:

> On 02/13/2012 08:55 PM, Oliver Hartkopp wrote:
>> On 13.02.2012 12:08, Wolfgang Grandegger wrote:
>>

>>>> It's not about reacting when an unlug happens, it's about not having the
>>>> interrupt handler to loop forever. At least we must limit the inner
>>>> while loop.
>>
>>
>> What happens, if inside this inner while() statement the unplug happens?
>>
>> Do we get two correct CAN frames and then we get eight CAN frames like this:
>>
>> 12345677 4 AA BB CC DD
>> 12345678 6 AA BB CC DD EE FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>
>> ???
> 
> Do you have seen such traces with the "device present" check in the
> custom handler? I doubt.


No, indeed i haven't. But plugging out PCMCIA cards 100 times a day under
traffic load is not my usual job ;-)

> First it is unlikely, that the unplug will happen when data from the
> device gets processed. And if, the check in the while loop will not
> change a lot, in contrast to the check in the custom handler. If it
> happens while processing the data, we will get grap... but well...


May be acceptable under these circumstances.

>> Sending nothing is preferred to sending wrong data :-)
> 
> You cannot avoid sending crap under any circumstances. Also be aware
> that the while loop will normally process just *one* message, and rarely
> more.


Under full load the SJA1000 internal FIFO is processed. I assume that this is
not that rare when having 6 SJA1000 based interfaces using one shared
interrupt but i did not make any measurements about this specific behavior.

>>> Of course, the loop should be limited in sja1000_interrupt anyway.
>>


ack.

>>
>> IMO checking for absent hardware in the custom isr is fine and should fix most
>> of the problems (as we can already see in the ems_pcmcia driver).
>>
>> But adding the patch which is checking two times for status != 0xFF reduces
>> the race conditions to almost zero. Having a while() statement that
>> potentially produces wrong data doesn't heal the problem IMO.
> 
> I disagree. It will not change a lot. Measurements may proof that I'm
> wrong, though.


Ok, i'll try it the other way ...

If we agree that the inner while statement needs some kind of check not to
loop forever i would like to suggest the following patch in favor to create
an additional variable for the inner while statement:


diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ebbcfca..3bec3d9 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -99,7 +99,7 @@ static int sja1000_probe_chip(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	if (priv->reg_base && (priv->read_reg(priv, 0) == 0xFF)) {
+	if (priv->reg_base && (priv->read_reg(priv, REG_MOD) == 0xFF)) {
 		printk(KERN_INFO "%s: probing @0x%lX failed\n",
 		       DRV_NAME, dev->base_addr);
 		return 0;
@@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
 		n++;
 		status = priv->read_reg(priv, REG_SR);
+		/* check for absent controller due to hw unplug */
+		if (status == 0xFF && !sja1000_probe_chip(dev))
+			break;
 
 		if (isrc & IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
@@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
 				status = priv->read_reg(priv, REG_SR);
+				/* check for absent controller */
+				if (status == 0xFF && !sja1000_probe_chip(dev))
+					break;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {

The big advantage is, that we do not need another expensive register read nor
another loop counter variable in the case everything is working fine.

Only when the _already_ read status variable becomes 0xFF we check in the
mode register if the device is still present.

And finally there's a very little chance left to create rubbish data. 

Regards,
Oliver
