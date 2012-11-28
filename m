From: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 16:17:59 +0100
Message-ID: <50B62B27.8020902@rosetechnology.dk>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B61E1B.8040904@rosetechnology.dk> <50B621DF.3050505@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([95.154.61.7]:47515 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab2K1PSA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:18:00 -0500
In-Reply-To: <50B621DF.3050505@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On 11/28/2012 03:38 PM, Wolfgang Grandegger wrote:
> On 11/28/2012 03:22 PM, Henrik Bork Steffensen wrote:
>> On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
>>> On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
>>> Hm, could you show your diffs.
>> Do You mean a diff on these 7 lines, or a diff to the original file?
>>
>>>> I this case "at91_poll" is basicly the same as "c_can_poll", in both
>>>> cases they call the function with the spinlock in the rx chain.
>>> You don't need to protect against RX. Sorry, forgot that. On the c_can
>>> this is necessary due to concurrent accesses to the same message RAM.
>> Ok, I think that at91_can.c might have an issue in register access.
>> I am not sure, but I will look into it.
>>
>>>> Looking at the patch Wolfgang sugested, I became uncertain of what this
>>>> patch actually wants to protect.
>>>> Is it the registers in the cpu can interface? (mailboxes and control
>>>> regs, i don't know the hw)
>>> As mentioned above, on the c_can there is definitely a race with the
>>> message ram due to the busy wait after accessing it. See:
>>>
>>>     http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237
>>>
>>>> Or is it the potential race between "c_can_start_xmit" and
>>>> "c_can_do_tx" ?
>>>> Or even the access to the net api?
>>>>
>>>> Would someone care to explain?
>>> I will try. In at91_start_xmit, if we get interrupted
>>>
>>>      if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv)))&
>>>                 AT91_MSR_MRDY) ||
>>>                (priv->tx_next&   get_next_mask(priv)) == 0)
>>>
>>>          /* HERE */
>>>
>>>          netif_stop_queue(dev);
>>>
>>> and then at91_irq_tx() is called executing netif_wake_queue() we may end
>>> up with a stopped tx queue. But I'm not yet 100% sure.
>> Ok, thanks a lot.
>>
>> In my case i changed the driver to only use one mailbox for transmission.
>> Which means that the "net_stop_queue" will be called every time a packet
>> is tx'ed.
>> And the "net_wake_queue" will be called after the packet is actually
>> transmitted.
>>
>> This is as far as i can see this is 100% safe, provided that no further
>> "ndo_start_xmit"
>> calls come before the wake_queue call.
> Yes, then the race should be gone. Anyway, we don't want that solution.
We will probably move back to a number of TX mailboxes after resolving 
the lockup.


>> Anyway, after removing the spin_lock from rx, it loads fine and seems to
>> work.
> It would help use to know if a spin-lock protecting the whole
> at91_start_xmit() and at91_start_xmit() functions does *really* fix your
> "tx-does-not-work-any-more" problem. Then we are rather sure that there
> is a race.
I will get back with a status.
I think we need at week for the test.

>
>> I will do a test with the suggested changes to the tx chain and get to
>> the list
>> if anything interesting appears.
> Not sure what changes you have in mind?
Just the ones You suggested :-)

Anyway, I attached this small patch to my reply to Marc a few minutes ago.


Best regards,
Henrik

