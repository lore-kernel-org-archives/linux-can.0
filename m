From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 API
Date: Wed, 11 Nov 2015 20:48:01 +0100
Message-ID: <20151111194801.GA23275@airbook.vandijck-laurijssen.be>
References: <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
 <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
 <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
 <20151023111430.GB22388@airbook.eia.lan>
 <56327492.9030405@hartkopp.net>
 <20151029233806.GA12740@airbook.vandijck-laurijssen.be>
 <563753C2.3030109@hartkopp.net>
 <20151102122913.GA25072@airbook.eia.lan>
 <563762A1.7020601@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:45849 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbKKTsx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2015 14:48:53 -0500
Content-Disposition: inline
In-Reply-To: <563762A1.7020601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>

Oliver,

I must have lost this email ...

--- Original message ---
> Date:	Mon, 02 Nov 2015 14:18:25 +0100
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>
> Subject: Re: can-j1939 API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
>  Icedove/31.8.0
> 
> On 02.11.2015 13:29, Kurt Van Dijck wrote:
> >>From: Oliver Hartkopp <socketcan@hartkopp.net>
> >>To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>,
> 
> >>>'per socket' is a bit dubious. In contrast to Alex, I would not restrict
> >>>a specific SA or Name to a single socket for reasons I gave earlier.
> >>
> >>If I understand you correctly the first socket which is giving his address
> >>information enables the j1939 address (claiming) handling inside the Kernel,
> >>right?
> >
> >That's the plan.
> >I would keep the address claiming itself as today in userspace.
> 
> Oh - but what is net/can/j1939/address-claim.c then?
> Did it become obsolete?

No, can-j1939 tracks address claims in kernel, or in development terms,
it receives address claims on the bus so the kernel can build a
address<->name table for later use.

The 'active' part of address claiming, or sending address claims, is
for userspace.

> 
> >>Btw. is it possible to create two processes on the same Linux box which
> >>implement two different j1939 nodes (e.g. engine and trailer) that can
> >>communicate with each other both using the *same* CAN interface (can0 or
> >>vcan0)??
> >
> >Yes.
> >This kind of transparency was one of my goals.
> 
> Great.
> 
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
