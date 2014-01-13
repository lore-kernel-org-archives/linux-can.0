From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 21:45:31 +0100
Message-ID: <20140113204531.GI29475@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <52D3867B.6090108@hartkopp.net>
 <20140113072049.GB29475@pengutronix.de>
 <52D42F90.7080005@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46048 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaAMUpd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 15:45:33 -0500
Content-Disposition: inline
In-Reply-To: <52D42F90.7080005@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

Hello Oliver,

On Mon, Jan 13, 2014 at 07:25:20PM +0100, Oliver Hartkopp wrote:
> On 13.01.2014 08:20, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Oliver,
> >=20
> > On Mon, Jan 13, 2014 at 07:23:55AM +0100, Oliver Hartkopp wrote:
> >> On 12.01.2014 22:24, Uwe Kleine-K=C3=B6nig wrote:
> >>
> >>>  - use __kernel_sa_family_t instead of sa_family_t which requires
> >>>    <linux/socket.h from Linux 3.1 or later. Unfortunately this ma=
kes
> >>>    can-utils FTBFS on e.g. Debian squeeze. If this is an issue th=
is
> >>>    could be fixed by adding something like:
> >>
> >> This was exactly the idea to have a separate set of include files =
to make sure
> >> the 'newest and greatest' tools can be build even on 2.6.24 enviro=
nments where
> >> there was no SocketCAN in mainline Linux.
> > Hmm, the newest and greatest tools are unusable if your kernel does=
n't
> > also include the newest and greatest SocketCAN stuff.
>=20
> Features that are not available in the kernel come back with an error=
=2E
> But there's no reason not to have the latest can-utils with bug fixes=
 and
> functional enhancements for older kernels, right?
>=20
> > And then it is
> > easy to also have updated kernel headers, isn't it? Well, anyhow I =
just
> > found a system here at pengutronix with old enough kernel headers, =
so I
> > will do a fix.
>=20
> ok. tnx.
>=20
> > =20
> >> And e.g. this
> >>
> >>>  #include <linux/can.h>
> >>> -#include <linux/can/isotp.h>
> >>> +#include "isotp.h"
> >>>  #include <linux/if_tun.h>
> >>
> >> should be avoided too.
> > Why?
>=20
> When isotp hits the kernel, there's no need to adapt all userland pro=
grams.
ah, didn't know that isotp targets the kernel. There is nothing in next
yet. I wonder if it's sensible to put it into can-utils' copy of the
kernel headers then. If you ask me keep isotp.h in / until it hits the
kernel, then sync the headers and switch the programs explicitly. Only
my 0.02 =E2=82=AC.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
