From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Fri, 30 Oct 2015 00:38:06 +0100
Message-ID: <20151029233806.GA12740@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
 <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
 <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
 <20151023111430.GB22388@airbook.eia.lan>
 <56327492.9030405@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:63646 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050AbbJ2Xit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2015 19:38:49 -0400
Content-Disposition: inline
In-Reply-To: <56327492.9030405@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date: Thu, 29 Oct 2015 20:33:38 +0100
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> To: Alex Layton <alex@layton.in>, Kurt Van Dijck
>  <dev.kurt@vandijck-laurijssen.be>
> CC: linux-can <linux-can@vger.kernel.org>
> Subject: Re: can-j1939 API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
>  Icedove/31.8.0
> 
> Hi Kurt,
> 
> On 10/23/2015 01:14 PM, Kurt Van Dijck wrote:
> >>>> ...
> >>>> Can you not have you module only listen on
> >>>> interfaces where J1939 sockets have been opened?
> >>>
> >>> That sounds like a fine idea!
> >>> It would behave slightly different during booting, but given the critics
> >>> on the switch, this will probably the best thing to do.
> >>> This implies that a non-root user decides to turn on can-j1939
> >>> processing on an interface, which I found a hard nut to crack.
> >>
> >> I had not really considered the user permissions ramifications of
> >> things. You raise a good point here.
> >>
> >> Doesn't SocketCAN automatically load the protocol module when you try
> >> to open a socket? That means non-root users can already decide to turn
> >> on processing on an interface for ISOTP etc. I am good with non-root
> >> users being able to enable J1939 like this, especially if the
> >> precedent is already set by other protocols.
> > 
> > Yep, I can follow that argument.
> > When I get to it, I'll change that.
> > It also implies I can drop iproute2-j1939 branches completely.
> > 
> 
> Just to be sure I understood it correctly:
> 
> No iproute2-j1939 branch -> no address support for j1939 in iproute
> -> no address support in af_can.c ?? \o/

indeed.
Next to the address support, I also would then drop the link status
support (i.e. ip link set can0 j1939 on/off).

> 
> So you would automatically take care of SA/Name when a j1939 socket is created
> with the according address information (== per-socket), right?

All SA or Name info comes via that way, indeed.
Any can-j1939 socket (regardless the user) could bind to a new SA or Name.

'per socket' is a bit dubious. In contrast to Alex, I would not restrict
a specific SA or Name to a single socket for reasons I gave earlier.

Kurt
