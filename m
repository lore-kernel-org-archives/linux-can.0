From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 22:18:04 +0100
Message-ID: <52D4580C.5030602@hartkopp.net>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de> <52D3867B.6090108@hartkopp.net> <20140113072049.GB29475@pengutronix.de> <52D42F90.7080005@hartkopp.net> <20140113204531.GI29475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:11118 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaAMVSH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:18:07 -0500
In-Reply-To: <20140113204531.GI29475@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>



On 13.01.2014 21:45, Uwe Kleine-K=C3=B6nig wrote:
> Hello Oliver,
>=20
> On Mon, Jan 13, 2014 at 07:25:20PM +0100, Oliver Hartkopp wrote:
>> On 13.01.2014 08:20, Uwe Kleine-K=C3=B6nig wrote:
>>> Hello Oliver,
>>>
>>> On Mon, Jan 13, 2014 at 07:23:55AM +0100, Oliver Hartkopp wrote:
>>>> On 12.01.2014 22:24, Uwe Kleine-K=C3=B6nig wrote:
>>>>
>>>>>  - use __kernel_sa_family_t instead of sa_family_t which requires
>>>>>    <linux/socket.h from Linux 3.1 or later. Unfortunately this ma=
kes
>>>>>    can-utils FTBFS on e.g. Debian squeeze. If this is an issue th=
is
>>>>>    could be fixed by adding something like:
>>>>
>>>> This was exactly the idea to have a separate set of include files =
to make sure
>>>> the 'newest and greatest' tools can be build even on 2.6.24 enviro=
nments where
>>>> there was no SocketCAN in mainline Linux.
>>> Hmm, the newest and greatest tools are unusable if your kernel does=
n't
>>> also include the newest and greatest SocketCAN stuff.
>>
>> Features that are not available in the kernel come back with an erro=
r.
>> But there's no reason not to have the latest can-utils with bug fixe=
s and
>> functional enhancements for older kernels, right?
>>
>>> And then it is
>>> easy to also have updated kernel headers, isn't it? Well, anyhow I =
just
>>> found a system here at pengutronix with old enough kernel headers, =
so I
>>> will do a fix.
>>
>> ok. tnx.
>>
>>> =20
>>>> And e.g. this
>>>>
>>>>>  #include <linux/can.h>
>>>>> -#include <linux/can/isotp.h>
>>>>> +#include "isotp.h"
>>>>>  #include <linux/if_tun.h>
>>>>
>>>> should be avoided too.
>>> Why?
>>
>> When isotp hits the kernel, there's no need to adapt all userland pr=
ograms.
> ah, didn't know that isotp targets the kernel. There is nothing in ne=
xt
> yet. I wonder if it's sensible to put it into can-utils' copy of the
> kernel headers then. If you ask me keep isotp.h in / until it hits th=
e
> kernel, then sync the headers and switch the programs explicitly. Onl=
y
> my 0.02 =E2=82=AC.

What's the benefit of moving it to root and then moving it back to the =
includes?

Please let it stay in the current place.

Tnx,
Oliver

