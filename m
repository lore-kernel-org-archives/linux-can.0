From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 19:09:23 +0200
Message-ID: <523DD2C3.7000505@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DA147.7090403@pengutronix.de> <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xLfO2HmrkiAPiiXa3t6W6p0EqaG9LBuCM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3IURJd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 13:09:33 -0400
In-Reply-To: <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xLfO2HmrkiAPiiXa3t6W6p0EqaG9LBuCM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2013 06:37 PM, Sebastian Haas wrote:
> As Oliver already pointed out there are a bunch of applications outside=

> which may require a can4linux-like chardev API.
>=20
> But I also agree that merging an additional CAN framework makes not
> much sense. I prefer to port can4linux drivers to SocketCAN for not
> yet supported devices. But we may also think about an emulation of
> chardev based APIs like can4linux to support legacy applications.

The emulation could probably be done in userspace. I'll ask our
userspace graphics guys how they emulate legacy /dev/fbX on top of drm.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xLfO2HmrkiAPiiXa3t6W6p0EqaG9LBuCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlI90sMACgkQjTAFq1RaXHPnKwCePKJecRJBwlvKxXp6f1BJ5/fH
co8An01TVC0/laLxffPcvtVJezxviU2Q
=OO9C
-----END PGP SIGNATURE-----

--xLfO2HmrkiAPiiXa3t6W6p0EqaG9LBuCM--
