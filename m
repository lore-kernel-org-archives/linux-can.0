From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Sun, 18 Oct 2015 04:32:25 +0200
Message-ID: <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:36540 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbJRCcs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Oct 2015 22:32:48 -0400
Content-Disposition: inline
In-Reply-To: <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>
Cc: linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date:	Thu, 15 Oct 2015 18:04:58 -0400
> From: Alex Layton <alex@layton.in>
> To: linux-can <linux-can@vger.kernel.org>
> Subject: Re: can-j1939 API
> 
> On Tue, Sep 29, 2015 at 3:49 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> > I would like to challenge other j1939 (not necessarily socketcan+can-j1939)
> > users to share their opinions.
> 
> Hello, I am the author of https://github.com/ISOBlue/isoblue-software,
> finally getting around to participating in this list.
> 
> > > > If you look at http://elinux.org/J1939
> >
> > > > $ modprobe can-j1939
> >
> > This is a systemwide action, as opposed to
> >
> > > > $ ip link set can0 j1939 on
> >
> > which is an interface-wide action.
> >
> > Due to the nature of CAN, the kernel should not/cannot decide if CAN
> > traffic is J1939 or not.
> > Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the whole
> > CAN id range for its use, and using CAN ids incompatible with j1939
> > is regarded illegal.
> >
> > So this must become a switch.
> 
> I disagree with this, like Austin Schuh did. In my experience there is
> almost always other non-J1939 CAN traffic present and it must be
> possible to use both. The module should just ignore any CAN that does
> not look right to it, and there needs to still be a way to get at the
> other CAN on the bus through a CAN_RAW socket or something.

The 'switch' is to turn can-j1939 on/off on a specific interface.
The condition that I'd like to solve is where you end up having a
j1939 bus can0, obviously with 29bit CAN id's, and another bus, can1,
that is NOT j1939 compliant while using 29bit identifiers.

I'd prefer to disable can-j1939 processing on can1 in that case, before
reporting any obvious protocol violations in the log.

> 
> > > > and if you think about this kind of assignment, it should be implemented
> > > > inside the j1939 stuff and not in af_can.c. The can-gw routing netlink
> >
> > j1939 touches af_can because address configuration via netlink is
> > absent in af_can. j1939 adds (with seperate patches) the ability to add
> > addressess for CAN sockets, but only for those CAN protocols that
> > support it.
> > I see no decent way to bypass af_can, except for creating af_j1939.
> 
> Sorry if this is a stupid question, but what is the point of adding
> addresses to a CAN interface with ip? Doesn't the code creating the
> socket set what its address and/or NAME is? My implementation does not
> modify af_can, though it is admittedly much more simplistic than
> Kurt's.

I offloaded the (static) addressing onto the kernel, so I needs to know
its address, much like any other address-capable protocol like e.g. ipv4.
Its obviously that not every ipv4 capable application needs to know it
local ip address. I made can-j1939 likewise multi-user ready.

> 
> > > > I remember our discussion about the address claiming but I wonder if we
> > > > really follow the requirement to only put functionality into the kernel
> > > > that really has to be implemented there.
> >
> > The kernel tracks and validates J1939 traffic. Any userspace application
> > can track, but none can validate & reject without duplicating effort.
> 
> I too think at least part of the address handling needs to be in the
> kernel module.
> 
> > > > Did you take a look at https://github.com/ISOBlue/isoblue-software -
> > > > which is far simpler - whether it can fulfill the basic functionalities
> > > > (segmentation, etc.) to enable j1939 for Linux?
> >
> > I took a quick look. It appears that they only put the address claiming
> > in the kernel. I understand that this is exactly your concern in my
> > implementation :-).
> 
> Yes, my implementation does address claiming in the module. From what
> I understand, mine does even more of the process than Kurt's does (my
> module actually sends the address claim messages). However, my module
> does not deal with NAMEs, only the addresses.

I'd like to know your idea:
Is it possible with isoblue to have multiple sockets using the same
source address?
How does an application needs to deal with address changes? Does every
application just receives the address claims without asking?

Kurt
