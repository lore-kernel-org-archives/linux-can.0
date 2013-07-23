From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] flexcan: Use devm_ioremap_resource()
Date: Tue, 23 Jul 2013 12:08:20 +0200
Message-ID: <51EE5614.10008@pengutronix.de>
References: <1374507700-21575-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QNSNPDWIXWGMNUDBOKOD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33112 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab3GWKIa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2013 06:08:30 -0400
In-Reply-To: <1374507700-21575-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-can@vger.kernel.org, festevam@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QNSNPDWIXWGMNUDBOKOD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2013 05:41 PM, Fabio Estevam wrote:
> Using devm_ioremap_resource() can make the code simpler and smaller.
>=20
> Also, place alloc_candev() after of_match_device() to make error handli=
ng
> easier.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Looks good, I've added a "can: " prefix to the subject while applying
the patch to linux-can-next.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QNSNPDWIXWGMNUDBOKOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHuVhUACgkQjTAFq1RaXHNwFgCfbgEYSYUhwO7zRJeMyzxOUdZS
2gEAoJNyviyTbIrn5L9JKLCL8HsfjRrV
=2MJ+
-----END PGP SIGNATURE-----

------enig2QNSNPDWIXWGMNUDBOKOD--
