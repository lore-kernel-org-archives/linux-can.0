From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: don't indicate triple sampling support for
 D_CAN
Date: Mon, 6 Nov 2017 14:39:43 +0100
Message-ID: <a954f72a-725f-40f0-cf32-d9983f3d6c8c@pengutronix.de>
References: <20171029120322.22197-1-rschuetz@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BqHwhWwdx3E3FcT11kIrHxNQbAplFVb5q"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59695 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932126AbdKFNju (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2017 08:39:50 -0500
In-Reply-To: <20171029120322.22197-1-rschuetz@uni-koblenz.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Richard_Sch=c3=bctz?= <rschuetz@uni-koblenz.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BqHwhWwdx3E3FcT11kIrHxNQbAplFVb5q
Content-Type: multipart/mixed; boundary="pIMnNm6MWETGIgJqCvFCLhMUsXqs9U0tg";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Richard_Sch=c3=bctz?= <rschuetz@uni-koblenz.de>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Message-ID: <a954f72a-725f-40f0-cf32-d9983f3d6c8c@pengutronix.de>
Subject: Re: [PATCH] can: c_can: don't indicate triple sampling support for
 D_CAN
References: <20171029120322.22197-1-rschuetz@uni-koblenz.de>
In-Reply-To: <20171029120322.22197-1-rschuetz@uni-koblenz.de>

--pIMnNm6MWETGIgJqCvFCLhMUsXqs9U0tg
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/29/2017 01:03 PM, Richard Sch=C3=BCtz wrote:
> The D_CAN controller doesn't provide a triple sampling mode, so don't s=
et
> the CAN_CTRLMODE_3_SAMPLES flag in ctrlmode_supported. Currently enabli=
ng
> triple sampling is a no-op.
>=20
> Signed-off-by: Richard Sch=C3=BCtz <rschuetz@uni-koblenz.de>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pIMnNm6MWETGIgJqCvFCLhMUsXqs9U0tg--

--BqHwhWwdx3E3FcT11kIrHxNQbAplFVb5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloAZiAACgkQHv7KIOw4
HPbKUwf6A7HYxYzznc2V6LZiIN/0ItogP9jSriEtEWrYUHybosSv4Wsth9zb1oGH
GICEkopTAzoKYlCxbh8VJ3AsvPKCEsUTOf7gr8AfB2xdGH+mm8VwOK2nTHpqQKbY
0QrYP/9DUYKsAYeEIzjRG2zowlhHiBiYnG19XaWrz5pIWJOdMZpsQXVsl5P606+b
2tIY9M9/waDe70PCSZv99RYz47mO4QA7qAK3Tn1+Davo+tuV8bxZCWyxFXnsjomv
YN+extYmQHiMb0OoHd0f+qHmgujGlEUtNLHxpARjexQZ32vlQdzcKWVA3TwIQFEM
8VMUarzb5K+kpRWQmPwAKmYxkP3J7g==
=+MIT
-----END PGP SIGNATURE-----

--BqHwhWwdx3E3FcT11kIrHxNQbAplFVb5q--
