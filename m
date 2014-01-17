From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Fri, 17 Jan 2014 21:36:05 +0100
Message-ID: <20140117203605.GF25911@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
 <20140116192818.GC25911@pengutronix.de>
 <52D85910.8000200@pengutronix.de>
 <20140117133709.GD25911@pengutronix.de>
 <52D93885.5040109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56904 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbaAQUgH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 15:36:07 -0500
Content-Disposition: inline
In-Reply-To: <52D93885.5040109@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Fri, Jan 17, 2014 at 03:04:53PM +0100, Marc Kleine-Budde wrote:
> On 01/17/2014 02:37 PM, Uwe Kleine-K=F6nig wrote:
> > Hallo Marc,
> >=20
> > On Thu, Jan 16, 2014 at 11:11:28PM +0100, Marc Kleine-Budde wrote:
> >> On 01/16/2014 08:28 PM, Uwe Kleine-K=F6nig wrote:
> >>> On Thu, Jan 16, 2014 at 05:12:34PM +0100, Marc Kleine-Budde wrote=
:
> >>>> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >>>>
> >>>> This makes it possible to update the copies more easily, e.g.:
> >>>>
> >>>> 	cd $path_to_linux_repo
> >>>> 	make headers_install
> >>>> 	rsync -a --delete --exclude .\* usr/include/linux/can* $path_to=
_can_utils/include/linux
> >>>>
> >>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >>
> >>> I want to have pointed out in the commit log that it was you who =
added
> >>> isotp.h to the move. I don't care that much for your split into t=
wo
> >>> patches to fix the #includes first, but IMHO that should be docum=
ented,
> >>> too.
> >>
> >> Yes, but no. I imported the isotp header, but not from the kernel.=
 It
> >> was imported from the berlios svn repo.
>=20
> > I didn't mean isotp when it was added to can-utils, but compared to=
 my
> > patch "include: Move includes copied from the Linux kernel into
> > include/linux" you also moved isotp.h from socketcan/can to linux/c=
an in
> > can-utils. That's what I thought you should point out. That this ch=
ange
> > makes the changelog wrong is another issue.
>=20
> Then I'll change the commit message to "move all headers from
> socketcan/can to linux/can".
and please also add something like:

	[mkl: also move isotp.h although Uwe skipped it as it is not
	part of the upstream kernel; adapt commit log accordingly]

> > Where can this external kernel module be found? IMHO it would be wo=
rth
> > to point to its (hopefully) git repository in isotp{*.c,.h}.
>=20
> https://gitorious.org/linux-can/can-modules
Is it a possibility to merge can-modules and can-utils? Then there woul=
d
only a single instance of isotp.h be needed. IIUC the source of isotp.h
is in can-modules. If so, adding a license to it should be done in
can-modules, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
