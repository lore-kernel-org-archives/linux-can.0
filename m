From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/9] can: use dev_get_platdata()
Date: Tue, 10 Sep 2013 11:02:19 +0200
Message-ID: <522EE01B.2030307@pengutronix.de>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cLNA3Qxv0m8M0BE9KgjtvmpHTPUrdMamB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56945 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab3IJJC2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 05:02:28 -0400
In-Reply-To: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cLNA3Qxv0m8M0BE9KgjtvmpHTPUrdMamB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/10/2013 10:39 AM, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly. This is a cosmetic change
> to make the code simpler and enhance the readability.

Tnx, all applied to net-next/testing. The series will be included in the
next pull request to David  Miller.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cLNA3Qxv0m8M0BE9KgjtvmpHTPUrdMamB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIu4BwACgkQjTAFq1RaXHMf/gCdGQOvFInWZCxyj1WPXWKKBF0y
FoYAn0gO6NmZPuOVc/VQwyWtKWabHotQ
=OGaN
-----END PGP SIGNATURE-----

--cLNA3Qxv0m8M0BE9KgjtvmpHTPUrdMamB--
