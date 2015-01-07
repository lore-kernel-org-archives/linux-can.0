From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH stable] can_dev: fix crtlmode_supported check
Date: Wed, 07 Jan 2015 14:01:49 +0100
Message-ID: <54AD2E3D.2080908@pengutronix.de>
References: <54AACC7F.5070605@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Pol2GSEwScPjV5jigNIATiLBrNpCKX2Ks"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34112 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbAGNCF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 08:02:05 -0500
In-Reply-To: <54AACC7F.5070605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pol2GSEwScPjV5jigNIATiLBrNpCKX2Ks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2015 06:40 PM, Oliver Hartkopp wrote:
> When changing flags in the CAN drivers ctrlmode the provided new conten=
t
> has to be checked whether the bits are allowed to be changed.
> The bits that are to be changed are given as a bitfield in cm->mask.
> Therefore checking against cm->flags is wrong as the content can hold
> any kind of values.
>=20
> The iproute2 tool sets the bits in cm->mask and cm->flags depending on
> the detected command line options. To be robust against bogus user spac=
e
> applications additionally sanitize the provided flags with the provided=

> mask.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> CC: Wolfgang Grandegger <wg@grandegger.com>

Does not apply to net/master. However I've applied it by hand. v2 will
follow.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Pol2GSEwScPjV5jigNIATiLBrNpCKX2Ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrS49AAoJECte4hHFiupUwLcP/3h/5fA56szm9SUMeKT6mw+Q
VPlA8/NiaHbp/xQqLDrVHlhuFrSVrOk3tozTl+7ixXvZDqfxsdMisLNlPGkYdBcD
Y6zp8BIagRQNaxGOhoBXK6tyK/DsYL7x2Myu/aXj7hoxVpF0rqajrZkkkJQulfJg
lyuWSgoPc3BTATZX8/Al/OZcVcqu+K1psYRUF3HPi8a515jSU6tDikHWdpQKzW8X
MJAMLy5Hd8bKi7rB0n7tTVUoO9PvAf84VLo3bjjeZ6Aa1GqRq3PQF4O8BVEU/hXe
PNQ6G6KBiYhqI+BBMtKNP9P3g1JIIo8MWTXv6owOrr/KjWTYJPHCzCE4HcLd+a10
B7qmGk2BQe9npWIzOIMHzk58mLteJQ0y/+UmmJfPx7hUnydFqLHqJ5m1R7+kAhVO
DTvTUxeU5UILhw0vejdAvaZ7obGgXQENrVS86ncUmwjSsGQIRqLE4pilvFaq7u9p
D1rmkTNEUXyizqK48ss0rIIl3AgPOiFWRS2fQHpbbyLX8SvVk5xH2+urRKzfHz+9
lNOx9nRhYZaeRZdWxxZOn5pwdIKXjsdPZjYHcd9G5xNjMBRD/o3xeoFElsWw3i3N
umU96724oRtgjAgvlTUa3ykmKv9NHISLMZQtPi0c7tC43QbUDZavoXJuBDAI53ou
qy/bCBIQONk6XGt7jXAI
=i1U5
-----END PGP SIGNATURE-----

--Pol2GSEwScPjV5jigNIATiLBrNpCKX2Ks--
