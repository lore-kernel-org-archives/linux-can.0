From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Framework for hardware filter support?
Date: Tue, 13 Feb 2018 21:44:28 +0100
Message-ID: <a7d68298-d0b1-0d64-de48-eb5f75a8577d@hartkopp.net>
References: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
 <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
 <6c112388-5dcb-2dca-06c6-eac56d470fbb@pobox.com>
 <20180213194203.GA15640@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:19015 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeBMUow (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Feb 2018 15:44:52 -0500
In-Reply-To: <20180213194203.GA15640@airbook.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Santos <daniel.santos@pobox.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can <linux-can@vger.kernel.org>

Hi Kurt,

On 02/13/2018 08:42 PM, Kurt Van Dijck wrote:
> On zo, 11 feb 2018 16:33:43 -0600, Daniel Santos wrote:
>>> where the CAN_RAW filter design would easily fit.
>>
>> This is what I mean by a framework.  So the driver should inform the
>> core CAN driver what it's filtering capabilities are -- again, I would
>> have to study a number of devices to design this sanely.  It would seem
>> that iproute2 would be the best userland mechanism to specify them, and
>> it could pass an array of struct can_filter objects.  Then based upon
>> the hardware, it can apply or reject them.  It would also be nice for
>> iproute2 to query the driver and be able to report those capabilities.
> 
> I remember this discussion has passed a few times already.
> The end result has always been to:
> 1. give the kernel/driver a list of id/masks.
> 2. The driver does no aggregation, the root operator should know
>     what to do.
> 
> Maybe some day this will become limited for hardware that can do special
> tricks, like having a random list of identifiers.
> This can most probable be addressed in some clever way that is specific
> for the driver (like adding a list of id/masks where mask is always
> 0x7ff for a random canid list).
> Due to the driver doing smart things, the driver may not be capable of
> informing filtering capabilities in a static way. I would start without
> it.

Ack.

> The support of hardware filters is hardware specific anyway, and
> intersects the multi-user principle. The only justification is ....
> that the root operator knows the hardware and the application.
> 
> What matters for a generic implementation is that the API is simple,
> clear and usable. That is where the id/mask list pops in.
> Operators that don't understand the id/mask list will probably fail
> anyway to use hardware filters on CAN. No framework can prevent that.
> 

Full ACK!

I'm currently looking into netlink how to pass a larger number of struct 
can_filter objects to the CAN driver.

I've checked the M_CAN IP core and the RX filters can be up to 128 
standard ID filters and up to 64 extended ID filters where latter seem 
to share a common mask.

There is some NLA_NESTED data type which seems to be the right way to 
transfer arrays of can_filter's - but I did not get completely behind it 
yet ;-)

Best,
Oliver
