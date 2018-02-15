From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Thu, 15 Feb 2018 09:45:58 +0100
Message-ID: <ba246a16-4f9a-d247-a5c4-86a91ddc05df@pengutronix.de>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GHPijpFtlRGjjTHpobeLceEoZETawFnI2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35837 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966555AbeBOIqr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Feb 2018 03:46:47 -0500
In-Reply-To: <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GHPijpFtlRGjjTHpobeLceEoZETawFnI2
Content-Type: multipart/mixed; boundary="B6s3LrWDiPzo8kunaa1E0zxK6PlGaiOpa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
 o.rempel@pengutronix.de
Message-ID: <ba246a16-4f9a-d247-a5c4-86a91ddc05df@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
In-Reply-To: <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>

--B6s3LrWDiPzo8kunaa1E0zxK6PlGaiOpa
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 02/14/2018 10:20 PM, Elenita Hinds wrote:
> Thanks, Kurt and Oliver, for the feedback. The newest bcm changes look =
better.

Do you or anyone else care porting the new hrtimer-softirq approach to
j1939? Patches are welcome!

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--B6s3LrWDiPzo8kunaa1E0zxK6PlGaiOpa--

--GHPijpFtlRGjjTHpobeLceEoZETawFnI2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqFSMYACgkQk9IU1zQo
ZfGl4ggAgZ8uzhKA71KyYvB6TDWXsZ8j+HxS8x+8wPdNuiy3V+865A6I/LHwbjEP
FmhG11KtAcm59kaENocar/RaFElBdtANrVZYjIeS/83WEt95tmo5LesgzA1WzQGc
nUY1iyGlZm0M87Er6uVixQP1mOJ1l1xgkOWT+g/wcwSHofyWRiajvFfLbLvQHlIk
HEfzWmRoXJcSBDovo326cAGKSlNxwtJY6FeM0UD5L+CUlnPB45oM7PING3Fg3hW4
zr77CnAr/qb5ouq5tY4xf7LMAxlWYLXVAO2Ir0TdI1OlQ3+okMtr9faZaF3dgxSm
oicWbHF5e0WvDYeQu1YbarGMkMuzZw==
=675o
-----END PGP SIGNATURE-----

--GHPijpFtlRGjjTHpobeLceEoZETawFnI2--
