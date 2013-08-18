From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when
 provided via the environment
Date: Sun, 18 Aug 2013 22:49:30 +0200
Message-ID: <20130818204930.GM30496@pengutronix.de>
References: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <520FCFDD.7010308@pengutronix.de>
 <5210A9C5.5070309@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48437 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab3HRUtb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Aug 2013 16:49:31 -0400
Content-Disposition: inline
In-Reply-To: <5210A9C5.5070309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Sun, Aug 18, 2013 at 01:02:29PM +0200, Oliver Hartkopp wrote:
> On 17.08.2013 21:32, Marc Kleine-Budde wrote:
> > On 08/17/2013 09:28 PM, Uwe Kleine-K=F6nig wrote:
> >> For creating a Debian package providing PREFIX and DESTDIR via the
> >> environment is the easiest option. So use ?=3D to assign these two
> >> variables to honor the values in the environment.
> >=20
> > I suggest to use autotools.
> >=20
> > ./configure && make && make install
> >=20
>=20
> Today i like the possibility to use autotools or just to say 'make &&=
 make
> install' without autotools.
>=20
> You may choose for the Debian package the build process which is more=
 appropriate.
>=20
> >
> > -DESTDIR =3D
> > -PREFIX =3D /usr/local
> > +DESTDIR ?=3D
> > +PREFIX ?=3D /usr/local
> >
>=20
> 1. good idea - I already pushed it to the git tree
Thanks, but you somehow messed up the attribution. All three patches I
sent in the last few days appear with author=3Dyou :-(

> 2. I wonder if we should doublecheck the target directories when maki=
ng it a
> real Debian package
>=20
> e.g. the majority of tools should go into /usr/bin then
>=20
> But some tools that require root rights should go to /usr/sbin like c=
angw,
> isotptun, slcan_attach, slcand
I don't feel qualified to judge that. The File Heirarchy Standard says
(http://www.pathname.com/fhs/pub/fhs-2.3.html#PURPOSE16):

	Utilities used for system administration (and other root-only
	commands) are stored in /sbin, /usr/sbin, and /usr/local/sbin.
	/sbin contains binaries essential for booting, restoring,
	recovering, and/or repairing the system in addition to the
	binaries in /bin.


> Or should they stay in /usr/bin and lead to an error when the admin r=
ights are
> not granted??
Even if they are in /usr/sbin they should lead to an error in that case=
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
