From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Fri, 18 Mar 2016 20:44:48 +0100
Message-ID: <56EC5AB0.1080107@hartkopp.net>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E92BCF.1080508@hartkopp.net>
 <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E9CE32.6050504@hartkopp.net>
 <SG2PR06MB103804EF4D818384C4F24DF5C38B0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56EB17BB.9030308@hartkopp.net>
 <SG2PR06MB1038AD3F5496E8B833098229C38C0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:54144 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbcCRTpG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2016 15:45:06 -0400
In-Reply-To: <SG2PR06MB1038AD3F5496E8B833098229C38C0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/18/2016 02:23 PM, Ramesh Shanmugasundaram wrote:

>> Does it make sense to create some kind of 'configuration block'
>> consisting of the two bitrates and the ctrlmode? So that when the
>> (nominal) bitrate is provided the data bitrate and the ctrlmode is cleared
>> (aka set to initial values).
>
> "configuration block" would provide better clarity but I wonder if we need to enforce this as "can" may be the only link type forcing this.

But only CAN has these strange dependencies.

> Will it impact CAN 2.0 only controllers?
>
> ip link set can0 type can bitrate 1000000
> ip link set can0 up

I can't see why.

This example is still valid as up/down has nothing to do with bitrate & 
ctrlmode settings.

> Are other CAN FD controllers that are out in the market OK with it?

Why not? I don't see a direct impact on controllers - it's only the 
configuration interface to talk about.

> I mean if they have userland apis/gui/docs for their controller would they need an update?

The effect would be that the bitrate(s) and the ctrlmode would have to 
be provided in one netlink message - instead of up to three.

Today the only known alternative to the 'ip' tool from iproute2 is 
'libsocketcan'

http://git.pengutronix.de/?p=tools/libsocketcan.git;a=summary

But libsocketcan is not CAN FD aware by now.

> The rules I proposed yesterday would also break existing documentation and we should drop that :-(.

ACK.

>
> Hmm... user interface is a complicated topic ;-)
>
>>
>> My intention would be that the user is forced to provide all these
>> settings in one step which has to reflect the static ctrlmode too.
>>
>> E.g.
>>
>> ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on
>>
>> would be the ONLY correct way to configure the R-Car CAN FD then.
>>
>> ip link set can0 down; ip link set can0 up type can bitrate 500000
>>
>> would fail due to missing 'fd on' from static_ctrlmode and the missing
>> data bitrate.
>
> Even today it would fail with your static_ctrlmode patch.

Yes, I know - that's why I wrote it would turn that patch upside down.

> Only thing is static_ctrlmode is not explicit and would allow
>
> ip link set can0 up type can bitrate 1000000 dbitrate 1000000
>
> on PCAN -> this resolves to CAN 2.0
> on R-Car CAN FD -> this resolves to CAN FD mode

Exactly! That's why I would like to force all ctrlmode_static options to 
be passed.

In the case of R-Car CAN FD the above example would lead to an error as 
'fd on' is missing.

>
> unless the user does "ip -d link show can0" -> they would not know the mode configured.
>
>>
>> I found a currently unused ops->validate option in the netlink ops, which
>> may help us to define this kind of 'configuration block' mechanism.
>>
>
> I looked at ops->validate now. It does not seem to take an ndev arg and maybe its scope is limited to sanitize the user option only against given link type/protocol?

Oh. Without a link to the netdevice we won't be able to check the CAN FD 
capabilities - but we could check the following:

1. If we have a ctrlmode attribute and it has CAN_CTRLMODE_FD set we 
need to have bitrate and data bitrate attributes.

2. If we have a data bitrate attribute we need to have a bitrate 
attribute and a ctrlmode attribute with CAN_CTRLMODE_FD set.

> If we agree on "configuration block", we could resolve dependencies in ops->changelink at the end of the function.

That won't work as ops->changelink has no context and is executed for 
every netlink attribute separately when netlink parses the message.

> Anyways that's implementation detail as you mentioned.
>
> I am wondering if we are complicating things for ourselves. Can we say
>
> - if "nbitrate" alone is provided, configure CAN 2.0. If controller not capable, it will fail - fine.
> - if "dbitrate" is provided & FD capable, set fd mode automatically with ISO (default) or non-iso (if that's only supported). Since dbitrate is FD property, it is logical to set fd mode. Same way if "fd-non-iso on" alone is provided without "fd on", can't we take fd mode is implied? Of course explicit setting of these options are also fine (already supported today)
> - if link brought down and some options changed when it is brought up, we logical OR that with existing config and apply if valid (like all netdev & current behaviour)

The problem is that there's no defined sequence of attributes and no 
context to check this.

> This looks simpler & may not break existing documentation/expectation like
>

With my suggestion above ...

> ip link set can0 type can bitrate 1000000
-> would work

> ip link set can0 type can dbitrate 2000000
-> would fail (bitrate & 'fd on' missing)

> ip link set can0 type can fd on
-> would fail (bitrates missing)

> ip link set can0 up
-> would work as-is

> We are only improving consistency in abnormal or accidental configs this way. Yes things like "fd only or fd but non-iso only" caps are not explicit.
I think making things more explicit is a good idea.

> May be we could improve "ip -d link show can0" output to show ctrlmode -> "supported, fixed" like we print bitrate constant ranges today?
Oh - an interesting idea. Don't know whether we can extend the existing 
data structure in a backward compatible way ...

>
> However,
>
> "ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
>
> will configure PCAN (may be IFI & M_CAN) to FD mode than CAN2.0 as it is today.

Ugh.

> But why would one document such a case with dbitrate if CAN 2.0 is the intention isn't? It may not break existing expectations I believe.
>
> I think we need Marc & others to comment so that we do changes once and update conclusions in Documentation/networking/can.txt

Best regards,
Oliver

