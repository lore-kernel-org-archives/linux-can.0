From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 10:44:04 +0100
Message-ID: <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zTkWg0j7TF75bMwJz0sfQGq8PPwIwfQJC"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zTkWg0j7TF75bMwJz0sfQGq8PPwIwfQJC
Content-Type: multipart/mixed; boundary="H5YrATQR7aCvVEolDjHMKRRRoLvvXHhH7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
In-Reply-To: <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>

--H5YrATQR7aCvVEolDjHMKRRRoLvvXHhH7
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/11/19 10:13 AM, Sean Nyekjaer wrote:
>>> When the tcan device comes out of reset it comes out in standby mode.=

>>> The m_can driver tries to access the control register but fails due t=
o
>>> the device is in standby mode.
>>> So this patch will put the tcan device in normal mode before the m_ca=
n
>>> driver does the initialization.
>>>
>>> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsing=
 the config")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>
>> Applied both to linux-can.
>=20
> Oh, the commit id for "can: tcan4x5x: Turn on the power before parsing =

> the config" have changed, since this morning :)

Ahh, I see.

Until there is a pull request (including a tag) the testing branch is
subject to rebase. Meaning, when there is a patch, that needs update I'm
happy to squash things into it.

I'm squashing there two commits into one:

> # This is a combination of 2 commits.
> # This is the 1st commit message:
>=20
> can: tcan4x5x: Turn on the power before parsing the config
>=20
> The parse config function now performs action on the device either
> reading or writing and a reset.  If the regulator is managed it needs
> to be turned on.  So turn on the regulator if available if the parsing
> fails then turn off the regulator.
>=20
> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO"=
)
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> # This is the commit message #2:
>=20
> can: tcan4x5x: put the device out of standby before register access
>=20
> The m_can tries to detect if Non ISO Operation is available while in
> standby, this function results in the following error:
>=20
> tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init mo=
dule
> tcan4x5x spi2.0: m_can device registered (irq=3D84, version=3D32)
> tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
>=20
> When the tcan device comes out of reset it comes out in standby mode.
> The m_can driver tries to access the control register but fails due to
> the device is in standby mode.
>=20
> So this patch will put the tcan device in normal mode before the m_can
> driver does the initialization.
>=20
> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsing t=
he config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Can you give me an updated commit message?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--H5YrATQR7aCvVEolDjHMKRRRoLvvXHhH7--

--zTkWg0j7TF75bMwJz0sfQGq8PPwIwfQJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3wumQACgkQWsYho5Hk
nSASpgf/Tg//eJhVtC3z0fRs1FjZ/PvQQUIJ7QK8ra6kqcx7ArTWvOlnimkSTJQT
3Yojumnp0KdrcUNnuc9lLje7JyT2uOrQ1zFgRf/C40K4Q90F5Qpx72+qUM/lldiA
bDwA+FiF6lRwDOhFHwrmSS2dfhbxLo2ND1x/zcfrG+7bvAyRm+jet4JVHOgpbZhl
JjTfnOBTAnw8UUjNugMedrGuPfOqjU0pSWjRRZcviCdS5A34e+CLA7f+7DFnRZT/
kOV0fViUwNU2aOpy0Wt8zmiWYHPVxcr5x3RF5kuvvXcxz3lh6Gz2VXJCCfuOicRl
S1c/oRpRD6ePK/6KA2pd8Hs2nUxGgQ==
=XTyP
-----END PGP SIGNATURE-----

--zTkWg0j7TF75bMwJz0sfQGq8PPwIwfQJC--
