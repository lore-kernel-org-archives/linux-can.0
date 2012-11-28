From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 16:17:35 +0100
Message-ID: <50B62B0F.9090601@grandegger.com>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B62631.8070606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49053 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab2K1PRt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:17:49 -0500
In-Reply-To: <50B62631.8070606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Henrik Bork Steffensen <hbs@rosetechnology.dk>, linux-can@vger.kernel.org

On 11/28/2012 03:56 PM, Marc Kleine-Budde wrote:
> On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
> [...]
> 
>> As mentioned above, on the c_can there is definitely a race with the
>> message ram due to the busy wait after accessing it. See:
>>
>>   http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237
>>
>>> Or is it the potential race between "c_can_start_xmit" and "c_can_do_tx" ?
>>> Or even the access to the net api?
>>>
>>> Would someone care to explain?
>>
>> I will try. In at91_start_xmit, if we get interrupted
>>
>> 	if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv))) &
>>               AT91_MSR_MRDY) ||
>>              (priv->tx_next & get_next_mask(priv)) == 0)
>>
>> 		/* HERE */
>>
>> 		netif_stop_queue(dev);
>>
>> and then at91_irq_tx() is called executing netif_wake_queue() we may end
>> up with a stopped tx queue. But I'm not yet 100% sure.
> 
> I don't think so, because after this follows[1]
> 
> 	/* Enable interrupt for this mailbox */
> 	at91_write(priv, AT91_IER, 1 << mb);
> 
> [1] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L524
> 
> So first the queued ist stopped, then the interrupt activated.

OK, if not the interrupt of another mailbox does occur before the queue
gets stopped. May that happen?

Wolfgang.
