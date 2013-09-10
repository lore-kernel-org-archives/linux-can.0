From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] can: remove unnecessary pci_set_drvdata()
Date: Tue, 10 Sep 2013 13:17:28 +0200
Message-ID: <522EFFC8.4060603@pengutronix.de>
References: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="owBIBdlKKcR7cSpuaxHtIi0ctmPr4HpjC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3IJLRl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 07:17:41 -0400
In-Reply-To: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--owBIBdlKKcR7cSpuaxHtIi0ctmPr4HpjC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/10/2013 01:05 PM, Jingoo Han wrote:
> Since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata =3D NULL when no driver is bound),
> the driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.

Tnx, all applied to net-next/testing. The series will be included in the
next pull request to David  Miller.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--owBIBdlKKcR7cSpuaxHtIi0ctmPr4HpjC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIu/80ACgkQjTAFq1RaXHO5egCdEJY1nMCy3yywdXpSKwxEHJ+i
yRAAn1UlhVD0kx5oQHUjBrAefJgnv6cY
=FEwQ
-----END PGP SIGNATURE-----

--owBIBdlKKcR7cSpuaxHtIi0ctmPr4HpjC--
