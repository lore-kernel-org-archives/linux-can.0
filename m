From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
Date: Wed, 18 Oct 2017 13:48:27 +0200
Message-ID: <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0Fb4nltSJdutKWFeEXCHqjgLT76SoOKTu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49073 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965455AbdJRM21 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Oct 2017 08:28:27 -0400
In-Reply-To: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Fb4nltSJdutKWFeEXCHqjgLT76SoOKTu
Content-Type: multipart/mixed; boundary="4tSoVQwmuMuWG09po96NSHWHmCP37dUi8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
In-Reply-To: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>

--4tSoVQwmuMuWG09po96NSHWHmCP37dUi8
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 01:25 PM, Stefan M=C3=A4tje wrote:
> The original author of the module left our company. Replaced the email
> in the MODULE_AUTHOR() macro with a valid one.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
> index be928ce62d32..6183b7707ad7 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -2,6 +2,7 @@
>   * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>   *
>   * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd=
 gmbh
> + * Copyright (C)      2017 Stefan Maetje <stefan.maetje@esd.eu>, esd g=
mbh

Hmmm a copyright for a one liner?

>   *
>   * This program is free software; you can redistribute it and/or modif=
y it
>   * under the terms of the GNU General Public License as published
> @@ -26,7 +27,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
>=20
> -MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
> +MODULE_AUTHOR("Stefan Maetje <stefan.maetje@esd.eu>");

Maybe you should create a roll email address at your company and change
Matthias Fuchs's email to something like kernel@esd.eu. Think about
adding you or that role email to the MAINTAINERS file.

>  MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro
> interfaces");
>  MODULE_LICENSE("GPL v2");
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4tSoVQwmuMuWG09po96NSHWHmCP37dUi8--

--0Fb4nltSJdutKWFeEXCHqjgLT76SoOKTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnnP44ACgkQHv7KIOw4
HPZoHQf+K3Sc/9gTjDQMi2JAMkTx/FFpNj1Z4lyvThxlfVWk8U8X2THKo2xbOqd7
fYXpOFqFTsvFWkkdr/Q881NgWb3fYdxbxA4huxPw9xuXo/oHBD3PnSEgaRUkEk+v
M5OvMPTdPjs5Zb3JX6+epenaPluWK60IF1kvuXSkOKJ1scdqXLFvdKwiYlGvt+o4
5cEDtqzvsTQkupCDl6Zf+FCbwg0BIyBCyxXXx6qpkM9A3m5X37Wm9e9NdVvZTNwL
lYVrp0m7w2DfY8OIF0MOrLLOnbII+6MpQtTufFyntnJSYCnQ8WLYi7wNwZVQyPvY
HGngV/9ZhT1Krkj4c7QIgHyh039onw==
=TP3u
-----END PGP SIGNATURE-----

--0Fb4nltSJdutKWFeEXCHqjgLT76SoOKTu--
