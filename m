From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 15:13:32 +0200
Message-ID: <5023B77C.6020108@visionsystems.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg> <5023B38B.80702@visionsystems.de> <5023B4BE.5000104@pengutronix.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:34131 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2HINNq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 09:13:46 -0400
In-Reply-To: <5023B4BE.5000104@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>, linux-can@vger.kernel.org

Am 09.08.2012 15:01, schrieb Marc Kleine-Budde:
> On 08/09/2012 02:56 PM, Yegor Yefremov wrote:
>> Am 09.08.2012 14:46, schrieb Schmitt, Sven (EVM/8):
>>> Second try:
>>>
>>> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
>>>
>>> --- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
>>> +++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
>>> @@ -109,7 +109,9 @@ static int sp_probe(struct platform_devi
>>>  	priv = netdev_priv(dev);
>>>  
>>>  	dev->irq = res_irq->start;
>>> -	priv->irq_flags = res_irq->flags & (IRQF_TRIGGER_MASK |
>>> IRQF_SHARED);
>>> +	priv->irq_flags &= IRQF_TRIGGER_MASK;
>>> +	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
>>> +		priv->irq_flags |= IRQF_SHARED;
>>>  	priv->reg_base = addr;
>>>  	/* The CAN clock frequency is half the oscillator clock
>>> frequency */
>>>  	priv->can.clock.freq = pdata->osc_freq / 2;
>>>
>>>
>>> note: patch is compile tested only.
>>>
>>> Sven
>> O.K. Nice catch. I just picked the wrong header file
>> include/linux/interrupt.h, it should be include/linux/ioport.h. Now
>> I'll have to change my board file as well.
> A quick serach showed no mainline board using shared irq, have I missed one?

You've missed one board in our own repos. We had to much of a custom code to try to mainline this board file.

>> You can add my
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> You mean Acked-by?

Yes.

Acked-by: Yegor Yefremov <yegorslists@googlemail.com>


Yegor
