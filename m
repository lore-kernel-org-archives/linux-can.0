From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
Date: Thu, 19 Oct 2017 09:55:18 +0200
Message-ID: <5726c394-aa99-5dae-3226-d111d7ff253a@pengutronix.de>
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
 <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
 <b7dc7929-f4b3-2b0b-cfd5-7c514166943d@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3awc7nsvbxS5tH0Hxorr91uTpLVR8uEVl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45503 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751827AbdJSHzg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 03:55:36 -0400
In-Reply-To: <b7dc7929-f4b3-2b0b-cfd5-7c514166943d@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3awc7nsvbxS5tH0Hxorr91uTpLVR8uEVl
Content-Type: multipart/mixed; boundary="OTXFVw3kn5b0xTxKRAOIfUkDfMJVlOmF2";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <5726c394-aa99-5dae-3226-d111d7ff253a@pengutronix.de>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
 <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
 <b7dc7929-f4b3-2b0b-cfd5-7c514166943d@esd.eu>
In-Reply-To: <b7dc7929-f4b3-2b0b-cfd5-7c514166943d@esd.eu>

--OTXFVw3kn5b0xTxKRAOIfUkDfMJVlOmF2
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 04:35 PM, Stefan M=C3=A4tje wrote:
> Am 18.10.2017 um 13:48 schrieb Marc Kleine-Budde:
>> On 10/18/2017 01:25 PM, Stefan M=C3=A4tje wrote:
>>> The original author of the module left our company. Replaced the emai=
l
>>> in the MODULE_AUTHOR() macro with a valid one.
>>>
>>> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
>>> ---
>>>  drivers/net/can/usb/esd_usb2.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd=
_usb2.c
>>> index be928ce62d32..6183b7707ad7 100644
>>> --- a/drivers/net/can/usb/esd_usb2.c
>>> +++ b/drivers/net/can/usb/esd_usb2.c
>>> @@ -2,6 +2,7 @@
>>>   * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>>>   *
>>>   * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, e=
sd gmbh
>>> + * Copyright (C)      2017 Stefan Maetje <stefan.maetje@esd.eu>, esd=
 gmbh
>>
>> Hmmm a copyright for a one liner?
>=20
> Yes, it's somewhat ridiculous but I only wanted to make it clear not to=

> use Matthias's address any more already at the top of the source file.
>=20
>>>   *
>>>   * This program is free software; you can redistribute it and/or mod=
ify it
>>>   * under the terms of the GNU General Public License as published
>>> @@ -26,7 +27,7 @@
>>>  #include <linux/can/dev.h>
>>>  #include <linux/can/error.h>
>>>
>>> -MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
>>> +MODULE_AUTHOR("Stefan Maetje <stefan.maetje@esd.eu>");
>>
>> Maybe you should create a roll email address at your company and chang=
e
>> Matthias Fuchs's email to something like kernel@esd.eu. Think about
>> adding you or that role email to the MAINTAINERS file.
>=20
> I would suggest an email address of "linux-kernel@esd.eu" which would
> result then in
>=20
> MODULE_AUTHOR("<linux-kernel@esd.eu>")
>=20
> Would that be ok?

I was thinking of:

-MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
+MODULE_AUTHOR("Matthias Fuchs <linux-kernel@esd.eu>");

aswell as for the copyright.

> On the other hand I would hesitate to add that email address to the
> kernel's MAINTAINER file. Then it would stand side by side to your and
> Wolfgang Grandeggers email adresses under "CAN NETWORK DRIVERS".
>=20
> Or do you mean to create a new section only describing the esd driver
> for the CAN-USB/2?

Yes.

> Wouldn't that be overkill also?

No, that's what that file is used for. All automated scripts use this
file instead of the copyright line or the MODULE_AUTHOR.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OTXFVw3kn5b0xTxKRAOIfUkDfMJVlOmF2--

--3awc7nsvbxS5tH0Hxorr91uTpLVR8uEVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnoWmYACgkQHv7KIOw4
HPYgzQgAq+uWXPblJ75lLEpRQPcgb+AgnqHjgm09SlbqFLVhaupw9nIzM6oiaxlu
5afQZiFBYQWCVdrEPwk2DQXiW9+zdDnxZH9ltWK8wukosfPLoom/S/e5wq/BF7e3
rt8cG3o4Zw1CNNbpdGkWH0xzhliZoK4GT/RSIs9jGdmT4jjh4evDY7SMKtkQZh8l
TCepbULv15ZPS70j+jWgkpcgrc7/98mgLNWjwyvasFbNuJ7DVTKcjNO1MmrcJUKV
gb2Sx5TYs2lwCPbO50ujO+ZcLIMGnSM6cFjqUxsum24BzdVxsz61yabaLFzszgqo
3qCAC2WAXOIfUnDZ4onJsl4lpKIrDQ==
=SJjU
-----END PGP SIGNATURE-----

--3awc7nsvbxS5tH0Hxorr91uTpLVR8uEVl--
