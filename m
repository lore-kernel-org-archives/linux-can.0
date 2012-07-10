From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Tue, 10 Jul 2012 21:19:17 +0200
Message-ID: <4FFC8035.6040101@hartkopp.net>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu> <4FFBC731.60408@grandegger.com> <4FFBD2BD.3020708@grandegger.com> <20120710152212.GA29637@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:43421 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab2GJTTL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 15:19:11 -0400
In-Reply-To: <20120710152212.GA29637@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hello Wolfgang, hello Ira,

On 10.07.2012 17:22, Ira W. Snyder wrote:

> On Tue, Jul 10, 2012 at 08:59:09AM +0200, Wolfgang Grandegger wrote:

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
> 


i also thought about probable impacts on other drivers and to me the idea to
include the changes in the ican3 driver is ok.

The general infrastucture of echo_skb[] can be re-used - but the access to
these skbs can be done ican3 specific. E.g. the BUG_ON() statements may become
obsolete then.

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


Good choice :-)

From the practical point you get into problems, when your CAN driver doesn't
support IFF_ECHO (e.g. the slcan driver or the legacy PEAK drivers) as people
call you on the phone and talk about traffic seen by candump but no traffic on
the bus %-(

I would suggest to have about 2-3 echo_skbs in flight. This allows to push the
tx side of the ican3 to it's max. throughput.

On the receiver side you just need to compare up to 3 frames then and when
>= 2 echo_skbs become free (NULL) you restart the tx queue.

Should be feasible with low effort ...


>> What about a device specific solution where you do the dropping of
>> looped back messages only if CAN_RAW_RECV_OWN_MSGS is off.
>>
> 
> Isn't this option per-socket, rather than per-device?


yes.

> 
> I don't have any idea how I'd implement this suggestion.
> 
> Thanks,
> Ira


Regards,
Oliver
