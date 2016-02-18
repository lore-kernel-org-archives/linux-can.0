From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCAN USB Pro FD one-shot
Date: Thu, 18 Feb 2016 14:49:02 +0100
Message-ID: <56C5CBCE.70807@pengutronix.de>
References: <56C5BF73.9040402@sevenbyte.org> <56C5C73D.5080304@pengutronix.de>
 <56C5C9A9.7030901@sevenbyte.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G1RrX14i0DgvMUuuMBoQ97e4laofpqq5E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46771 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425992AbcBRNtK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2016 08:49:10 -0500
In-Reply-To: <56C5C9A9.7030901@sevenbyte.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Tatschner <rumpelsepp@sevenbyte.org>, linux-can <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G1RrX14i0DgvMUuuMBoQ97e4laofpqq5E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/18/2016 02:39 PM, Stefan Tatschner wrote:
> On 18.02.2016 14:29, Marc Kleine-Budde wrote:
>> Indeed it's not supported by the driver. Maybe Stephane can tell,
>> if at least the hardware supports this feature.
>=20
> I had emailed the support a while ago. The mode seems to be supported;
> but they call it "single shot" instead. I assume it is the same as
> "one-shot", see also [1].

Yes seems so. Maybe you can get a datasheet to implement theat feature
in the linux driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G1RrX14i0DgvMUuuMBoQ97e4laofpqq5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWxcvOAAoJED07qiWsqSVqG/gH/0coRjDH8crFJgRjEHwNy3ym
fPcmZ/rI54Omd2rNsNdD99VZ7sESXyqhRI++o7UP8hVtsGaLdTkIZTm95pBFZd7G
7x9y9ZeXlbpIxiAQewzknOvuudb3JU9BJVA5+z/K1PYW5wD5D1o7ZYvnieVyaUZz
DlW2l6r2T2LkXcGqqig+E9XfHxsgMB6b6V57s/wVJUhDhy714iDtIzRJ8aehmIfe
9ZoWzGGaYDb8gSvoEbJvaJIR9OzLmaC9Mn5hSOroIwyTb/hYwGZW/dJD9ON92bIB
9IUGZw3MmXHahWNg+Ix5RH0t91e1e+ruTcsNe1LMVqKXr1+cGp57/zC/VK6oB9s=
=3aHx
-----END PGP SIGNATURE-----

--G1RrX14i0DgvMUuuMBoQ97e4laofpqq5E--
