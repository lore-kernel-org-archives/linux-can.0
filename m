From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 11:41:30 +0100
Message-ID: <4F38E8DA.9060000@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:43420 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2BMKlf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:41:35 -0500
In-Reply-To: <4F38E274.4050304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 13.02.2012 11:14, Wolfgang Grandegger wrote:


>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>> b/drivers/net/can/sja1000/sja1000.c
>>> index ebbcfca..f7526a7 100644
>>> --- a/drivers/net/can/sja1000/sja1000.c
>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>>>                  n++;
>>>                  status = priv->read_reg(priv, REG_SR);
>>>
>>> +               /* check for absent controller due to hw unplug */
>>> +               if (status == 0xFF)
>>> +                       break;
>>> +
>>>                  if (isrc&  IRQ_WUI)
>>>                          netdev_warn(dev, "wakeup interrupt\n");
>>>
>>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>>>                          netif_wake_queue(dev);
>>>                  }
>>>                  if (isrc&  IRQ_RI) {
>>> -                       /* receive interrupt */
>>> -                       while (status&  SR_RBS) {
>>> +                       /* receive interrupt / check for absent controller */
>>> +                       while (status&  SR_RBS&&  status != 0xFF) {
>>>                                  sja1000_rx(dev);
>>>                                  status = priv->read_reg(priv, REG_SR);
>>>                          }
>>>
>>> @Stephane: Can you check that patch? I'm out of hw right now.
>>
>> I confirm that this patch works too...
>> So I think I should be able to post a new version of the peak_pcmcia
>> during that day (the previous should work but some calls to
>> pcmcia_dev_present() are no more useful...)
> 
> But that fix should not go to the common interrupt handler, if possible.


Do you have an idea how to handle the while() statement without copying the
entire interrupt handler code for the devices that might be unplugged?

IMHO this patch is pretty cheap.

Regards,
Oliver

ps. @Stephane: I just made a screencopy of my suggested patch - so there may
be whitepace issues then, sorry.
