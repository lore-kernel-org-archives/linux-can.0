From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Thu, 17 Mar 2016 21:46:51 +0100
Message-ID: <56EB17BB.9030308@hartkopp.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:55685 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbcCQUrF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Mar 2016 16:47:05 -0400
In-Reply-To: <SG2PR06MB103804EF4D818384C4F24DF5C38B0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/17/2016 01:03 PM, Ramesh Shanmugasundaram wrote:

>> I do not have real objections to change the behaviour in the way that the
>> user is forced to define ALL configuration options correctly.
>>
>> It's harder but doesn't seem to have real pitfalls.
>
> I kind of agree but I think we need to think further on the user interface design. For e.g. on IFI, PCAN where capabilities can be toggled by link change
>
> - ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on -> CAN FD ISO mode
> - ip link set can0 down; ip link set can0 up type can bitrate 500000 - user wants to change CAN FD nom rate only or user wants CAN 2.0 mode switch?

When the interface is down, setting bitrate(s), ctrlmodes and e.g. 
restart-ms are independent of each other.

> 	- As of today, it will still be CAN FD ISO mode with different nominal bitrate

Yes - as no setting was provided to change ctrlmode settings.

> 	- To get into CAN 2.0 mode, user should see current state from "ip -d link show can0" and disable fd using "fd off".

Yes. This would change ctrlmode settings.

> Is this OK?

Don't know if it's clear to the user which netlink options can be 
changed independently from each other :-(

> To summarize, there are controllers that can do (capabilities)
>
> - CAN 2.0 only
> - CAN 2.0 & CAN FD (iso, non-iso) -> all combo switchable with link toggling (up/down) -> IFI, PCAN
> - CAN 2.0 & CAN FD (non-iso only) -> CAN 2.0 & CAN FD switchable with link toggling (up/down) -> M_CAN
> - CAN 2.0 only (or) CAN FD only (iso only) -> not switchable with link toggling - R-Car CAN FD
> (R-Car CAN FD can be categorized as two virtual controllers - CAN 2.0 only (or) CAN FD only (iso only) decided during power on)
> - CAN FD only (iso, non-iso) -> some unknown controller?
>
> Would the following rules be enough to have a consistent configuration?
> -------------
> CAN FD (identified by "fd on" flag passed)
> - MTU 72
> - Dbitrate MUST be provided always with "fd on"
> - Subtypes with "fd on" depending on controller capability (below args can be passed only with "fd on" passed)
> 	- ISO only supporting (some current & future controllers) - default
> 	- ISO & non-ISO (most current controllers) - identified by "fd-non-iso on/off" flag passed
> 		- unless "fd-non-iso on" is passed explicitly, it is off
> 	- non-ISO only (past & some current controllers) - identified by "fd-non-iso on" flag passed
>
> CAN 2.0 (identified with "fd off" (or) no "fd on")
> - MTU 16 (set automatically)
> - Not tolerant to FD frames
> - If FD capable, passed with "fd off" (or) "fd on" is not passed -> I think we should reset dbitrate to zero & clear all subtype bits of "fd on"
> - If FD capable, passed with dbitrate & but no "fd on" -> I think we should reject this? It is acting as CAN 2.0, why accept a dbitrate even it is not doing any harm? Just to be consistent.
> -------------

Boah - I was just wondering whether I would have to drink a beer before 
or after trying to understand all this ;-)

> I thought of resetting caps to original value when link goes down. But it may not be needed if we strictly implement the above?

I think setting a link down and up again should not change the settings.

But I wonder if we should allow the configuration in several steps:

ip link set can0 type can bitrate 1000000
ip link set can0 type can dbitrate 2000000
ip link set can0 type can fd on
ip link set can0 up

Today the can_changelink() function is not designed to process only a 
complete block of settings. It can only check the single netlink options 
for consistency.

1. ctrlmode is checked in can_changelink()
2. The (data) bitrate dependencies are checked in can_open()

Does it make sense to create some kind of 'configuration block' 
consisting of the two bitrates and the ctrlmode? So that when the 
(nominal) bitrate is provided the data bitrate and the ctrlmode is 
cleared (aka set to initial values).

My intention would be that the user is forced to provide all these 
settings in one step which has to reflect the static ctrlmode too.

E.g.

ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on

would be the ONLY correct way to configure the R-Car CAN FD then.

ip link set can0 down; ip link set can0 up type can bitrate 500000

would fail due to missing 'fd on' from static_ctrlmode and the missing 
data bitrate.

I found a currently unused ops->validate option in the netlink ops, 
which may help us to define this kind of 'configuration block' mechanism.

By adding can_validate() here

static struct rtnl_link_ops can_link_ops __read_mostly = {
         .kind           = "can",
         .maxtype        = IFLA_CAN_MAX,
         .policy         = can_policy,
         .setup          = can_setup,
         .newlink        = can_newlink,
         .changelink     = can_changelink,
         .validate       = can_validate,
(..)

we can possibly clear the bitrates and ctrlmode when we see just one of 
them in the netlink message ... or something like this.

I have to take a look into ops->validate if it fits into our needs but I 
first wanted your feedback what you think about this 'configuration 
block' idea?

Best regards,
Oliver
