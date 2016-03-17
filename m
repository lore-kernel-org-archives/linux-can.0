From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Thu, 17 Mar 2016 12:03:41 +0000
Message-ID: <SG2PR06MB103804EF4D818384C4F24DF5C38B0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E92BCF.1080508@hartkopp.net>
 <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E9CE32.6050504@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:57428 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753700AbcCQMDp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 17 Mar 2016 08:03:45 -0400
In-Reply-To: <56E9CE32.6050504@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> >>> We are not forcing "fd on" because it is still a consistent
> >> configuration w.r.t mode, mtu & bitrates.
(...)
> >
> > Will it generate error on CAN FD frame reception? What's the MTU?
> > What's the behaviour for these configurations?
> >
> > ip link set can0 up type can bitrate 1000000 dbitrate 1000000 ip link
> > set can0 up type can bitrate 1000000 dbitrate 1000000 fd off
> >
> > Again, will it generate error on CAN FD frame reception? What's the MTU?
> >
> 
> # ip -det link show can0
> 5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> 	  bitrate 1000000 sample-point 0.750
> 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
> 	  pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc
> 1
> 	  dbitrate 1000000 dsample-point 0.750
> 	  dtq 50 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1
> 	  pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 dbrp-
> inc 1
> 	  clock 80000000
> 
> It boils down to be a CAN2.0 interface in both cases.

Thanks. Good to know

> 
> >>
> >> When a user wants to setup CAN2.0 communication with the RCar CAN FD
> >> controller he has to provide a second bitrate but not necessarily 'fd
> on'
> >> (which is inconsistent).
> >>
> >> Assume the user wants to have a simple CAN2.0 setup with the RCar CAN
> FD.
> >> The steps would be
> >
> > When I submit the "can-only" mode patch next, the user have the option
> of configuring a pure CAN 2.0 node. This would be a like a DT option
> "renesas,can-nofd". Of course the user has to read the manual/doc/bindings
> to know such capability exists.
> 
> So it's a pretty hard switch at configuration time ...

Yes. It is a global setting for the controller (applied to both channels) and switches the register map itself. Toggling CAN-only/CAN FD-only mode involves a board reset.

I have to correct one of my earlier statements. The manual says, in CAN FD only mode the controller still needs a "valid" DTSEG (data bitrate) config to interoperate with CAN 2.0 only nodes. I wrongly mentioned it MUST be "same" as nominal. Sorry about that :-( 

> 
> > If the user wants CAN FD only mode and still want to interoperate with
> CAN 2.0 node, making this differentiation explicitly in doc/configuration
> would be cleaner IMO.
> >
> >> 1. ip link set can0 up type can bitrate 1000000 2. Use the CAN_RAW
> >> socket without (== default) CAN_RAW_FD_FRAMES sockopt
> >>
> >> At least this looks more elegant and fulfills the user needs and
> >> functionality than providing an extra 'fd on' or an extra bitrate.
(...)
> > Hmm... then M_CAN has to set
> >
> > ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on
> > fd-non-iso on
> 
> Exactly!
> 
> > Not sure if we really want this? It's nice we are having a good
> discussion on this topic.
> 
> /me too.
> 
> At least this will turn the
> 
> 	"can: fix handling of unmodifiable configuration options"
> 
> patch upside down.
> 
> I do not have real objections to change the behaviour in the way that the
> user is forced to define ALL configuration options correctly.
> 
> It's harder but doesn't seem to have real pitfalls.

I kind of agree but I think we need to think further on the user interface design. For e.g. on IFI, PCAN where capabilities can be toggled by link change

- ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on -> CAN FD ISO mode
- ip link set can0 down; ip link set can0 up type can bitrate 500000 - user wants to change CAN FD nom rate only or user wants CAN 2.0 mode switch?
	- As of today, it will still be CAN FD ISO mode with different nominal bitrate
	- To get into CAN 2.0 mode, user should see current state from "ip -d link show can0" and disable fd using "fd off".

Is this OK?

To summarize, there are controllers that can do (capabilities)

- CAN 2.0 only
- CAN 2.0 & CAN FD (iso, non-iso) -> all combo switchable with link toggling (up/down) -> IFI, PCAN
- CAN 2.0 & CAN FD (non-iso only) -> CAN 2.0 & CAN FD switchable with link toggling (up/down) -> M_CAN
- CAN 2.0 only (or) CAN FD only (iso only) -> not switchable with link toggling - R-Car CAN FD
(R-Car CAN FD can be categorized as two virtual controllers - CAN 2.0 only (or) CAN FD only (iso only) decided during power on)
- CAN FD only (iso, non-iso) -> some unknown controller?

Would the following rules be enough to have a consistent configuration?
-------------
CAN FD (identified by "fd on" flag passed)
- MTU 72
- Dbitrate MUST be provided always with "fd on"
- Subtypes with "fd on" depending on controller capability (below args can be passed only with "fd on" passed)
	- ISO only supporting (some current & future controllers) - default
	- ISO & non-ISO (most current controllers) - identified by "fd-non-iso on/off" flag passed
		- unless "fd-non-iso on" is passed explicitly, it is off
	- non-ISO only (past & some current controllers) - identified by "fd-non-iso on" flag passed

CAN 2.0 (identified with "fd off" (or) no "fd on")
- MTU 16 (set automatically)
- Not tolerant to FD frames
- If FD capable, passed with "fd off" (or) "fd on" is not passed -> I think we should reset dbitrate to zero & clear all subtype bits of "fd on"
- If FD capable, passed with dbitrate & but no "fd on" -> I think we should reject this? It is acting as CAN 2.0, why accept a dbitrate even it is not doing any harm? Just to be consistent.
-------------

I thought of resetting caps to original value when link goes down. But it may not be needed if we strictly implement the above?

Thanks,
Ramesh
