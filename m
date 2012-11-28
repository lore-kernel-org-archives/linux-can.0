From: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 15:22:19 +0100
Message-ID: <50B61E1B.8040904@rosetechnology.dk>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([95.154.61.7]:47483 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab2K1OWV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 09:22:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dmz4.rosetechnology.dk (Postfix) with ESMTP id 33466A2FDD
	for <linux-can@vger.kernel.org>; Wed, 28 Nov 2012 15:22:19 +0100 (CET)
Received: from dmz4.rosetechnology.dk ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKU8oTOOB47D for <linux-can@vger.kernel.org>;
	Wed, 28 Nov 2012 15:22:19 +0100 (CET)
Received: from [192.168.36.250] (unknown [95.154.61.6])
	by dmz4.rosetechnology.dk (Postfix) with ESMTPA id 1665AA0294
	for <linux-can@vger.kernel.org>; Wed, 28 Nov 2012 15:22:19 +0100 (CET)
In-Reply-To: <50B4EAE1.6070400@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
> On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
> Hm, could you show your diffs.
Do You mean a diff on these 7 lines, or a diff to the original file?

>> I this case "at91_poll" is basicly the same as "c_can_poll", in both
>> cases they call the function with the spinlock in the rx chain.
> You don't need to protect against RX. Sorry, forgot that. On the c_can
> this is necessary due to concurrent accesses to the same message RAM.
Ok, I think that at91_can.c might have an issue in register access.
I am not sure, but I will look into it.

>
>> Looking at the patch Wolfgang sugested, I became uncertain of what this
>> patch actually wants to protect.
>> Is it the registers in the cpu can interface? (mailboxes and control
>> regs, i don't know the hw)
> As mentioned above, on the c_can there is definitely a race with the
> message ram due to the busy wait after accessing it. See:
>
>    http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237
>
>> Or is it the potential race between "c_can_start_xmit" and "c_can_do_tx" ?
>> Or even the access to the net api?
>>
>> Would someone care to explain?
> I will try. In at91_start_xmit, if we get interrupted
>
> 	if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv)))&
>                AT91_MSR_MRDY) ||
>               (priv->tx_next&  get_next_mask(priv)) == 0)
>
> 		/* HERE */
>
> 		netif_stop_queue(dev);
>
> and then at91_irq_tx() is called executing netif_wake_queue() we may end
> up with a stopped tx queue. But I'm not yet 100% sure.
Ok, thanks a lot.

In my case i changed the driver to only use one mailbox for transmission.
Which means that the "net_stop_queue" will be called every time a packet 
is tx'ed.
And the "net_wake_queue" will be called after the packet is actually 
transmitted.

This is as far as i can see this is 100% safe, provided that no further 
"ndo_start_xmit"
calls come before the wake_queue call.


Anyway, after removing the spin_lock from rx, it loads fine and seems to 
work.
I will do a test with the suggested changes to the tx chain and get to 
the list
if anything interesting appears.

Thank You very much for Your help so far :-)


regards,
Henrik





