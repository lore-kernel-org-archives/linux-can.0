From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-utils: AOSP build clean up
Date: Wed, 10 Jul 2013 11:05:51 +0200
Message-ID: <51DD23EF.1040203@pengutronix.de>
References: <1373441337-3016-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XEKGWBPBOOVXWKPNHXBF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34370 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab3GJJF7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Jul 2013 05:05:59 -0400
In-Reply-To: <1373441337-3016-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XEKGWBPBOOVXWKPNHXBF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2013 09:28 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Remove unneeded includes. Both AOSP and NDK builds tested.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Looks good, pushed to master.

tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XEKGWBPBOOVXWKPNHXBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHdI+8ACgkQjTAFq1RaXHMougCghMJ63x/6F5gtuzBPQHDgCcZ5
NoQAni9pfxTVZCX9Fxp+3BK3+KSD3EaN
=vWDc
-----END PGP SIGNATURE-----

------enig2XEKGWBPBOOVXWKPNHXBF--
