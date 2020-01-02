From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Thu, 2 Jan 2020 16:46:54 +0100
Message-ID: <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
References: <20191209192440.998659-1-sean@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bk90h3EihotBQbuOoPzh7VMn1HGgzQ4DV"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bk90h3EihotBQbuOoPzh7VMn1HGgzQ4DV
Content-Type: multipart/mixed; boundary="EsO2yfAbvCsPUQ50DqRrCMBVO4aDHuNX1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191209192440.998659-1-sean@geanix.com>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>

--EsO2yfAbvCsPUQ50DqRrCMBVO4aDHuNX1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 8:24 PM, Sean Nyekjaer wrote:
> The m_can tries to detect of niso (canfd) is available while in standby=
,
> this function results in the following error:
>=20
> tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init mo=
dule
> tcan4x5x spi2.0: m_can device registered (irq=3D84, version=3D32)
> tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.

Can you add the missing error handling to m_can_config_endisable(), and
handle this error correctly in all its callers?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--EsO2yfAbvCsPUQ50DqRrCMBVO4aDHuNX1--

--bk90h3EihotBQbuOoPzh7VMn1HGgzQ4DV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4OEG4ACgkQWsYho5Hk
nSDTVAf8D0t4VeoPmZdnqafB92TkUl6FZiP/oJFclMEmtW++RozQnuXK/qNiKe0x
anEzTn2FXUCkVSlKxY4Enj9bEMPMtGEO17riJOXSdZO3TX2I4iTXgpdj2rW8hDj7
sDrPGa4VoYaDaaSPrd045hsdenfSvdMPg+aCINDyZdUS+cIPHaACxH/gClqtlwfn
2tZaXwDtFvaxeWqbAByzafp6IHNtRiukvqgswr2eya0eJmUivJuCMy+P3sebnznf
yzZCb4MN+A80X8LXrgzHDRak6UzPx9iv6AbKEisRl0vufEghJFU76w24Q3JBDzLG
V7WeMB1g6xzEWj+NZbmheA6q0veIJA==
=QNq3
-----END PGP SIGNATURE-----

--bk90h3EihotBQbuOoPzh7VMn1HGgzQ4DV--
