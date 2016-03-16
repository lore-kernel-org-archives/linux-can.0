From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Wed, 16 Mar 2016 22:20:50 +0100
Message-ID: <56E9CE32.6050504@hartkopp.net>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E92BCF.1080508@hartkopp.net>
 <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:39838 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcCPVVL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2016 17:21:11 -0400
In-Reply-To: <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/16/2016 11:50 AM, Ramesh Shanmugasundaram wrote:

>>>> As we omitted to force the user to provide 'fd on' at configuration
>>>> time
>>>> - why should we force users to provide a second bitrate for a CAN2.0
>>>> operation??
>>>
>>> We are not forcing "fd on" because it is still a consistent
>> configuration w.r.t mode, mtu & bitrates.
>>
>> But the default value is "fd off" - even if no one provides this
>> configuration option all the time.
>>
>> So it's some kind of 'silent' knowledge to take a look at the MTU?
>> That's bad too.
>
> We could argue M_CAN supporting non-iso mode only as silent knowledge because we are not explicitly configuring it? The user should know what they are doing and driver should provide sanity checks for a consistent configuration IMO.

ACK

(..)

>> E.g. when I set "ip link set can0 up type can bitrate 1000000" on a PEAK
>> PCAN USB FD adapter it acts like a CAN2.0 adapter and I can send and
>> receive CAN2.0 frames.
>
> Will it generate error on CAN FD frame reception? What's the MTU?
> What's the behaviour for these configurations?
>
> ip link set can0 up type can bitrate 1000000 dbitrate 1000000
> ip link set can0 up type can bitrate 1000000 dbitrate 1000000 fd off
>
> Again, will it generate error on CAN FD frame reception? What's the MTU?
>

# ip -det link show can0
5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0
     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
	  bitrate 1000000 sample-point 0.750
	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
	  pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
	  dbitrate 1000000 dsample-point 0.750
	  dtq 50 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1
	  pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 dbrp-inc 1
	  clock 80000000

It boils down to be a CAN2.0 interface in both cases.

>>
>> When a user wants to setup CAN2.0 communication with the RCar CAN FD
>> controller he has to provide a second bitrate but not necessarily 'fd on'
>> (which is inconsistent).
>>
>> Assume the user wants to have a simple CAN2.0 setup with the RCar CAN FD.
>> The steps would be
>
> When I submit the "can-only" mode patch next, the user have the option of configuring a pure CAN 2.0 node. This would be a like a DT option "renesas,can-nofd". Of course the user has to read the manual/doc/bindings to know such capability exists.

So it's a pretty hard switch at configuration time ...

> If the user wants CAN FD only mode and still want to interoperate with CAN 2.0 node, making this differentiation explicitly in doc/configuration would be cleaner IMO.
>
>> 1. ip link set can0 up type can bitrate 1000000 2. Use the CAN_RAW socket
>> without (== default) CAN_RAW_FD_FRAMES sockopt
>>
>> At least this looks more elegant and fulfills the user needs and
>> functionality than providing an extra 'fd on' or an extra bitrate.
>>
>> The only difference 'under the hood' would be that the RCar CAN FD
>> controller would accept CAN FD frames - that are not visible on this
>> CAN_RAW socket.
>
> That would affect stats and internal counters. Still it would be a hack isn't it?

Yes it is somehow.

>>
>> IMO we would get much less problems and user disorientation when you copy
>> the bitrate into the unset data bitrate registers.
>>
>> Making everything 'really correct' would mean that the user must set 'fd
>> on'
>> every time and we would need to check whether the static ctrlmode bits are
>> always set by the user.
>
> Hmm... then M_CAN has to set
>
> ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on fd-non-iso on

Exactly!

> Not sure if we really want this? It's nice we are having a good discussion on this topic.

/me too.

At least this will turn the

	"can: fix handling of unmodifiable configuration options"

patch upside down.

I do not have real objections to change the behaviour in the way that 
the user is forced to define ALL configuration options correctly.

It's harder but doesn't seem to have real pitfalls.

@Marc & Wolfgang: What's your opinion about this?

Regards,
Oliver

