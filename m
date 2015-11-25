From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 25 Nov 2015 15:58:21 +0100
Message-ID: <5655CC8D.70508@pengutronix.de>
References: <5655BF6D.3000701@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xdokT2Avu2WjlGXeGxjN2RkSs63xbRNvN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57114 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbKYO62 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 09:58:28 -0500
In-Reply-To: <5655BF6D.3000701@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xdokT2Avu2WjlGXeGxjN2RkSs63xbRNvN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2015 03:02 PM, Guillaume Picquet wrote:
> Hi all,
>=20
> I prefer to ask first to those who know.
>=20
> What is the 'normal' way of setting CAN bitrate from user-space=20
> application ?
> Is there a library for that ?

Yes -
http://www.pengutronix.de/software/libsocketcan/download/libsocketcan-0.0=
=2E10.tar.bz2

> If no shall I use netlink ?

No - netlink parsing makes your brain hurt :D

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xdokT2Avu2WjlGXeGxjN2RkSs63xbRNvN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWVcyOAAoJEP5prqPJtc/H6PYIAKhskrbeC/UkhXAC5haAE9SZ
79TGKYsYKEVZf4mlowj2Frp4jCRRGAR3xgRygb8/j34pqOiHh/y+x0MfFKdf+a6A
KerKTcN8qp208z7/cP2+mGtsHPxBJmHT4vyGiK9QK+LEwFeVMwBeDb3lye78hkzx
kGic8DpgNhxNIcUuybXKWu6asPMrQ7T+uBgxcLgIqZS8fxC6wUpKDW1sgOcG/YIc
4/n4G0qIUpQO1Z6ZveRyzhfEzSz9UVkVkD0MLIGDPnJaF/cCIveL+iIbO+xXcahB
4kmOP/4mJbUUsnsr/nUGhVx1daBvXhW4CZe62JuGVv9uhGifLe94IAXu9b3Outo=
=4g9u
-----END PGP SIGNATURE-----

--xdokT2Avu2WjlGXeGxjN2RkSs63xbRNvN--
