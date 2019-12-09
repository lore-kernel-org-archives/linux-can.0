From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Mon, 9 Dec 2019 22:06:41 +0100
Message-ID: <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qysqqwlioj7jMLPUF8owRfsrQmF1Y7tcU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qysqqwlioj7jMLPUF8owRfsrQmF1Y7tcU
Content-Type: multipart/mixed; boundary="OVM2iTg6o7PLxhTFgsGZyv8P50q7QxeHW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
In-Reply-To: <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>

--OVM2iTg6o7PLxhTFgsGZyv8P50q7QxeHW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 10:01 PM, Dan Murphy wrote:
>>>> I would add tcan4x5x to the subject of this patch ->
>>>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>>>
>>> Do you want me to submit v2 with the $subject change?
>>>
>>> Or would you fix it up when committing it?
>> I'll change the subject while applying.
>>
>> Dan, what about maintainerchip of the tcan4x5?
>=20
> Do you know when you will be applying these?

The patch is already upstream. See linux-can/mater:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commit/=
?id=3D2de497356955ce58cd066fb03d2da5235f3c7c23

> I have 2 patches I need to put on top.

Please post them as linux-can/master as base.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--OVM2iTg6o7PLxhTFgsGZyv8P50q7QxeHW--

--qysqqwlioj7jMLPUF8owRfsrQmF1Y7tcU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3ut2EACgkQWsYho5Hk
nSA/mwf+PnpSx6nJ85whf2CchaP6BN5HAtOlBfQebV3OC/5+SHeAQP8+Lxsf0y61
XYUKhK/GPwwxIU2KdzeANWnePnxx++p8XqK9prbzQTcS1Ve5RqHxABN8XqIR97ff
od/frSwh4e1Dv4KVx39kEtMnVHVKFAMVdVYs+i+VMXJcsqONq4pFUmIsr5gUDL91
c44BKIfbXuYpSN7cKH+iDPtu7IA0rkfPKT+PYv7DW8+G0KWTpg/cmuBOHnLiaM+y
QXlwg7GLDrSloEW3IdabpIEo1/r92d0B4zUVTN2VBpephsFYliVxqJlFqUONT1u+
Yu5QD6yFRnG3bRx1O9d+5m/ezswUdw==
=sENz
-----END PGP SIGNATURE-----

--qysqqwlioj7jMLPUF8owRfsrQmF1Y7tcU--
