From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-utils: fix local header path for AOSP build
Date: Fri, 01 Feb 2013 10:33:08 +0100
Message-ID: <510B8BD4.2000301@pengutronix.de>
References: <1359704686-3040-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DTCHVDHCXPIDSVWJUHJH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50891 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab3BAJdP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 04:33:15 -0500
In-Reply-To: <1359704686-3040-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DTCHVDHCXPIDSVWJUHJH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2013 08:44 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Use path relative to the can-utils source code and to root of
> the AOSP repository.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Thx, pushed to master.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DTCHVDHCXPIDSVWJUHJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlELi9cACgkQjTAFq1RaXHO2pgCdGvaDBXr+5leBTFtNu3bzNQ1g
CAUAn0Zw1+Ux10uj6z5DLr84IulzqmFH
=ROvZ
-----END PGP SIGNATURE-----

------enig2DTCHVDHCXPIDSVWJUHJH--
