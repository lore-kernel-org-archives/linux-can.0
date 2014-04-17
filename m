From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: c_can: use proper type for 'instance'
Date: Thu, 17 Apr 2014 21:22:41 +0200
Message-ID: <53502A01.10908@pengutronix.de>
References: <1397725047-7833-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XLj2pspKKrFtHvI0pdNeMPfeHNhRf92K0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58665 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbaDQTWx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 15:22:53 -0400
In-Reply-To: <1397725047-7833-1-git-send-email-wsa@the-dreams.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>, linux-can@vger.kernel.org
Cc: Chen Gang <gang.chen@asianux.com>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLj2pspKKrFtHvI0pdNeMPfeHNhRf92K0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2014 10:57 AM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Commit 6439fbce1075 (can: c_can: fix error checking of priv->instance i=
n
> probe()) found the warning but applied a suboptimal solution. Since, bo=
th
> pdev->id and of_alias_get_id() return integers, it makes sense to conve=
rt the
> variable to an integer and avoid the cast.
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Applied to can/master.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XLj2pspKKrFtHvI0pdNeMPfeHNhRf92K0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQKgEACgkQjTAFq1RaXHOb0ACgj8e1Pd+dpSHM71ObZnDB8X1u
njoAoIxf7moIQYXvdxYYPpI9wJHYA1pM
=RHIX
-----END PGP SIGNATURE-----

--XLj2pspKKrFtHvI0pdNeMPfeHNhRf92K0--
