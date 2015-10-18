From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Sun, 18 Oct 2015 04:42:50 +0200
Message-ID: <20151018024250.GB29078@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <562151D4.3060902@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:51735 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824AbbJRCm6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Oct 2015 22:42:58 -0400
Content-Disposition: inline
In-Reply-To: <562151D4.3060902@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date:	Fri, 16 Oct 2015 21:36:52 +0200
> From: Patrick Menschel <menschel.p@posteo.de>
> To: linux-can <linux-can@vger.kernel.org>
> Subject: Re: can-j1939 API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
>  Thunderbird/38.3.0
> 
> Hi,
> 
> 1. concerning J1939, I think it would be best to implement it is a
> "view" on can0 without changing can0 itself.

What exactly do you mean with 'view'?

> As it's already been mentioned, j1939 may share the physical layer with
> other protocols, i.e. CanOpen on diesel powered railway equipment or
> proprietary protocols of some OEMs for construction machinery.
> If there is tester or application equipment installed, CCP is usually
> also present.

Thanks for the example.
IMHO, CanOpen uses only 11bit CANids, so theres no collision in the CAN
id space. Does anyone ever encountered CAN protrocols that have
collisions in the CANid space with can-j1939?

> 
> 2. concerning address claiming and address collision handling via the
> NAME property, I think it should be handled in user space, not within
> the module as you may have multiple source addresses on the same device.
> For example Engine ECU SA 0x00 and Emission Controller SA 0x3D usually
> are one and the same physical device.

I think I partly share your conclusion,
I do not understand how multiple addresses on an ECU are an argument
for handling address claiming in userspace.

> 
> Regards,
> Patrick

Kind regards,
Kurt
> 
> 
> Am 16.10.2015 um 00:04 schrieb Alex Layton:
> > On Tue, Sep 29, 2015 at 3:49 PM, Kurt Van Dijck
> > <dev.kurt@vandijck-laurijssen.be> wrote:
> >> I would like to challenge other j1939 (not necessarily socketcan+can-j1939)
> >> users to share their opinions.
> > 
> > Hello, I am the author of https://github.com/ISOBlue/isoblue-software,
> > finally getting around to participating in this list.
> > 
> >>>> If you look at http://elinux.org/J1939
> >>
> >>>> $ modprobe can-j1939
> >>
> >> This is a systemwide action, as opposed to
> >>
> >>>> $ ip link set can0 j1939 on
> >>
> >> which is an interface-wide action.
> >>
> >> Due to the nature of CAN, the kernel should not/cannot decide if CAN
> >> traffic is J1939 or not.
> >> Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the whole
> >> CAN id range for its use, and using CAN ids incompatible with j1939
> >> is regarded illegal.
> >>
> >> So this must become a switch.
> > 
> > I disagree with this, like Austin Schuh did. In my experience there is
> > almost always other non-J1939 CAN traffic present and it must be
> > possible to use both. The module should just ignore any CAN that does
> > not look right to it, and there needs to still be a way to get at the
> > other CAN on the bus through a CAN_RAW socket or something.
> > 
> >>>> and if you think about this kind of assignment, it should be implemented
> >>>> inside the j1939 stuff and not in af_can.c. The can-gw routing netlink
> >>
> >> j1939 touches af_can because address configuration via netlink is
> >> absent in af_can. j1939 adds (with seperate patches) the ability to add
> >> addressess for CAN sockets, but only for those CAN protocols that
> >> support it.
> >> I see no decent way to bypass af_can, except for creating af_j1939.
> > 
> > Sorry if this is a stupid question, but what is the point of adding
> > addresses to a CAN interface with ip? Doesn't the code creating the
> > socket set what its address and/or NAME is? My implementation does not
> > modify af_can, though it is admittedly much more simplistic than
> > Kurt's.
> > 
> >>>> I remember our discussion about the address claiming but I wonder if we
> >>>> really follow the requirement to only put functionality into the kernel
> >>>> that really has to be implemented there.
> >>
> >> The kernel tracks and validates J1939 traffic. Any userspace application
> >> can track, but none can validate & reject without duplicating effort.
> > 
> > I too think at least part of the address handling needs to be in the
> > kernel module.
> > 
> >>>> Did you take a look at https://github.com/ISOBlue/isoblue-software -
> >>>> which is far simpler - whether it can fulfill the basic functionalities
> >>>> (segmentation, etc.) to enable j1939 for Linux?
> >>
> >> I took a quick look. It appears that they only put the address claiming
> >> in the kernel. I understand that this is exactly your concern in my
> >> implementation :-).
> > 
> > Yes, my implementation does address claiming in the module. From what
> > I understand, mine does even more of the process than Kurt's does (my
> > module actually sends the address claim messages). However, my module
> > does not deal with NAMEs, only the addresses.
> > 
> > 
> > Alex
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 


