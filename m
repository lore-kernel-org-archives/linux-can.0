From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 21:23:33 +0100
Message-ID: <4F397145.8040007@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35513 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844Ab2BMUXm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 15:23:42 -0500
In-Reply-To: <4F396AC9.8090308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/13/2012 08:55 PM, Oliver Hartkopp wrote:
> On 13.02.2012 12:08, Wolfgang Grandegger wrote:
> 
>> On 02/13/2012 12:06 PM, Marc Kleine-Budde wrote:
>>> On 02/13/2012 12:02 PM, Wolfgang Grandegger wrote:
>>>> On 02/13/2012 11:41 AM, Oliver Hartkopp wrote:
>>>>> On 13.02.2012 11:14, Wolfgang Grandegger wrote:
>>>>>
>>>>>
>>>>>>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>>>>>>> b/drivers/net/can/sja1000/sja1000.c
>>>>>>>> index ebbcfca..f7526a7 100644
>>>>>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>>>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>>>>>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>>>>>>>>                  n++;
>>>>>>>>                  status = priv->read_reg(priv, REG_SR);
>>>>>>>>
>>>>>>>> +               /* check for absent controller due to hw unplug */
>>>>>>>> +               if (status == 0xFF)
>>>>>>>> +                       break;
>>>>>>>> +
>>>>>>>>                  if (isrc&  IRQ_WUI)
>>>>>>>>                          netdev_warn(dev, "wakeup interrupt\n");
>>>>>>>>
>>>>>>>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>>>>>>>>                          netif_wake_queue(dev);
>>>>>>>>                  }
>>>>>>>>                  if (isrc&  IRQ_RI) {
>>>>>>>> -                       /* receive interrupt */
>>>>>>>> -                       while (status&  SR_RBS) {
>>>>>>>> +                       /* receive interrupt / check for absent controller */
>>>>>>>> +                       while (status&  SR_RBS&&  status != 0xFF) {
>>>>>>>>                                  sja1000_rx(dev);
>>>>>>>>                                  status = priv->read_reg(priv, REG_SR);
>>>>>>>>                          }
>>>>>>>>
>>>>>>>> @Stephane: Can you check that patch? I'm out of hw right now.
>>>>>>>
>>>>>>> I confirm that this patch works too...
>>>>>>> So I think I should be able to post a new version of the peak_pcmcia
>>>>>>> during that day (the previous should work but some calls to
>>>>>>> pcmcia_dev_present() are no more useful...)
>>>>>>
>>>>>> But that fix should not go to the common interrupt handler, if possible.
>>>>>
>>>>>
>>>>> Do you have an idea how to handle the while() statement without copying the
>>>>> entire interrupt handler code for the devices that might be unplugged?
>>>>>
>>>>> IMHO this patch is pretty cheap.
>>>>
>>>> I think it's enough to add a read in the custom pcmcia isr before
>>>> calling sja1000_interrupt(). Maybe the race window is a bit lower but we
>>>> are not able to react when the unplug happens anyway.
> 
> 
> Does this mean, it is 'less bad'?

No.

>>> It's not about reacting when an unlug happens, it's about not having the
>>> interrupt handler to loop forever. At least we must limit the inner
>>> while loop.
> 
> 
> What happens, if inside this inner while() statement the unplug happens?
> 
> Do we get two correct CAN frames and then we get eight CAN frames like this:
> 
> 12345677 4 AA BB CC DD
> 12345678 6 AA BB CC DD EE FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
> 
> ???

Do you have seen such traces with the "device present" check in the
custom handler? I doubt.

First it is unlikely, that the unplug will happen when data from the
device gets processed. And if, the check in the while loop will not
change a lot, in contrast to the check in the custom handler. If it
happens while processing the data, we will get grap... but well...

> Sending nothing is preferred to sending wrong data :-)

You cannot avoid sending crap under any circumstances. Also be aware
that the while loop will normally process just *one* message, and rarely
more.

>> Of course, the loop should be limited in sja1000_interrupt anyway.
> 
> 
> IMO checking for absent hardware in the custom isr is fine and should fix most
> of the problems (as we can already see in the ems_pcmcia driver).
> 
> But adding the patch which is checking two times for status != 0xFF reduces
> the race conditions to almost zero. Having a while() statement that
> potentially produces wrong data doesn't heal the problem IMO.

I disagree. It will not change a lot. Measurements may proof that I'm
wrong, though.

Wolfgang.


