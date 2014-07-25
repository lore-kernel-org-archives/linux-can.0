From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 09:17:56 +0200
Message-ID: <53D204A4.1060502@pengutronix.de>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G5IndGBx0u3kgrOn6BwjnRL37NuWw5HiO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaGYHSH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 03:18:07 -0400
In-Reply-To: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G5IndGBx0u3kgrOn6BwjnRL37NuWw5HiO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2014 04:48 PM, Ssagarr Patil wrote:
> Hi,
>=20
> I am using the c_can driver for latest kernel and using the latest canu=
tils to dump to a file.
> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80%).=

>=20
> When I use the candump tool to dump can frames I get following message,=

>=20
> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 162909=
2)'

These are the CAN frames dropped by the socket, this means as Oliver
pointed out, that the candump fails to read the CAN frames fast enough
from the socket. How do you connect to the linux box with the c_can?
Where are the CAN frames printed to?

Dropped CAN frames by the hardware should be counted in the rx dropped
in ifconfig.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G5IndGBx0u3kgrOn6BwjnRL37NuWw5HiO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPSBKQACgkQjTAFq1RaXHOd3gCfU1HU/fi1f3oYrJMH0Gp4g4mP
wQIAoI7A/G36lp2tjtVB59RlDPw8ousM
=5Q5p
-----END PGP SIGNATURE-----

--G5IndGBx0u3kgrOn6BwjnRL37NuWw5HiO--
