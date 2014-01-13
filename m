From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 22:31:56 +0100
Message-ID: <52D45B4C.3070009@hartkopp.net>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de> <52D3867B.6090108@hartkopp.net> <20140113072049.GB29475@pengutronix.de> <52D42F90.7080005@hartkopp.net> <20140113204531.GI29475@pengutronix.de> <52D4580C.5030602@hartkopp.net> <20140113212658.GL29475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:31390 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaAMVcD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:32:03 -0500
In-Reply-To: <20140113212658.GL29475@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>



On 13.01.2014 22:26, Uwe Kleine-K=C3=B6nig wrote:
> Hello Oliver,
>=20
> On Mon, Jan 13, 2014 at 10:18:04PM +0100, Oliver Hartkopp wrote:
>> On 13.01.2014 21:45, Uwe Kleine-K=C3=B6nig wrote:
>>> On Mon, Jan 13, 2014 at 07:25:20PM +0100, Oliver Hartkopp wrote:
>>>> On 13.01.2014 08:20, Uwe Kleine-K=C3=B6nig wrote:
>>>>> On Mon, Jan 13, 2014 at 07:23:55AM +0100, Oliver Hartkopp wrote:
>>>>>> And e.g. this
>>>>>>
>>>>>>>  #include <linux/can.h>
>>>>>>> -#include <linux/can/isotp.h>
>>>>>>> +#include "isotp.h"
>>>>>>>  #include <linux/if_tun.h>
>>>>>>
>>>>>> should be avoided too.
>>>>> Why?
>>>>
>>>> When isotp hits the kernel, there's no need to adapt all userland =
programs.
> To be honest, it's not that hard to update all userland programs. I d=
id
> it with:
>=20
> 	perl -p -i -e 's,^#include <whatever/can/isotp.h>$,#include "isotp.h=
",' isotp*
>=20
> (well, plus some reformatting, but meh).
>=20
>>> ah, didn't know that isotp targets the kernel. There is nothing in =
next
>>> yet. I wonder if it's sensible to put it into can-utils' copy of th=
e
>>> kernel headers then. If you ask me keep isotp.h in / until it hits =
the
>>> kernel, then sync the headers and switch the programs explicitly. O=
nly
>>> my 0.02 =E2=82=AC.
>>
>> What's the benefit of moving it to root and then moving it back to t=
he includes?
> The benefit is that there is less chance for surprises. Updating the
> kernel header copy still has a manual component when there are files =
in
> can-utils that are not existing in the kernel. Also I like changes to=
 be
> explicit. When isotp.h is now kept in can-utils/include/linux and lat=
er
> hits the kernel there is no explicit commit that marks the start of
> using the kernel header and changing the procedure how to sync kernel
> headers. YMMV
>=20
>> Please let it stay in the current place.
> To late for v3, only read your mail when I sent it out.
>=20

Sorry that I did not was faster.

But it's never too late for my NACK for the "[PATCH can-utils v3 2/5] M=
ove
isotp.h into the project root" :-)

To all the other stuff you may add my Acked-by: in the next attempt.

Btw. did you test the stuff on the 'old' system as you mentioned?

Regards,
Oliver
