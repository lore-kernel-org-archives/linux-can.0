From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN Termination API - was Re: Adding new CAN driver
Date: Thu, 5 Jan 2017 14:52:19 +0100
Message-ID: <e415e809-7975-ce1a-a3e5-152230655dcd@hartkopp.net>
References: <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
 <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net>
 <SG2PR06MB1038E2022EEA5837EB6BD25BC3A60@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
 <18d3932b-8c74-a470-661d-7f2ee1a9f2f5@hartkopp.net>
 <HK2PR06MB054590B87E4D3D9F11A8598FC3920@HK2PR06MB0545.apcprd06.prod.outlook.com>
 <20161230192021.GA25322@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:27087 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdAENwa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 08:52:30 -0500
In-Reply-To: <20161230192021.GA25322@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 12/30/2016 08:20 PM, Kurt Van Dijck wrote:

>>> To add IFLA_CAN_TERMINATION we would just need
>>>
>>> 	[IFLA_CAN_TERMINATION]   = { .type = NLA_U16 },
>
> Why would you limit the API to u16?
> I understand current common values fit perfectly in an u16, but limiting
> the API to what is common today, seems like a bad plan.
> the _only_ known value, 120, fits in an u8 even.
>
> u32 does not seem to add significant overhead IMHO, and protects against
> future developments?

There are some usual termination values for the distributed termination 
in the CAN Low Speed physical layer (ISO 11898-3).

E.g. http://www.peak-system.com/PCAN-TJA1054.219.0.html?&L=1
provides a switch to set the termination to 560 Ohm / 5.66 kOhm.

But beyond 20 kOhm the CAN termination seems to be really pointless.

You are that u32 values are no big deal in todays APIs - but when the 
netlink interface provides an u16 data structure and it fits the needed 
values: Why not use u16 then?

>>>
>>> to enable a defined termination value from 1 to 65534 Ohms where 65535
>>> would be CAN_RESISTOR_DISABLED. In the CAN driver this given value is
>>> checked against the supported list of termination values and switched on
>>> if supported.
>>> To provide a list of possible termination values with
>>> IFLA_CAN_TERMINATION_CONST we need to pass an array of u16 constants to
>>> the userspace.
>>>
>>> In opposite to our current netlink messages this array make contain 1..n
>>> constant values - so defining a fixed struct of e.g. 8 entries looks like
>>> a bad design.
>>>
>>> But how to provide the array to the netlink interface correctly?
>>>
>>> With the netlink type NLA_UNSPEC, NLA_NESTED, NLA_NESTED_COMPAT or
>>> NLA_BINARY??
>>>
>>> See http://lxr.linux.no/#linux+v4.8.10/include/net/netlink.h#L160
>>>
>>> The current
>>>
>>> [IFLA_CAN_DATA_BITTIMING]  = { .len = sizeof(struct can_bittiming_const)
>>> },
>>>
>>> seems to use NLA_UNSPEC which means the .len value is the _minimum_ length
>>> value.
>>>
>>> Would this mean we can define
>>>
>>> [IFLA_CAN_TERMINATION_CONST]   = { .len = sizeof(__u16) },
>>>
>>> as a minimum length value and provide as much termination values as the
>>> CAN interface supports?
>>
>> OK. This would be a simpler option.
>>
>> Optionally, the can core could also check the given value against a list of valid termination values & round it to the nearest possible value. Something like below
>>
>> possible_termination_values = { 60, 120, 240  } /* some random numbers */
>>
>> - if user_val < 60 -> use 60
>> - if user_val > 240 -> use 240
>> - if user_val falls within a range of the possible values
>>     if ((range_low + (range_high - range_low) / 2)) <= user_val)
>> 	user_val = range_low;
>>     else
>>       user_val = range_high;
>>
>>    ret = driver_callback(user_val)
>>
>> I felt the error reporting would be consistent. It is up to you.
>
> I think that it is a bad idea to implement rounding in kernel space.

Yes - I feel the same.

> The algorithm you specify is rather trivial, and I'd do the same, but
> is subject to change and belongs to userspace.
>
> When rounding to the nearest is done in the kernel, that happens on
> places where the nearest is not communicated to userspace, which has
> been solved in this case by providing a list of possible values.

ACK. As the plan is to provide this list userspace has to pick one of 
these values and the kernel can easily check for matches.

Regards,
Oliver
