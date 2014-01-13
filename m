From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 08:20:49 +0100
Message-ID: <20140113072049.GB29475@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <52D3867B.6090108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43226 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbaAMHUw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 02:20:52 -0500
Content-Disposition: inline
In-Reply-To: <52D3867B.6090108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

Hello Oliver,

On Mon, Jan 13, 2014 at 07:23:55AM +0100, Oliver Hartkopp wrote:
> On 12.01.2014 22:24, Uwe Kleine-K=F6nig wrote:
>=20
> >  - use __kernel_sa_family_t instead of sa_family_t which requires
> >    <linux/socket.h from Linux 3.1 or later. Unfortunately this make=
s
> >    can-utils FTBFS on e.g. Debian squeeze. If this is an issue this
> >    could be fixed by adding something like:
>=20
> This was exactly the idea to have a separate set of include files to =
make sure
> the 'newest and greatest' tools can be build even on 2.6.24 environme=
nts where
> there was no SocketCAN in mainline Linux.
Hmm, the newest and greatest tools are unusable if your kernel doesn't
also include the newest and greatest SocketCAN stuff. And then it is
easy to also have updated kernel headers, isn't it? Well, anyhow I just
found a system here at pengutronix with old enough kernel headers, so I
will do a fix.
=20
> And e.g. this
>=20
> >  #include <linux/can.h>
> > -#include <linux/can/isotp.h>
> > +#include "isotp.h"
> >  #include <linux/if_tun.h>
>=20
> should be avoided too.
Why?

> Please only fix the copyright information in this patch.
OK, will split the patch accordingly.
=20
> The wrong 3.1 -> 3.2 comparison should be fixed in a separate patch t=
oo.
>=20
> But reorder the includes in a way you suggest needs at least some mor=
e
> discussion (see requirements above).
I'm not aware what needs discussion here (apart from the "build with ol=
d
kernel headers" requirement maybe). I will prepare a new series and the=
n
we can discuss.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
