From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [INFO] BCM and ISOTP crashes Linux 3.11 - 3.13 when running on
 REAL HW CAN interfaces
Date: Sat, 01 Feb 2014 19:44:27 +0100
Message-ID: <52ED408B.5010806@pengutronix.de>
References: <20140130.162723.1124545320708055175.davem@davemloft.net> <52ED3993.2080404@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8xs781X7iipXsG0amhtsvMmb2fMi2Gl2L"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41199 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbaBASom (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Feb 2014 13:44:42 -0500
In-Reply-To: <52ED3993.2080404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Boris Baskevitch <boris.baskevitch@annecy-elec.fr>, Daniele Venzano <linux@brownhat.org>, Josselin Costanzi <josselin.costanzi@mobile-devices.fr>, Nathan Conrad <nconrad.mlock@gmail.com>, Dirk Rohleder <dirk@rohleder-bo.de>, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com, opensuse-kernel@opensuse.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8xs781X7iipXsG0amhtsvMmb2fMi2Gl2L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2014 07:14 PM, Oliver Hartkopp wrote:
> Hello all,
>=20
> at 2013-08-01 Eric Dumazet created this patch to make sure some
> networking rules are enforced in the Linux Kernel in Linux 3.11:
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=3D=
376c7311bdb6efea3322310333576a04d73fbe4c
>=20
> This affects CAN BCM and CAN ISOTP and leads to a KERNEL CRASH
> when you are *sending* with the BCM or ISOTP on REAL(!) CAN interfaces.=

>=20
> AFAIK there are not so many use cases. That's why it lasted 6 months to=
 detect it :-(
> Virtual CAN and SLCAN interfaces do not have this problem (no echo skbs=
).
>=20
> Do I have to care about this issue?
>=20
> Usually the embedded systems do not have such a recent kernel.
> Regarding desktop distributions Redhat 7 runs a 3.10 kernel which is sa=
fe.
>=20
> But e.g. OpenSuse 13.1 and Ubuntu 13.10 / Linux Mint Petra are based on=

> Linux 3.11 and Debian Jessie (current Debian testing) is on Linux 3.12.=

>=20
> The latter have the described problem with BCM / ISOTP until this patch=
=20
>=20
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=3D=
0ae89beb283a0db5980d1d4781c7d7be2f2810d6
>=20
> is applied by the stable kernel maintainers and distribution maintainer=
s.
> The patch is already upstream for Linux 3.14 but it will take some time=

> until it gets into the stable kernels 3.11 - 3.13 and the distributions=
=2E
>=20
> As Linux 3.11 is already end-of-life [EOL] I'll address the Ubuntu and
> OpenSuse maintainers directly so that this patch for 3.11 does not get =
lost.
> David Miller already queued this patch up for -stable
> Original post: http://marc.info/?l=3Dlinux-netdev&m=3D139107310226665&w=
=3D2

At least the Ubuntu maintainers usually pick up the stable patches, so
that they appear "automatically" in Ubuntu's stable. Good Work!

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8xs781X7iipXsG0amhtsvMmb2fMi2Gl2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLtQIsACgkQjTAFq1RaXHMoPACgjxezeO8CnSnDB57PbNxxKwXC
pCMAn3lIwnv/UeSr3aeew/Y8muyNqqAL
=ud8l
-----END PGP SIGNATURE-----

--8xs781X7iipXsG0amhtsvMmb2fMi2Gl2L--
