From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Allwinner SoC CAN controller Support
Date: Thu, 10 Sep 2015 11:07:16 +0200
Message-ID: <55F14844.9050806@pengutronix.de>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
 <55EEBDC4.8050800@pengutronix.de>
 <19003c5e5894dc0d656490cd17be1bcb@mail.rdts.de>
 <55F13CB7.6050603@pengutronix.de>
 <CAJ=nTstAWKjszZMyGJVXPn0bJqF1mn6HGHu8L_tpwsmrGXazTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2kO93INhCArGsMvannn32UpDwJmcnijRH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbIJJH0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 05:07:26 -0400
In-Reply-To: <CAJ=nTstAWKjszZMyGJVXPn0bJqF1mn6HGHu8L_tpwsmrGXazTg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2kO93INhCArGsMvannn32UpDwJmcnijRH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/10/2015 10:29 AM, Mirza Krak wrote:
> 2015-09-10 10:17 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>> On 09/10/2015 08:29 AM, Gerhard Bertelsmann wrote:
>>>>> +
>>>>> +static struct platform_driver sunxi_can_driver =3D {
>>>>> +   .driver =3D {
>>>>> +              .name =3D DRV_NAME,
>>>>
>>>> Please remove the .name.
>>>
>>> Without it, the kernel oops
>>
>> Doh! But there was one assignment here, that was not needed...I'll try=

>> to remember which one it was.
>>
>=20
> I believe
>=20
>     .owner =3D THIS_MODULE,
>=20
> is not needed.

Makes sense.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2kO93INhCArGsMvannn32UpDwJmcnijRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV8UhEAAoJEP5prqPJtc/HK48H/25V5S8+LK7Je27Y2QbfMTF2
PXGbIE7nfpFpvBb7ElLMNl2vM7tOup9CnF6e1chw2C8hx2wE5AAxLwliRwqi1YD8
yU7K8J4/Z0Xvu5//3vlkLNqRWzkO0i5IDBKQ5oitAM+L82C+3e9koOteyt+Z/KdG
mwe53eEw4Ahh4+bY7rtHAkPPRJ/3tp+DjqtaLonrpWLPZsOiNnNw99OTQfT311rP
mVyY+S0eufSYkkFRSr6dcxUnf1M1b1eYEAcYmtpglUGF9w3KHlmr1qVAwzeLjm7c
aEO2SAEakUDsJiBXozxZvXoPctzKCm46BqmMnjq48CLlIlygCRzLquRUKNcFSJw=
=CopW
-----END PGP SIGNATURE-----

--2kO93INhCArGsMvannn32UpDwJmcnijRH--
