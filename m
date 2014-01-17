From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Fri, 17 Jan 2014 14:37:09 +0100
Message-ID: <20140117133709.GD25911@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
 <20140116192818.GC25911@pengutronix.de>
 <52D85910.8000200@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaAQNhL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 08:37:11 -0500
Content-Disposition: inline
In-Reply-To: <52D85910.8000200@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hallo Marc,

On Thu, Jan 16, 2014 at 11:11:28PM +0100, Marc Kleine-Budde wrote:
> On 01/16/2014 08:28 PM, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jan 16, 2014 at 05:12:34PM +0100, Marc Kleine-Budde wrote:
> >> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >>
> >> This makes it possible to update the copies more easily, e.g.:
> >>
> >> 	cd $path_to_linux_repo
> >> 	make headers_install
> >> 	rsync -a --delete --exclude .\* usr/include/linux/can* $path_to_c=
an_utils/include/linux
> >>
> >> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> > I want to have pointed out in the commit log that it was you who ad=
ded
> > isotp.h to the move. I don't care that much for your split into two
> > patches to fix the #includes first, but IMHO that should be documen=
ted,
> > too.
>=20
> Yes, but no. I imported the isotp header, but not from the kernel. It
> was imported from the berlios svn repo.
I didn't mean isotp when it was added to can-utils, but compared to my
patch "include: Move includes copied from the Linux kernel into
include/linux" you also moved isotp.h from socketcan/can to linux/can i=
n
can-utils. That's what I thought you should point out. That this change
makes the changelog wrong is another issue.

Where can this external kernel module be found? IMHO it would be worth
to point to its (hopefully) git repository in isotp{*.c,.h}.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
