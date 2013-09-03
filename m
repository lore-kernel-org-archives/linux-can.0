From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] real-time transmission?
Date: Tue, 03 Sep 2013 16:56:37 +0200
Message-ID: <5225F8A5.4060207@pengutronix.de>
References: <11071630B606A2488DE633430B530FDE57F06BEE@ELS-EX01-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eCUjhcFlPdop7KpntUTQHI48JWS4MuIbc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42029 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab3ICO4q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Sep 2013 10:56:46 -0400
In-Reply-To: <11071630B606A2488DE633430B530FDE57F06BEE@ELS-EX01-PV.KSTG.corp>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eCUjhcFlPdop7KpntUTQHI48JWS4MuIbc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

please come to the linux-can mailinglist.

On 09/03/2013 04:31 PM, Aiken, Scott wrote:
> Hi all,
>=20
> =20
>=20
> I=E2=80=99m porting an old implementation of CAL/CiA to Linux.  The dev=
ice
> connection protocol has some pretty tight timing.  I=E2=80=99ve observe=
d that
> some CAN packets are buffered for 500 ms between the socket write() cal=
l
> and the actual transmission of the packet.  This is enough to sabotage
> the connection process, and possibly take out other devices as well.=20
> Are there any socket options to disable buffering of write packets, and=

> send them when write() is called?=20
>=20
> =20
>=20
> Thanks,
>=20
> Scott
>=20
> =20
>=20
>=20
>=20
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eCUjhcFlPdop7KpntUTQHI48JWS4MuIbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIl+KUACgkQjTAFq1RaXHMyQgCfYFMLFNiI6Q8Yuoo8yqQGy/Uu
wosAnAgY5sOx+DxVYo6HzKchpQ7EJQxE
=Ubyy
-----END PGP SIGNATURE-----

--eCUjhcFlPdop7KpntUTQHI48JWS4MuIbc--
