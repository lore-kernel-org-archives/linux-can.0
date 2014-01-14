From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils v4 4/4] isotp.h: add explicit license
 information
Date: Tue, 14 Jan 2014 09:46:16 +0100
Message-ID: <20140114084616.GR29475@pengutronix.de>
References: <52D45B4C.3070009@hartkopp.net>
 <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389650236-13542-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <52D4E0CD.2040706@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbaANIqR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jan 2014 03:46:17 -0500
Content-Disposition: inline
In-Reply-To: <52D4E0CD.2040706@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hey Oliver,

On Tue, Jan 14, 2014 at 08:01:33AM +0100, Oliver Hartkopp wrote:
> On 13.01.2014 22:57, Uwe Kleine-K=F6nig wrote:
> > It seems this file was originally part of the Linux kernel as it wa=
s created
> > by commit 77de10356fe0 (include: import kernel header files into tr=
ee) but I
> > couldn't find it in the git history of the kernel.
>=20
> This comes from the original development process in the BerliOS SVN.
> The fact that these files are kernel header files does not necessaril=
y mean
> they have been imported from the kernel source tree :-)
Strange concept. Either you need some additional Userspace API in the
kernel for your isotp programs or you don't. In the first case there
must be a header in the kernel providing that API (if not in mainline
that at least in some can tree). In the latter case where everything
works with the kernel as is, you shouldn't declare something to be a
kernel header that doesn't need to.
=20
> > Anyhow the copyright
> > suggests to use the license used by the other files created by Volk=
swagen.
>=20
> Indeed.
>=20
> >=20
> > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > ---
> >  include/socketcan/can/isotp.h | 36 +++++++++++++++++++++++++++++++=
++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/=
isotp.h
>=20
> Is this the only file in include/socketcan now?
> I thought you wanted to get rid of this construct and move everything=
 over to
> the include/linux directory to finally remove include/socketecan ??
You said:
	Please let it stay in the current place.

So did I. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
