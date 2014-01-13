From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 19:25:20 +0100
Message-ID: <52D42F90.7080005@hartkopp.net>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de> <52D3867B.6090108@hartkopp.net> <20140113072049.GB29475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:36578 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaAMSZX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 13:25:23 -0500
In-Reply-To: <20140113072049.GB29475@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>



On 13.01.2014 08:20, Uwe Kleine-K=F6nig wrote:
> Hello Oliver,
>=20
> On Mon, Jan 13, 2014 at 07:23:55AM +0100, Oliver Hartkopp wrote:
>> On 12.01.2014 22:24, Uwe Kleine-K=F6nig wrote:
>>
>>>  - use __kernel_sa_family_t instead of sa_family_t which requires
>>>    <linux/socket.h from Linux 3.1 or later. Unfortunately this make=
s
>>>    can-utils FTBFS on e.g. Debian squeeze. If this is an issue this
>>>    could be fixed by adding something like:
>>
>> This was exactly the idea to have a separate set of include files to=
 make sure
>> the 'newest and greatest' tools can be build even on 2.6.24 environm=
ents where
>> there was no SocketCAN in mainline Linux.
> Hmm, the newest and greatest tools are unusable if your kernel doesn'=
t
> also include the newest and greatest SocketCAN stuff.

=46eatures that are not available in the kernel come back with an error=
=2E
But there's no reason not to have the latest can-utils with bug fixes a=
nd
functional enhancements for older kernels, right?

> And then it is
> easy to also have updated kernel headers, isn't it? Well, anyhow I ju=
st
> found a system here at pengutronix with old enough kernel headers, so=
 I
> will do a fix.

ok. tnx.

> =20
>> And e.g. this
>>
>>>  #include <linux/can.h>
>>> -#include <linux/can/isotp.h>
>>> +#include "isotp.h"
>>>  #include <linux/if_tun.h>
>>
>> should be avoided too.
> Why?

When isotp hits the kernel, there's no need to adapt all userland progr=
ams.

I don't think the current idea was that bad.
AFAIK the iproute2 package has a similar approach and contains always u=
pdated
kernel headers to be able to build even on older systems.


Best regards,
Oliver

