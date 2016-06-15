From: Marek Vasut <marex@denx.de>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Wed, 15 Jun 2016 05:42:58 +0200
Message-ID: <5760CEC2.2050701@denx.de>
References: <573E491E.1000906@denx.de> <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com> <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de> <574E47C8.4000709@denx.de> <575415F5.3070306@hartkopp.net> <57598472.3070207@denx.de> <5759B597.3060009@hartkopp.net> <5759C1D1.1000001@denx.de> <5759CDC9.2010204@hartkopp.net> <575C699A.8080000@denx.de> <575DB7F4.3030906@hartkopp.net> <575F2E9E.3040307@denx.de> <575F9FBD.2030809@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44492 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcFODnH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2016 23:43:07 -0400
In-Reply-To: <575F9FBD.2030809@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 06/14/2016 08:10 AM, Oliver Hartkopp wrote:
> 
>>> On 06/11/2016 09:42 PM, Marek Vasut wrote:
>>>> Well, I was talking about arinc 429 .
>>>>
>>>
>>> Ah - I remember that discussion:
>>> https://lwn.net/Articles/663130/
>>> http://thread.gmane.org/gmane.linux.network/385449
>>>
>>> What happed to it?
>>
>> Priorities shifted. I still hope to return to it and get it into
>> mainline proper. Since I did some digging in the socketcan recently,
>> I have a better understanding of it now too. I believe the agreement
>> there was to put it into the socketcan stack as an extension, does it
>> still make sense ?
>>
> 
> There were intensive discussions about the original patchset and I think
> the copy&paste hell from the PF_CAN won't make it.

Yeah, that's pretty clear to me. But does it make sense to extend
socketcan with that arinc429 stuff instead then ?

> Let's see how the K-Line discussion opens your view :-)

Well it certainly was enlightening.

> (..)
> 
>>> E.g. think about a chardev in /dev/kline0 which is located in
>>> linux/drivers/misc and which uses a tty under the hood.
>>>
>>> I'm not a K-Line specialist like Mirza who was able to point at timings
>>> that should be handled in user space and not in kernel space.
>>
>> If I start handling the timings in userspace, I won't be able to get to
>> the precision I need. That's the reason I'd like to put the kline ldisc
>> in kernel.
>>
>>> But if you implement a chardev driver which allows the configuration of
>>> these kernel relevant K-Line timings and makes use of the tty layer -
>>> what should be wrong with this approach?
>>>
>>> You would have a single user K-Line interface which can handle specific
>>> struct kline data. Fine.
>>
>> Hrm. I was just worried about adding new IOCTLs, but if that's fine, I
>> will reevaluate using just the ldisc.
>>
> 
> Putting the really necessary timing requirements into the kernel into
> the ldisc need some configuration of that ldisc. AFAIK ldisc specific
> ioctls are the way to configure that kind of details.
> 
> So let's see what happens when you post it.

Right.

>>>>> As K-Line never was multi-user capable by design the chardev
>>>>> approach is
>>>>> the most 'natural' concept IMHO.
>>>>
>>>> I could technically just implement this as a ldisc with some additional
>>>> ioctls, but is that really such a good idea ?
>>>
>>> Yes. It would be some kind of ldisc for a K-Line chardev driver (and not
>>> for a netdevice) like other ldiscs in linux/include/uapi/linux/tty.h
>>>
>>> Why do you feel this is not a good idea?
>>
>> It feels much better now, so I will poke into that.
> 
> Thanks!

Thanks!


-- 
Best regards,
Marek Vasut
