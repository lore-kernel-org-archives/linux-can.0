From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 09:42:13 +0100
Message-ID: <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
References: <20191211064208.84656-1-sean@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="e6vz8528PE2mMsHSDAv42MmP46Kr29LHk"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191211064208.84656-1-sean@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e6vz8528PE2mMsHSDAv42MmP46Kr29LHk
Content-Type: multipart/mixed; boundary="InbDMWiVVpm24VjPoua8Ud02RL7xL9V8F";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191211064208.84656-1-sean@geanix.com>
In-Reply-To: <20191211064208.84656-1-sean@geanix.com>

--InbDMWiVVpm24VjPoua8Ud02RL7xL9V8F
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/11/19 7:42 AM, Sean Nyekjaer wrote:
> The m_can tries to detect if Non ISO Operation is available while in st=
andby,
> this function results in the following error:
>=20
> tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init mo=
dule
> tcan4x5x spi2.0: m_can device registered (irq=3D84, version=3D32)
> tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
>=20
> When the tcan device comes out of reset it comes out in standby mode.
> The m_can driver tries to access the control register but fails due to
> the device is in standby mode.
> So this patch will put the tcan device in normal mode before the m_can
> driver does the initialization.
>=20
> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsing t=
he config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Applied both to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--InbDMWiVVpm24VjPoua8Ud02RL7xL9V8F--

--e6vz8528PE2mMsHSDAv42MmP46Kr29LHk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3wq+UACgkQWsYho5Hk
nSCxcwf+ODt3N+sCojcpPqcPXwWN8xD94PmPUHZlmwDmh1xki6jwINyiBAYKg3rb
0OuXuPoGjBC4wF5LDb7uIvfB4cRoUTX8EUIKImUcsUhlY3R27oVQYjyIpVNaAecE
wvll5UDlBhX+CObprWY+F7elMIABicoZzIgDnCAehaxfGtD5tEdmmoN4rosv1ody
0IAmdt2e1DBBj7+pWhVLEG1cgQhGHuqSKk1qYJg1N7QrB9hlc2+peVq3x+jKjZDX
KA3fqv42CsJlaM2Y6PYPsUaVCG+X7bV6O5NoGuGni+E8EuVvkxTyb8NH4Yt/0rxC
8pHppsWPzBozh9tNSvdFobm2aHZwvw==
=GkFP
-----END PGP SIGNATURE-----

--e6vz8528PE2mMsHSDAv42MmP46Kr29LHk--
