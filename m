From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Re: can-j1939 API
Date: Tue, 17 Nov 2015 09:43:20 +0100
Message-ID: <20151117084320.GA4665@airbook.eia.lan>
References: <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
 <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
 <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
 <20151023111430.GB22388@airbook.eia.lan>
 <5642686F.5020708@purdue.edu>
 <20151111184947.GA6182@airbook.vandijck-laurijssen.be>
 <CAEE8DsJvGNk6pbnKBPJTHJhjcgTihuHtPem254U_9oWP3NjfHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:51809 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbKQIpT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Nov 2015 03:45:19 -0500
Content-Disposition: inline
In-Reply-To: <CAEE8DsJvGNk6pbnKBPJTHJhjcgTihuHtPem254U_9oWP3NjfHQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yang Wang <wang701@purdue.edu>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date:	Tue, 17 Nov 2015 01:01:10 -0500
> From: Yang Wang <wang701@purdue.edu>
> To: dev.kurt@vandijck-laurijssen.be
> Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>
> Subject: Re: Re: can-j1939 API
> 
> On Wed, Nov 11, 2015 at 1:49 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> >
> > The fixes I need to do don't affect the API.
> > The upcoming changes to can-j1939 do not yet affect the socket API,
> > they rather affect how iproute2 is needed (I plan to drop the need for it).
> >
> > I'm not so familiar with JNI etc. I assume that the whole iproute2 thing
> > would stay out of it alltogether?
> >
> > Kind regards,
> > Kurt
> 
> Yes. I am inclined to use the stock iproute2 if possible.
> 
> I did compile your newest branch (j1939-v3.15x) on kernel source tree.
> After booting into the kernel, it seems like the j1939 switch will not
> work on a CAN interface unless your version of iproute2 is installed.

yes, that's true.

> 
> I will begin writing the JNI wrapper for j1939 but how soon do you
> plan on dropping the need on iproute2?

Well, I'm 25% now. I plan to finish, let's say, a couple of weeks.

> 
> Regards,
> Yang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
