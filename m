From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] Fixed disconnect bug by removing erroneous use of
 kfree()
Date: Wed, 24 Feb 2016 09:27:13 +0100
Message-ID: <56CD6961.8040604@pengutronix.de>
References: <1456190248.10201.2.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wIEi9dKNlCj6Bdb89de9om4HS2sIdEXHv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43809 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147AbcBXI1T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Feb 2016 03:27:19 -0500
In-Reply-To: <1456190248.10201.2.camel@schneidersoft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilain Schneider <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIEi9dKNlCj6Bdb89de9om4HS2sIdEXHv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 02:17 AM, Maximilain Schneider wrote:
> From b0a5029680d544faf07bcf636084b3fcafe59953 Mon Sep 17 00:00:00 2001
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Tue, 23 Feb 2016 01:03:53 +0000
> Subject: [PATCH 1/1] Fixed disconnect bug by removing erroneous use of =
kfree()
>  and revised disconnect routine.


Can you please probive a patch description, too. No need to resend the
patch, I'll add it while applying the patch.

> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wIEi9dKNlCj6Bdb89de9om4HS2sIdEXHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWzWlhAAoJED07qiWsqSVqBkUIAI/NKRzQKRl1LTk8+Gm3Aamg
fLC0PDKQiqJkBj2DfzUAauiwiLFPQn3E1BymwE/I8zbTt08yVhZgzEN+WkTuLymX
pi74MbQ/lQ2cY6aBHq4/eNd2c6ky8EZm5M/DNp+swNpiHZ7xsfKNsvE/RdQOyN8I
6OBOgjZAcQTc5uRcn0HR5N4+SW+3ZKSS0ssTK9SJmRyV41MsAVo509eAZHocULuO
qnXm6X9uWZouMWvx3flMay2cco7OMrOkhth7MaC4uN90+bQwM5vV6MJqLdax335w
gnKBjc5Rv4DFGCnU4xLopyHFqJq2+wThjEk1zNMf7rR7g481mCKMsWxt4F8uOHg=
=EMi6
-----END PGP SIGNATURE-----

--wIEi9dKNlCj6Bdb89de9om4HS2sIdEXHv--
