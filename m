From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: can-j1939 API
Date: Tue, 29 Sep 2015 21:49:20 +0200
Message-ID: <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:14145 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbI2Ttg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 15:49:36 -0400
Content-Disposition: inline
In-Reply-To: <560ADC91.1090408@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

> Can we switch to the mailinglist for the discussion.
Yes

> On 09/29/2015 08:34 PM, Oliver Hartkopp wrote:
> > Hi Kurt,
> > 
> > I'm sorry but I still think that your implementation and configuration
> > is way to complex and not intuitive.

Marc,
This means that the API is not yet agreed on :-)

I believe this is the point where a userbase should decide
what is feasible and what not.
Up to now, the discussion was between Oliver & I, and Oliver
was/is not familiar with j1939 use.

Since Oliver listed his mains concerns here, I'll address them
with my arguments so noone needs to read old discussions.

I would like to challenge other j1939 (not necessarily socketcan+can-j1939)
users to share their opinions.

> > If you look at http://elinux.org/J1939

> > $ modprobe can-j1939

This is a systemwide action, as opposed to

> > $ ip link set can0 j1939 on

which is an interface-wide action.

Due to the nature of CAN, the kernel should not/cannot decide if CAN
traffic is J1939 or not.
Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the whole
CAN id range for its use, and using CAN ids incompatible with j1939
is regarded illegal.

So this must become a switch.

The modprobe is necessary for the same reason that the sequence

$ modprobe vcan
$ ip link add vcan0 type vcan

requires a modprobe too.
I do see the weirdness of it, although this is not new.

> > still looks weird. Adding addresses to CAN interfaces is not common -

Adding addressing to j1939 networks is one of the core principles of
j1939, whether we like it or not.
Unlike raw CAN or CANopen where each datagram gets a unique id in the
network, J1939 implements a hierarchy where 8 bits indicate the source,
and another 18bits indicate the datagrams unique id.

I don't claim that this is good design.
I do claim that this design fits real close to the addressing
used in BSD sockets, and therefore any alternative is useless new API.

As stated above, this is not the case for most other CAN protocols.

> > and if you think about this kind of assignment, it should be implemented
> > inside the j1939 stuff and not in af_can.c. The can-gw routing netlink

j1939 touches af_can because address configuration via netlink is
absent in af_can. j1939 adds (with seperate patches) the ability to add
addressess for CAN sockets, but only for those CAN protocols that
support it.
I see no decent way to bypass af_can, except for creating af_j1939.

> > API was integrated in gw.c too. IMO the sockaddr_can extension would be
> > ok - but the other implementation should be made without af_can.[ch]
> > changes.

because j1939 lives on top of af_can, the sockaddr_can extension affects
the ABI of other can protocols too. The minimal change to support the
old ABI is essential.

> > 
> > I remember our discussion about the address claiming but I wonder if we
> > really follow the requirement to only put functionality into the kernel
> > that really has to be implemented there.

The kernel tracks and validates J1939 traffic. Any userspace application
can track, but none can validate & reject without duplicating effort.

> > 
> > Did you take a look at https://github.com/ISOBlue/isoblue-software -
> > which is far simpler - whether it can fulfill the basic functionalities
> > (segmentation, etc.) to enable j1939 for Linux?

I took a quick look. It appears that they only put the address claiming
in the kernel. I understand that this is exactly your concern in my
implementation :-).

Kind regards,
Kurt
