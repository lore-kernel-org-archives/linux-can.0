From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Mon, 9 Dec 2019 22:10:36 +0100
Message-ID: <cdb10440-b599-a6a5-5aa0-a7598086f6fa@pengutronix.de>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
 <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
 <cc310081-1855-958b-fbe4-529937ff941c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="p4lqAcromnNRRkcHxQkBKd2GE9PCjaCyX"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cc310081-1855-958b-fbe4-529937ff941c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p4lqAcromnNRRkcHxQkBKd2GE9PCjaCyX
Content-Type: multipart/mixed; boundary="BHQVwyeJqnSjP3B8lw0V6Rp4wsosrgIk8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <cdb10440-b599-a6a5-5aa0-a7598086f6fa@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
 <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
 <cc310081-1855-958b-fbe4-529937ff941c@ti.com>
In-Reply-To: <cc310081-1855-958b-fbe4-529937ff941c@ti.com>

--BHQVwyeJqnSjP3B8lw0V6Rp4wsosrgIk8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 10:07 PM, Dan Murphy wrote:
>>> Do you know when you will be applying these?
>> The patch is already upstream. See linux-can/mater:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/=

>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/comm=
it/?id=3D2de497356955ce58cd066fb03d2da5235f3c7c23
>=20
> Ah I was looking here
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

Bugfixes go to linux-can. New features to linux-can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--BHQVwyeJqnSjP3B8lw0V6Rp4wsosrgIk8--

--p4lqAcromnNRRkcHxQkBKd2GE9PCjaCyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3uuEwACgkQWsYho5Hk
nSCOZwf/YOGF+4BjJItncdFEN5gr5yU6CysXSMGoG9LyvUcdk7SR6X0qQZZO1l/q
uSNKSMOG22iwkiMpNhWPrK7plwDj8B2AdR4iuk1yTkyzOcuhPf/KZ5x3wdV+HBou
gOzehE93W/VKJDwfxzPho8oMoA2EwKFAhHW0+Kj8UnaEpR+eanBJ2CscYzIYoQBz
pdUod5U+Y1My1nrsjuIZ8bBolnJAEHwBaZln6aZTMuvQmqbziFcY4P/7zS00hUDo
EfPcZLJp8iWpOL/FvX4hpJuqXKUjIJkwo7PuBckxXivTgfaks7diqMta3GgEipf7
npftzFPY0N4m8EMd0/eXdETPJ7QnWQ==
=Aj07
-----END PGP SIGNATURE-----

--p4lqAcromnNRRkcHxQkBKd2GE9PCjaCyX--
