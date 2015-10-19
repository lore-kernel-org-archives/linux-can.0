From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Mon, 19 Oct 2015 23:31:57 +0200
Message-ID: <20151019213157.GA304@airbook.vandijck-laurijssen.be>
References: <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <562151D4.3060902@posteo.de>
 <20151018024250.GB29078@airbook.vandijck-laurijssen.be>
 <5624667E.3080809@posteo.de>
 <562488A3.2010204@hartkopp.net>
 <20151019095241.GB3406@airbook.eia.lan>
 <CAFUozzGXan5h5Q46crZoGJjMZyHjLOBz-KiRKyYRi1yHjq+wqA@mail.gmail.com>
 <20151019205749.GB16852@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:24987 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbJSVeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 17:34:13 -0400
Content-Disposition: inline
In-Reply-To: <20151019205749.GB16852@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>, Oliver Hartkopp <socketcan@hartkopp.net>, Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>

> > >>
> > >> I would definitely demand multi-role implementations as this is one of the
> > >> main SocketCAN goals to have the entire networking setup running on one host
> > >> or on different hosts without changing the application.
> > >
> > > I see 2 distinct requirements for multi-role implementations:
> > > a) 1 can-interface may have different addresses
> > > b) different applications/sockets may use the same address
> > 
> > I definitely have encountered needing requirement a), but as far as I
> > know b) is not so important. However, I could be mistaken on that.
> > 

We (in my company) typically have the hot-path in plain-C simple
programs, close to the kernel. These programs translate the parameters
like engine RPM etc. into floating point and distribute it across the
linux box. This can then be re-used by error-logging processes,
failure detection processes, and of course the GUI which is written
in ... systems like Qt with painfull interaction with non-ethernet
networks.
On the other hand, some low-bandwith communication is better dealt with
directly from the GUI. Things like remote error log visualing, or
some machine calibration routines.
While technically possible to allocate an address per function, it's not
feasible.

Kurt
