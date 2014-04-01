From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: mcp251x: Remove unnecessary power disabling
Date: Tue, 01 Apr 2014 22:36:27 +0200
Message-ID: <533B234B.3030907@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru> <1396001687-7092-4-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PPln3GuHf7AKcKrvS3ojjbpjn8UIFP15P"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55291 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaDAUgg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 16:36:36 -0400
In-Reply-To: <1396001687-7092-4-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPln3GuHf7AKcKrvS3ojjbpjn8UIFP15P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
> This patch remove unnecessary power disabling on error and on module
> exit since this is already done by regulator API.

Oh really? Can you point me to the commit in mainline which introduces
this change? As far as I understand devm just callss
devm_regulator_release(), which calls regulator_put().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PPln3GuHf7AKcKrvS3ojjbpjn8UIFP15P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7I0sACgkQjTAFq1RaXHMMiwCdGvj5XuKt02Oo7F5R/2GBaIIq
iKQAoJV5BB7NpCjHKWRS7ULztS6MdCSc
=MqDz
-----END PGP SIGNATURE-----

--PPln3GuHf7AKcKrvS3ojjbpjn8UIFP15P--
