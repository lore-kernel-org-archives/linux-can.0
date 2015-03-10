From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: use sock_efree instead of own destructor
Date: Tue, 10 Mar 2015 08:50:29 +0100
Message-ID: <54FEA245.4010001@pengutronix.de>
References: <1425959300-27132-1-git-send-email-fw@strlen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MnqoIq38uqOVASaP5eOCl70WJKEB8SDVg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbCJHui (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Mar 2015 03:50:38 -0400
In-Reply-To: <1425959300-27132-1-git-send-email-fw@strlen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org
Cc: socketcan@hartkopp.net, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MnqoIq38uqOVASaP5eOCl70WJKEB8SDVg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2015 04:48 AM, Florian Westphal wrote:
> It is identical to the can destructor.
>=20
> Signed-off-by: Florian Westphal <fw@strlen.de>

Thanks, applied to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MnqoIq38uqOVASaP5eOCl70WJKEB8SDVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU/qJJAAoJECte4hHFiupU0ZUP/1Xv8DnmyUTC4VjoiqyFzFft
qeyo4wIcrPBuvrb9+4ZCLZKwdyiaW2I/xvu00cMqy81bDSPeByswsHU4fqm+ybE/
kvQXnV1GSgHnK1pzD0MOmQQHHQYSyV6KwE/yVLcoLJkUBiOqof+LPBj7OhXAB4Xo
j8dbmv8PzfeBg80AlcCBhiAyU5yq4O6yGshRGbBIFFto0Kt34g9c3VQE5XYkAI1B
W8n86XMd6bpnSmJjnrnqKaJXRcYWPirMpvzm7bC+pTRsIY9fl54y51eSSwexZny9
mdEgePQ0phJwXo+/HjMqI6GET5YMp4xvB1whmlZGMZeT3f/fhdk00xVl65hbRyWH
W8K78GPziB2kwR7xMajSp4y8PXOHFsHn4j8BFUMIVJB9EtTIQ//fmJBS7LkIvnp4
gLdlQWMU/1u3yTJGDBNZLyX3Imex6c3aLBixHDXGJUL8r97f56S0bJNtfljA0nUz
2Ougp194/xnb5vfug6J84QWnx0+lXz8Do+uf5AMzWZCAW4Pj1jeSAisHm+IpwaB2
3ylHeF6zyKGbDw5q45FnxKlWJq2IhkQNtQkfBM0eWhABa5T1ANBBLjsFzDvUJXON
MLKUeWB2mm0xGosEe+z3ZbJHrfdhfuZFUuZxw4vRpnnv6xw5CcBFr7pg+aTIxMcD
L+PreDQ/4DQ28oFSCnRF
=kjgG
-----END PGP SIGNATURE-----

--MnqoIq38uqOVASaP5eOCl70WJKEB8SDVg--
