From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Mon, 19 Oct 2015 11:52:41 +0200
Message-ID: <20151019095241.GB3406@airbook.eia.lan>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <562151D4.3060902@posteo.de>
 <20151018024250.GB29078@airbook.vandijck-laurijssen.be>
 <5624667E.3080809@posteo.de>
 <562488A3.2010204@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:63062 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbJSJwz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 05:52:55 -0400
Content-Disposition: inline
In-Reply-To: <562488A3.2010204@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>, Alex Layton <alex@layton.in>

I feel it's time to explain some things

--- Original message ---
> Date:	Mon, 19 Oct 2015 08:07:31 +0200
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> To: Patrick Menschel <menschel.p@posteo.de>, linux-can
>  <linux-can@vger.kernel.org>, Alex Layton <alex@layton.in>, Kurt Van Dijck
>  <dev.kurt@vandijck-laurijssen.be>
> Subject: Re: can-j1939 API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
>  Icedove/31.8.0
> 
> Hi all,
> 
> On 19.10.2015 05:41, Patrick Menschel wrote:
> >Am 18.10.2015 um 04:42 schrieb Kurt Van Dijck:
> >>>
> >>>1. concerning J1939, I think it would be best to implement it is a
> >>>"view" on can0 without changing can0 itself.
> >>
> >>What exactly do you mean with 'view'?
> >>
> >Basically leave the can0 functionality as it is and add another
> >interface such as J1939_0 or whatever. That way other applications may
> >still use normal can0. But maybe I just misunderstood your concept,
> >sorry if that's the case.
> >

while using can-j1939, can0 (or any other iface) is still available for
can_raw etc. I would not even think of touching that.

> 
> I also have problems to understand the concept for a while now.
> 
> >>>As it's already been mentioned, j1939 may share the physical layer with
> >>>other protocols, i.e. CanOpen on diesel powered railway equipment or
> >>>proprietary protocols of some OEMs for construction machinery.
> >>>If there is tester or application equipment installed, CCP is usually
> >>>also present.
> >>
> >>Thanks for the example.
> >>IMHO, CanOpen uses only 11bit CANids, so theres no collision in the CAN
> >>id space. Does anyone ever encountered CAN protrocols that have
> >>collisions in the CANid space with can-j1939?
> >>
> >>>
> >>>2. concerning address claiming and address collision handling via the
> >>>NAME property, I think it should be handled in user space, not within
> >>>the module as you may have multiple source addresses on the same device.
> >>>For example Engine ECU SA 0x00 and Emission Controller SA 0x3D usually
> >>>are one and the same physical device.
> >>
> >>I think I partly share your conclusion,
> >>I do not understand how multiple addresses on an ECU are an argument
> >>for handling address claiming in userspace.
> >>
> >If the device running socketcan+j1939 can only have one SA, it would not
> >allow such multi-role implementations.

can-j1939 allows for multiple SA, and allows multi-role implementations.
Moreover, the system adminstrator has control over the SA's used by the
box.

This is independant from the address claiming in userspace vs. kernel
space.

> 
> I would definitely demand multi-role implementations as this is one of the
> main SocketCAN goals to have the entire networking setup running on one host
> or on different hosts without changing the application.

I see 2 distinct requirements for multi-role implementations:
a) 1 can-interface may have different addresses
b) different applications/sockets may use the same address

> 
> See:
> 
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/Documentation/networking/can.txt?h=linux-4.2.y#n185
> 
> If I understood the concepts correctly:

I believe you didn't understood all the concepts correctly.
Your excused by not being an everyday j1939 user :-)

> 
> Kurts implementation:
> - grabs the entire interface (the entire Linux box?!)

I don't grab the entire interface.
I process _all_ 29bit CAN frames because J1939, as already mentioned
before, allocates the entire 29bit CANid space.

I know you have a problem with the administrator needing to switch
can-j1939 'on', but can-j1939 is very different from CANopen on CANid
allocation.

> - binds node addresses to the interface (Linux box?!)
> - socket addressing matches the function
> 
> Alexs implementation:
> - socket addressing matches the node address
> 
> Both implement address claiming (AC) in Kernel space - which would only fit

I need to correct you.
My can-j1939 kernel space honor the AC in kernel space, as it is part of
the protocol, but it leaves all decisions (the actual claiming) to userspace.

> the SocketCAN idea of multi-role implementations, when the AC is per-socket
> in Alexs concept.

You need to explain a bit more in-depth what exactly it is you meant
here.

> We should try to move as much functionality as possible out of the kernel.

I agree

> When address claiming makes sense there it should stay there.
> 
> IMO Alexs concept is not only much smaller in code size ...

The smaller code size is due to the transport protocol not being
handled.

J1939 wants to eliminate the edge of 8 byte per CAN frame by
transparently using transport protocol.

Leaving this to userspace compromises real multi-role
functionality, as it becomes hard when 2 applications share an address
and both receive transport protocol sessions.

This is where problems arise.
So I'm very interested in how Alex solved this and what the impact on
userspace is.

Oliver, for your information, on J1939, reserved J1939 "PGN"s are used
to deliver any other PGN when it exceeds 8bytes.
So if 2 distinct applications (sharing the address) both want to send
distinct PGNs >8bytes, they will both use those reserved J1939 PGNs
instead of using the actual PGN. The actual PGN information is then packed
inside the databytes, rather than the CANid.

Kind regards,
Kurt
