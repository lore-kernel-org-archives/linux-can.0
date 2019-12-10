From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH][next] can: tcan45x: Fix inconsistent IS_ERR and PTR_ERR
Date: Tue, 10 Dec 2019 17:35:44 +0100
Message-ID: <095ab519-8dd9-4971-83ae-85e96c796d11@pengutronix.de>
References: <20191210150532.GA12732@embeddedor>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="R9XkPeRyhuEFt6TFKubqSxxwhq61N3wMA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210150532.GA12732@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Dan Murphy <dmurphy@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R9XkPeRyhuEFt6TFKubqSxxwhq61N3wMA
Content-Type: multipart/mixed; boundary="CejTD8dxQvWUIgUTNgihNi1N7v5kDiLMf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Dan Murphy <dmurphy@ti.com>, Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <095ab519-8dd9-4971-83ae-85e96c796d11@pengutronix.de>
Subject: Re: [PATCH][next] can: tcan45x: Fix inconsistent IS_ERR and PTR_ERR
References: <20191210150532.GA12732@embeddedor>
In-Reply-To: <20191210150532.GA12732@embeddedor>

--CejTD8dxQvWUIgUTNgihNi1N7v5kDiLMf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 4:05 PM, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in tcan4x5x_parse_config.
>=20
> The proper pointer to be passed as argument is tcan4x5x->device_wake_gp=
io.
>=20
> This bug was detected with the help of Coccinelle.
>=20
> Fixes: 2de497356955 ("can: tcan45x: Make wake-up GPIO an optional GPIO"=
)
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--CejTD8dxQvWUIgUTNgihNi1N7v5kDiLMf--

--R9XkPeRyhuEFt6TFKubqSxxwhq61N3wMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3vyWAACgkQWsYho5Hk
nSDQoAf4gHv21bwcm2rpLFf7ZB0YPYaPWz7fcDxQ7KpM7BOeuh9AVn/6EpV3mVEz
W/QEKztlw91dD9V4FXb5POetjW34wZ2xpBV6tn225avbl5DBQvhFw9G9BUVcQSua
pJDaYM8j3Rbgloh13uqiROCosKtFf0ObL7VoSjEa3zAFSP9V3cA/12TLMHu0yO6i
WV3uLLL4HbBPgB43oVXJ/BMoF5ebzk61Zqtwd3ztht5W5xFyflrtyZ/f93I9eLSW
HvufQOVGs573rIndn6yobXrFX8D/7TwJIyZDNv+KcK4GPKZcIMx64vhMNBpLVkVR
NRyixv0vtF/2GO3oS28D6wjn7ZhQ
=MmTk
-----END PGP SIGNATURE-----

--R9XkPeRyhuEFt6TFKubqSxxwhq61N3wMA--
