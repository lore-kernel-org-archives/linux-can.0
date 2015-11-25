From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 25 Nov 2015 17:10:29 +0100
Message-ID: <5655DD75.6060300@pengutronix.de>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
 <5655DC22.4000302@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Gg6vG8tlNpxPV0GcvJlGfoffG6RQC6Fpl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46884 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbKYQKi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 11:10:38 -0500
In-Reply-To: <5655DC22.4000302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gg6vG8tlNpxPV0GcvJlGfoffG6RQC6Fpl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2015 05:04 PM, Oliver Hartkopp wrote:
> Using libsocketcan is the way to control the interfaces by an applicati=
on
> (which internally uses netlink).
>=20
> The usual way to configure the interfaces system wide is the 'ip' tool =
from
> the iproute2 package which comes with your preferred Linux distribution=
=2E
>=20
> The way to configure CAN interfaces with 'ip' is described here:
>=20
> https://www.kernel.org/doc/Documentation/networking/can.txt (see chapte=
r 6.5)
>=20
> E.g. you can use this script in Debian/Ubuntu setups then:
>=20
> https://github.com/linux-can/can-misc/blob/master/etc/can_if

'seems we need systemd-networkd support for CAN.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Gg6vG8tlNpxPV0GcvJlGfoffG6RQC6Fpl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWVd11AAoJEP5prqPJtc/HOTEH/RsPVkfygIcYdsFURPgSSws7
YRtS33etAXasYKdEWQSKHyAuY05voTOGYtoOOThRIYW3H83ZzaIYPgQ9ttEjzkh/
A8dMUK+Bu/V3svi+Mnd5ET+fhMpNvWu+z4+UKb8gaiTfVs+261jlx/UoOPKJ93/s
5/yoByhiVzSHgYGhBdeYp7Rft3GZTagkz57ACNRikHuTfg2pCw/snndvuoz+PZES
2ajnqrUn84oWovGYOpLXYBvJJQq5bMRaw1Q1WLfJijCVN48lroUatdWADHFQqhfj
GNzuKe3X32KxaykxtzFcXuRE9+cz98O2mI4MPVBEj8NJe7hBMJmyncfC2r/VKZI=
=HcMg
-----END PGP SIGNATURE-----

--Gg6vG8tlNpxPV0GcvJlGfoffG6RQC6Fpl--
