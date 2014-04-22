From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Bitrate and CAN status support for slcan
Date: Tue, 22 Apr 2014 21:50:15 +0200
Message-ID: <5356C7F7.6070307@hartkopp.net>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <5352CD6C.2090601@hartkopp.net> <18170537.PzX3L82o9E@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:19864 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaDVTuS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Apr 2014 15:50:18 -0400
In-Reply-To: <18170537.PzX3L82o9E@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Hello Alexander,

On 22.04.2014 09:08, Alexander Stein wrote:

> On Saturday 19 April 2014 21:24:28, Oliver Hartkopp wrote:
>> IMO your entire patch set has a major design flaw.
>>
>> The general serial line discipline concept is a data encapsulation driver
>> which converts PDUs into a serial line data stream.
>>
>> If you check other implementations of serial line disciplines from
>>
>> http://lxr.free-electrons.com/source/include/uapi/linux/tty.h
>>
>> you'll see that their functionality is to encapsulate datagramms and/or
>> support different modes for this functionality on the serial line.
>>
>> There's no interaction on the serial stream triggered by open/close of the
>> device - which additionally breaks the current userspace, which assumes to 
> be
>> responsible for the ASCII open/close commands.
> 
> I'm aware that this change behavior is different than before, which is
> intended! The current problem we have is that there is no way changing
> the bitrate and get CAN status information using the interface you use with
> "normal" CAN drivers, e.g. c_can. The whole patch series is intended to make
> them behave more similar.

You can't polish crap. You just can put some whipped cream and a cherry onto
it - which your patch set obviously tries to do ;-)

The SLCAN is a simple encapsulation protocol - and we are also using it in
some setups even when I always try to bring people 'on the right path' :-)

> The problem here is the bitrate setting using netlink. If the device is
> already started because some external userspace application send the 
> approriate command no bitrate change can be done, even before the CAN 
> interface itself has started!
> In order to let slcan change the bitrate it must be ensured where serial CAN
> interface is shutdown before and start when the CAN interface is put 'UP'.

Better solve this with scripts and slcand.

Usually the bitrate of the attached CAN network is known and fixed.
After all the updates from Yegor the slcand is a handy and powerful tool for
SLCAN configuration. Adding netlink support and do fake bitrate calculation
checks, etc. makes the slcan.c even worse.

> 
>> Same problem with the status polling:
>> It introduces a functionality which has impacts to statistics depending on 
> the
>> given poll rate. Are the values consumed with answer to the 'F' command or
>> does the next polled status represent the same status content?
> 
> AFAIK the represent the current state, so polling them faster without an 
> actual state change returns the same as when polling slower.

ok.

I've seen that you compare the status to the previous one to detect changes.
IMO this works with the general status like
SLC_CAN_FLAG_ERR_WARN, SLC_CAN_FLAG_ERR_PASV and SLC_CAN_FLAG_BUS_ERR.

But it does not work with SLC_CAN_FLAG_OVERRUN and SLC_CAN_FLAG_ARB_LOST as
these bits need to be consumed by the SLCAN-adapter to be correct.

That's the problem with polling/sampling stats that are originally event
based. IMHO you try to interpret this 'F' status beyond it's entropy.

>> You introduced an automatism which does not look reliable to me.
>>
>> What about creating a 'F' command on the serial line when you send a CAN 
> frame
>> with the CAN_ERR_FLAG set down to the slcan device?
>> The answer of the slcan device can then be converted to a CAN frame similar 
> to
>> the way you suggested in patch 5.
> 
> Mh, this could be an additional feature, e.g. when polling is disabled (value 
> of 0?). But I think the polling should stay, otherwise userspace needs 
> additional handling of this special CAN interface compared to others.

It will never be like a real CAN controller. SLCAN is a simple but incomplete
protocol to attach some existing low-cost CAN adapters and provide a network
device for CAN applications. And together with slcand it does it's job -
including serial line setup and CAN bitrate setup.

Introducing all your suggested features does not make the SLCAN protocol
better nor does it bring a real benefit to the end user. If you want to have
all the CAN_DEV netlink features just buy a better CAN adapter/controller.

IMO it's an improvement to be able to query the SLCAN adapter status
especially in the case the CAN interface got stuck for some reason.

Don't know if this (polling) needs to be done in kernel space.
Probably slcand can be extended to send and evaluate CAN error messages to
restart the interface then (e.g. once every second).

>> - Don't make the slcan driver depend on the CAN_DEV stuff: It's just
>> encapsulation which is done in slcan.c - it's no really a CAN controller 
> driver.
> 
> Which makes it much more circumstantial to use, because it relies on different 
> userspace handling.

Yes. SLCAN is at least 'special' and we can not really fix this situation by
implementing some lovely configuration interface around it which rises user
expectations beyond the real provided adapter functionality users know from
'good' CAN adapters.

>> Sorry but finally only the 'on demand' retrieval of the SLCAN status via
>> CAN_ERR_FLAG set in a sent CAN frame looks like a potentially valuable
>> improvement to me.
> 
> Don't forget patch 1 ;-)

Oh, yes.

Will send my Acked-by for this patch in a minute!

Best regards,
Oliver

