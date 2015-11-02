From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-j1939 API
Date: Mon, 02 Nov 2015 14:18:25 +0100
Message-ID: <563762A1.7020601@hartkopp.net>
References: <20150929194920.GA11430@airbook.vandijck-laurijssen.be> <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com> <20151018023225.GA29078@airbook.vandijck-laurijssen.be> <CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com> <20151019204442.GA16852@airbook.vandijck-laurijssen.be> <CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com> <20151023111430.GB22388@airbook.eia.lan> <56327492.9030405@hartkopp.net> <20151029233806.GA12740@airbook.vandijck-laurijssen.be> <563753C2.3030109@hartkopp.net> <20151102122913.GA25072@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:24079 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbKBNSc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Nov 2015 08:18:32 -0500
In-Reply-To: <20151102122913.GA25072@airbook.eia.lan>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>

On 02.11.2015 13:29, Kurt Van Dijck wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>> To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>,

>>> 'per socket' is a bit dubious. In contrast to Alex, I would not restrict
>>> a specific SA or Name to a single socket for reasons I gave earlier.
>>
>> If I understand you correctly the first socket which is giving his address
>> information enables the j1939 address (claiming) handling inside the Kernel,
>> right?
>
> That's the plan.
> I would keep the address claiming itself as today in userspace.

Oh - but what is net/can/j1939/address-claim.c then?
Did it become obsolete?

>> Btw. is it possible to create two processes on the same Linux box which
>> implement two different j1939 nodes (e.g. engine and trailer) that can
>> communicate with each other both using the *same* CAN interface (can0 or
>> vcan0)??
>
> Yes.
> This kind of transparency was one of my goals.

Great.

Regards,
Oliver
