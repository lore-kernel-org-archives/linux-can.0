From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received
 RTR, frames
Date: Thu, 19 Oct 2017 13:43:56 +0200
Message-ID: <5ac14a0a-874c-9a9d-2a25-4b09a47b46cc@pengutronix.de>
References: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
 <c8a381af-e6ab-cb0c-6a7d-248ab3a9a866@esd.eu>
 <d3cdf11e-31c2-d74a-4fed-953ca85ca513@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fBRKGP6F7BFqfBcsnsfXoJNxXJfG3xtwk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58873 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752272AbdJSLoF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 07:44:05 -0400
In-Reply-To: <d3cdf11e-31c2-d74a-4fed-953ca85ca513@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fBRKGP6F7BFqfBcsnsfXoJNxXJfG3xtwk
Content-Type: multipart/mixed; boundary="SmgNCq3OumaaWEBpooDR57d9jSeFtTKCh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <5ac14a0a-874c-9a9d-2a25-4b09a47b46cc@pengutronix.de>
Subject: Re: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received
 RTR, frames
References: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
 <c8a381af-e6ab-cb0c-6a7d-248ab3a9a866@esd.eu>
 <d3cdf11e-31c2-d74a-4fed-953ca85ca513@esd.eu>
In-Reply-To: <d3cdf11e-31c2-d74a-4fed-953ca85ca513@esd.eu>

--SmgNCq3OumaaWEBpooDR57d9jSeFtTKCh
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 01:40 PM, Stefan M=C3=A4tje wrote:
> Hi Marc,
>=20
> I've seen you already added the changed patch to your last pull request=

> for the main line kernel.
>=20
> Thank you for doing so without waiting for me sending a changed patch.

np.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SmgNCq3OumaaWEBpooDR57d9jSeFtTKCh--

--fBRKGP6F7BFqfBcsnsfXoJNxXJfG3xtwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnoj/wACgkQHv7KIOw4
HPZyfQf4z/uj+kBhu7n/uhpdVsPbPmhf69UcEHwFxdoOd6W9cF+l7Kjzrgtx11pD
PP7mFg2akzIXs1ITOLCD2qn0Tb6bb4u8IucJc5Jxw7eU7SMtJpYa/iTxf6kslWYA
35MB+/NihXKmuVDa7Pq8w/hMFbPKUKQMlF6/Y237xnOwSRpeEZZsyT55mf0lees1
6Q4svEqwtqJ45Uh6NUEivxUbVnIQRUNvz9KQwbCPA2pIoXXubQSXHHGe8hS+jA6B
0nbgW8NeGesNm6CHOL54zBWYSvBAaoHIZUQnuCMeowLku22JQRlAXW40NeIYcFfI
moe/HKGRtiVp4h7w6OkI2Kg9xuA+
=RQ5o
-----END PGP SIGNATURE-----

--fBRKGP6F7BFqfBcsnsfXoJNxXJfG3xtwk--
