From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: Use common error handling code in vxcan_newlink()
Date: Tue, 7 Nov 2017 09:21:07 +0100
Message-ID: <92704ce5-d62e-ab58-546d-154eac16486a@pengutronix.de>
References: <2e600d9a-faec-dd39-08f0-5a7fb260d7ca@users.sourceforge.net>
 <2ab5d794-7a5c-9036-835c-67cfcc541795@hartkopp.net>
 <d3bdd3c0-5a03-dd59-07ca-94b126c67f75@users.sourceforge.net>
 <264b3c2b-8354-5769-639c-ac8d2fcbe630@hartkopp.net>
 <23fbbdba-fb11-a6bc-7d6a-4af43ef79503@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iaH0asOD4eNFce1WQKWCrBuh4X4NUpTNV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33865 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932593AbdKGIVT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Nov 2017 03:21:19 -0500
In-Reply-To: <23fbbdba-fb11-a6bc-7d6a-4af43ef79503@users.sourceforge.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iaH0asOD4eNFce1WQKWCrBuh4X4NUpTNV
Content-Type: multipart/mixed; boundary="mhfX1TjAEx4KTWD08QQLFBiusQA93w18h";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <92704ce5-d62e-ab58-546d-154eac16486a@pengutronix.de>
Subject: Re: [PATCH v2] can: Use common error handling code in vxcan_newlink()
References: <2e600d9a-faec-dd39-08f0-5a7fb260d7ca@users.sourceforge.net>
 <2ab5d794-7a5c-9036-835c-67cfcc541795@hartkopp.net>
 <d3bdd3c0-5a03-dd59-07ca-94b126c67f75@users.sourceforge.net>
 <264b3c2b-8354-5769-639c-ac8d2fcbe630@hartkopp.net>
 <23fbbdba-fb11-a6bc-7d6a-4af43ef79503@users.sourceforge.net>
In-Reply-To: <23fbbdba-fb11-a6bc-7d6a-4af43ef79503@users.sourceforge.net>

--mhfX1TjAEx4KTWD08QQLFBiusQA93w18h
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/01/2017 03:16 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 1 Nov 2017 14:56:15 +0100
>=20
> Add a jump target so that a bit of exception handling can be better reu=
sed
> at the end of this function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mhfX1TjAEx4KTWD08QQLFBiusQA93w18h--

--iaH0asOD4eNFce1WQKWCrBuh4X4NUpTNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloBbPMACgkQHv7KIOw4
HPZkLwf7BRwA5Pf97tzl3GZPBKekVGOJBp4P3IEYxIlud4q3zPSyY85B/WZST+E9
xCqjgFPLAFF3z8F7IXxbMLxim91+ixwZb4OZqFDf2F4Mz16wD8FJ6BcUFRzZrU9o
lcylTJGAreAo0jUR/zY2RNZdbUX9/OfoACB1yjpce+zXRC5/S/o+ma6RsXcfafQa
vRfypx7NqqasyN/WDMdlQGz7U7m3nsEAKO0SKoOtX+WiRXFUusvQYl62RwnVwMxS
dkNuDKKGwVgMvN2EoLQW5u8zq0s9aMMxvYxuz4FwP+xAL99qFbloMw6wTcXKs7cE
cBAwxn9IqDV8L61dgrn5sDyWUWJdFw==
=mDsF
-----END PGP SIGNATURE-----

--iaH0asOD4eNFce1WQKWCrBuh4X4NUpTNV--
