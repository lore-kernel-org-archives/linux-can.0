From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-j1939 API
Date: Mon, 02 Nov 2015 13:14:58 +0100
Message-ID: <563753C2.3030109@hartkopp.net>
References: <linux-can/can-utils/pull/7/c144149208@github.com> <560ADC91.1090408@pengutronix.de> <20150929194920.GA11430@airbook.vandijck-laurijssen.be> <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com> <20151018023225.GA29078@airbook.vandijck-laurijssen.be> <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com> <20151019204442.GA16852@airbook.vandijck-laurijssen.be> <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com> <20151023111430.GB22388@airbook.eia.lan> <56327492.9030405@hartkopp.net> <20151029233806.GA12740@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:46792 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbKBMPB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Nov 2015 07:15:01 -0500
In-Reply-To: <20151029233806.GA12740@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On 30.10.2015 00:38, Kurt Van Dijck wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>> To: Alex Layton <alex@layton.in>, Kurt Van Dijck

>>> Yep, I can follow that argument.
>>> When I get to it, I'll change that.
>>> It also implies I can drop iproute2-j1939 branches completely.
>>>
>>
>> Just to be sure I understood it correctly:
>>
>> No iproute2-j1939 branch -> no address support for j1939 in iproute
>> -> no address support in af_can.c ?? \o/
>
> indeed.
> Next to the address support, I also would then drop the link status
> support (i.e. ip link set can0 j1939 on/off).

ok

>> So you would automatically take care of SA/Name when a j1939 socket is created
>> with the according address information (== per-socket), right?
>
> All SA or Name info comes via that way, indeed.
> Any can-j1939 socket (regardless the user) could bind to a new SA or Name.

This is what I would expect :-)

As Alex is only using SA in his implementation: Is the name still mandatory as 
j1939 address information?

> 'per socket' is a bit dubious. In contrast to Alex, I would not restrict
> a specific SA or Name to a single socket for reasons I gave earlier.

If I understand you correctly the first socket which is giving his address 
information enables the j1939 address (claiming) handling inside the Kernel, 
right?

Btw. is it possible to create two processes on the same Linux box which 
implement two different j1939 nodes (e.g. engine and trailer) that can 
communicate with each other both using the *same* CAN interface (can0 or vcan0)??

Regards,
Oliver

