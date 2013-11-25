From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Using TC from iproute, unable to match canid
Date: Mon, 25 Nov 2013 17:59:12 +0100
Message-ID: <529381E0.4080007@pengutronix.de>
References: <42EF5F2B19AAE545B9E5BC916D3343F770D19F1E@GRBSR0004.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fLenIN0SFxx5BuCDp5DKEgd57gmUbmJ17"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53744 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab3KYQ7T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 11:59:19 -0500
In-Reply-To: <42EF5F2B19AAE545B9E5BC916D3343F770D19F1E@GRBSR0004.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Karsten Aalykke Stenzhorn <Karsten.Stenzhorn@marel.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fLenIN0SFxx5BuCDp5DKEgd57gmUbmJ17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2013 05:49 PM, Karsten Aalykke Stenzhorn wrote:
> I'm trying to use tc from iproute2 to prioritize packets sent to a canb=
us.
>=20
> Before doing so I read this guide about the issue: http://rtime.felk.cv=
ut.cz/can/socketcan-qdisc-final.pdf
> Even using the exact examples from that pdf, I'm not able get any of th=
e filters to get a match. My current version of kernel and tc only allows=
 me to use the u32 match option.
>=20
> Tried (both big and little endian):
>=20
> tc filter add dev can0 parent 1:0 prio 1 u32 match u32 0x01000000 0xfff=
fffff at 0 flowid 1:1
>=20
> and also:
>=20
> tc filter add dev can0 parent 1:0 prio 1 u32 match u8 0x01 0xff at 4 fl=
owid 1:1
>=20
> Sending packets to fit those filters does not trigger a match. I'm a bi=
t confused why exact examples from the guide does not seem to work.
>=20
> Any hints or experience on this would be much appreciated.

Which kernel and iproute2 version are you using?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fLenIN0SFxx5BuCDp5DKEgd57gmUbmJ17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKTgeEACgkQjTAFq1RaXHMtXQCeJkLdjsovQK7zNHvZ/vj1hDOe
eTkAn24J12MY55m4pxxxes0v3ZeyU3OS
=ymnV
-----END PGP SIGNATURE-----

--fLenIN0SFxx5BuCDp5DKEgd57gmUbmJ17--
