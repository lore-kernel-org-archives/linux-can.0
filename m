From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Tue, 10 Jul 2012 22:34:06 +0200
Message-ID: <4FFC91BE.5010004@grandegger.com>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu> <4FFBC731.60408@grandegger.com> <4FFBD2BD.3020708@grandegger.com> <20120710152212.GA29637@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59379 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab2GJUeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 16:34:13 -0400
In-Reply-To: <20120710152212.GA29637@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

On 07/10/2012 05:22 PM, Ira W. Snyder wrote:
> On Tue, Jul 10, 2012 at 08:59:09AM +0200, Wolfgang Grandegger wrote:
>> On 07/10/2012 08:09 AM, Wolfgang Grandegger wrote:
>>> Hi Ira,
>>>
>>> On 07/09/2012 09:56 PM, Ira W. Snyder wrote:
>>>> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>>>>
>>>> This is another different approach to fixing the Janz ICAN3 support for
>>>> CAN_RAW_RECV_OWN_MSGS.
>>>>
>>>> The can_put_echo_skb() function is changed to always keep all packets
>>>> until can_get_echo_skb() is called. Previously, it would drop packets if
>>>> they were not needed to be looped back. This makes it possible for the
>>>> new function can_cmp_echo_skb() to work with hardware-assisted loopback
>>>> support on the Janz ICAN3, which does not have TX-complete interrupts of
>>>> any kind.
>>>>
>>>> Since we are now storing packets even in the non-loopback case, there is
>>>> some extra memory overhead, to store the extra packets between the calls
>>>> to can_put_echo_skb() and can_get_echo_skb().
>>>
>>> Well, I don't like such device specific quirk going into the common
>>> interface.
>>
>> Be aware, all other drivers will suffer from that change!
>>
> 
> I understand that. If you prefer, I can copy can_put_echo_skb() and
> can_get_echo_skb() with my modifications into the janz-ican3 driver
> itself, and leave the generic ones alone.

Definitely, this is special handling for that device only. Till now we
have no other device needing a similar quirk.

>>>> After this patch series is applied, the SocketCAN tst-rcv-own-msgs test
>>>> passes.
>>>>
>>>> Performance is rougly 15% less than using the previously posted patch:
>>>> [PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
>>
>> Are the 15% only relevant if CAN_RAW_RECV_OWN_MSGS is off?
>>
> 
> The performance difference happens in all cases. The ican3 hardware
> doesn't have a TX-done interrupt, but the programming guide does promise
> that the hardware loopback will not return the echo packet until it has
> been successfully transmitted onto the bus. It does appear to work
> correctly.
> 
> I talked with my coworker who is more knowledgable about the CAN bus. We
> decided we like this patch as written, since we will be able to get more
> accurate timing information by sending a packet and timing how long it
> takes to receive it back using CAN_RAW_RECV_OWN_MSGS.
> 
>>> Oops, that's a lot and a clear contra.
>>>
>>>> This performance drop is due to the extra overhead of receiving the echo
>>>> packets from the card itself. This involves one extra interrupt for each
>>>> packet sent, and the associated overhead of running ican3_napi() for
>>>> each packet sent.
>>>
>>> Do we really want that. I agree that CAN_RAW_RECV_OWN_MSGS should work
>>> as expected but we should not try hard to partially fix the timing
>>> issue. Why do we not just use the default protocol callback (flags &=
>>> !IFF_ECHO) if the hardware cannot do it better.
>>
>> Well, getting a looped back message even if it did not go out to the bus
>> is not nice either.
>>
> 
> Right. As noted above, we have decided that we like this patch, since it
> only loops back packets that have actually made it onto the bus.
> 
>> What about a device specific solution where you do the dropping of
>> looped back messages only if CAN_RAW_RECV_OWN_MSGS is off.
>>
> 
> Isn't this option per-socket, rather than per-device?
> 
> I don't have any idea how I'd implement this suggestion.

Hm, the xmit function does know if the packet should be looped back. If
not, the skb will be freed:

  http://lxr.linux.no/#linux+v3.4.4/drivers/net/can/dev.c#L285

Can't that be used to decide if the packet should be stored, restored
and removed if it matches a looped back message?

Wolfgang.
