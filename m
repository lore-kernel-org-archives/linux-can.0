From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 12:01:59 +0200
Message-ID: <55EEB217.3080706@pengutronix.de>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NPTdVfEr7RRFhL4arrFu7BFKviLwHUWW2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbbIHKCI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 06:02:08 -0400
In-Reply-To: <55EEAD8D.3070603@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NPTdVfEr7RRFhL4arrFu7BFKviLwHUWW2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2015 11:42 AM, Daniel Squires wrote:
> Hi all,
>=20
> new to this list.
>=20
> Just a quick question at present, when using recv on a socket that is=20
> bound to a can interface, should the packets be received in the order=20
> they came off the wire? or is this not guaranteed?

Should be guaranteed. Which CAN core are you using? What's your kernel
version?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NPTdVfEr7RRFhL4arrFu7BFKviLwHUWW2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7rIXAAoJEP5prqPJtc/HYuIIALc+jEVj9XX4jFNkZhGyqc6B
nQDErzxxAr9NgHye54zqouLfZPhH4JXdoUTPj4DYk9XIoad8WnMK1uhIWIlX/qlS
/R4Kuc4n+eua636YvnBOZu2+5H5Hw8HkxiVIzKDAON+r8fV+26alLKlcrEik/5x6
k1P1eOJmcJV5GP0ghkMVpuMEMTern7CC1FxrdP4OR0pfMJwrbYRg1RQtmXJvZl7f
dHeMaS114OIk3iERTNAdsyEtswu2vDYBUzJPTnsbSi0mQ8oGUgbQQi27wLS9vOwC
lWteCy6w/JWWpE3UmUTEtDdaruJs5milFD5jd7Kkbavm8sk8phQkLySOCMIW8pU=
=UbCV
-----END PGP SIGNATURE-----

--NPTdVfEr7RRFhL4arrFu7BFKviLwHUWW2--
