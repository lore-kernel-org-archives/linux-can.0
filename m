From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Re: can-j1939 API
Date: Wed, 11 Nov 2015 19:49:47 +0100
Message-ID: <20151111184947.GA6182@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
 <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
 <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
 <20151023111430.GB22388@airbook.eia.lan>
 <5642686F.5020708@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:27484 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbbKKSut (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2015 13:50:49 -0500
Content-Disposition: inline
In-Reply-To: <5642686F.5020708@purdue.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yang <wang701@purdue.edu>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date:	Tue, 10 Nov 2015 16:58:07 -0500
> From: Yang <wang701@purdue.edu>
> To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>
> Subject: Re: Re: can-j1939 API
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
>  Thunderbird/38.3.0
> 
> On 10/23/2015 07:14 AM, Kurt Van Dijck wrote:
> 
> >I'll do the necessary modifications.
> >This has become a rather low-priority task nowadays, although I think
> >there is a momentum to make progress now.
> 
> I am working with Alex, the author of
> https://github.com/ISOBlue/isoblue-software on a project that uses j1939.
> With Alex's module, we wrote another program to receive messages and get the
> PGN out of each message.
> 
> After looking through this thread, it seems like your module could do the
> same thing and it looks promising that your module will be added into the
> main linux kernel. You mentioned that there are things you need to fix and
> change. I'm currently looking into writing a JNI wrapper for the j1939
> module you have. My question is: as you make modifications to the API, how
> much will change? I can't/don't want to write the JNI wrapper if the code
> will keep changing significantly.

The fixes I need to do don't affect the API.
The upcoming changes to can-j1939 do not yet affect the socket API,
they rather affect how iproute2 is needed (I plan to drop the need for it).

I'm not so familiar with JNI etc. I assume that the whole iproute2 thing
would stay out of it alltogether?

Kind regards,
Kurt
