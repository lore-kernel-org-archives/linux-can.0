From: Yang <wang701@purdue.edu>
Subject: Re: Re: can-j1939 API
Date: Tue, 10 Nov 2015 16:58:07 -0500
Message-ID: <5642686F.5020708@purdue.edu>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <20151018023225.GA29078@airbook.vandijck-laurijssen.be>
 <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
 <20151019204442.GA16852@airbook.vandijck-laurijssen.be>
 <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
 <20151023111430.GB22388@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhub131.itcs.purdue.edu ([128.210.5.131]:51490 "EHLO
	mailhub131.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125AbbKJWFB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Nov 2015 17:05:01 -0500
In-Reply-To: <20151023111430.GB22388@airbook.eia.lan>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>

On 10/23/2015 07:14 AM, Kurt Van Dijck wrote:

> I'll do the necessary modifications.
> This has become a rather low-priority task nowadays, although I think
> there is a momentum to make progress now.

I am working with Alex, the author of 
https://github.com/ISOBlue/isoblue-software on a project that uses 
j1939. With Alex's module, we wrote another program to receive messages 
and get the PGN out of each message.

After looking through this thread, it seems like your module could do 
the same thing and it looks promising that your module will be added 
into the main linux kernel. You mentioned that there are things you need 
to fix and change. I'm currently looking into writing a JNI wrapper for 
the j1939 module you have. My question is: as you make modifications to 
the API, how much will change? I can't/don't want to write the JNI 
wrapper if the code will keep changing significantly.
