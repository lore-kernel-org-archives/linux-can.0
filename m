From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Fri, 18 Mar 2016 13:23:08 +0000
Message-ID: <SG2PR06MB1038AD3F5496E8B833098229C38C0@SG2PR06MB1038.apcprd06.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:62924 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752128AbcCRNXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 18 Mar 2016 09:23:13 -0400
In-Reply-To: <56EB17BB.9030308@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> > Is this OK?
> 
> Don't know if it's clear to the user which netlink options can be changed
> independently from each other :-(

Yes

> 
> > To summarize, there are controllers that can do (capabilities)
(...)
> > -------------
> 
> Boah - I was just wondering whether I would have to drink a beer before or
> after trying to understand all this ;-)

:-)

> 
> > I thought of resetting caps to original value when link goes down. But
> it may not be needed if we strictly implement the above?
> 
> I think setting a link down and up again should not change the settings.

I agree

> 
> But I wonder if we should allow the configuration in several steps:
> 
> ip link set can0 type can bitrate 1000000 ip link set can0 type can
> dbitrate 2000000 ip link set can0 type can fd on ip link set can0 up
> 
> Today the can_changelink() function is not designed to process only a
> complete block of settings. It can only check the single netlink options
> for consistency.
> 
> 1. ctrlmode is checked in can_changelink() 2. The (data) bitrate
> dependencies are checked in can_open()

Yes

> Does it make sense to create some kind of 'configuration block'
> consisting of the two bitrates and the ctrlmode? So that when the
> (nominal) bitrate is provided the data bitrate and the ctrlmode is cleared
> (aka set to initial values).

"configuration block" would provide better clarity but I wonder if we need to enforce this as "can" may be the only link type forcing this. Will it impact CAN 2.0 only controllers? 

ip link set can0 type can bitrate 1000000
ip link set can0 up

Are other CAN FD controllers that are out in the market OK with it? I mean if they have userland apis/gui/docs for their controller would they need an update? The rules I proposed yesterday would also break existing documentation and we should drop that :-(. 

Hmm... user interface is a complicated topic ;-)

> 
> My intention would be that the user is forced to provide all these
> settings in one step which has to reflect the static ctrlmode too.
> 
> E.g.
> 
> ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on
> 
> would be the ONLY correct way to configure the R-Car CAN FD then.
> 
> ip link set can0 down; ip link set can0 up type can bitrate 500000
> 
> would fail due to missing 'fd on' from static_ctrlmode and the missing
> data bitrate.

Even today it would fail with your static_ctrlmode patch. Only thing is static_ctrlmode is not explicit and would allow 

ip link set can0 up type can bitrate 1000000 dbitrate 1000000

on PCAN -> this resolves to CAN 2.0
on R-Car CAN FD -> this resolves to CAN FD mode

unless the user does "ip -d link show can0" -> they would not know the mode configured.

> 
> I found a currently unused ops->validate option in the netlink ops, which
> may help us to define this kind of 'configuration block' mechanism.
> 

I looked at ops->validate now. It does not seem to take an ndev arg and maybe its scope is limited to sanitize the user option only against given link type/protocol? If we agree on "configuration block", we could resolve dependencies in ops->changelink at the end of the function. Anyways that's implementation detail as you mentioned.

I am wondering if we are complicating things for ourselves. Can we say

- if "nbitrate" alone is provided, configure CAN 2.0. If controller not capable, it will fail - fine.
- if "dbitrate" is provided & FD capable, set fd mode automatically with ISO (default) or non-iso (if that's only supported). Since dbitrate is FD property, it is logical to set fd mode. Same way if "fd-non-iso on" alone is provided without "fd on", can't we take fd mode is implied? Of course explicit setting of these options are also fine (already supported today)
- if link brought down and some options changed when it is brought up, we logical OR that with existing config and apply if valid (like all netdev & current behaviour)

This looks simpler & may not break existing documentation/expectation like

ip link set can0 type can bitrate 1000000
ip link set can0 type can dbitrate 2000000
ip link set can0 type can fd on 
ip link set can0 up
 
We are only improving consistency in abnormal or accidental configs this way. Yes things like "fd only or fd but non-iso only" caps are not explicit. May be we could improve "ip -d link show can0" output to show ctrlmode -> "supported, fixed" like we print bitrate constant ranges today?

However,

"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"

will configure PCAN (may be IFI & M_CAN) to FD mode than CAN2.0 as it is today. But why would one document such a case with dbitrate if CAN 2.0 is the intention isn't? It may not break existing expectations I believe. 

I think we need Marc & others to comment so that we do changes once and update conclusions in Documentation/networking/can.txt

Thanks,
Ramesh

