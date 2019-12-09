From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Mon, 9 Dec 2019 22:38:54 +0100
Message-ID: <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
References: <20191209212351.27518-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DLMRSUmRtt9lp7lnhRoGwepgsbG4RVfM9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209212351.27518-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DLMRSUmRtt9lp7lnhRoGwepgsbG4RVfM9
Content-Type: multipart/mixed; boundary="lR6oLVnzpHXhyiy1wNaImBHO7kvjTN8yL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
Subject: Re: [PATCH] can: tcan4x5x: Turn on the power before parsing the
 config
References: <20191209212351.27518-1-dmurphy@ti.com>
In-Reply-To: <20191209212351.27518-1-dmurphy@ti.com>

--lR6oLVnzpHXhyiy1wNaImBHO7kvjTN8yL
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 10:23 PM, Dan Murphy wrote:
> The parse config function now performs action on the device either
> reading or writing and a reset.  If the regulator is managed it needs
> to be turned on.  So turn on the regulator if available if the parsing
> fails then turn off the regulator.
>=20
> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO"=
)
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/net/can/m_can/tcan4x5x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/t=
can4x5x.c
> index 4e1789ea2bc3..515486fcb150 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -451,11 +451,11 @@ static int tcan4x5x_can_probe(struct spi_device *=
spi)
>  	priv->regmap =3D devm_regmap_init(&spi->dev, &tcan4x5x_bus,
>  					&spi->dev, &tcan4x5x_regmap);
> =20
> +	tcan4x5x_power_enable(priv->power, 1);

please add error handling

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--lR6oLVnzpHXhyiy1wNaImBHO7kvjTN8yL--

--DLMRSUmRtt9lp7lnhRoGwepgsbG4RVfM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3uvu4ACgkQWsYho5Hk
nSAn7ggAoKOWw79UmN0uV7zJ4rUHexu77lrYryZoGx7R09pxcPS+++Qf+aGx8DaY
rq0BgVDIvgTYkThv1RxXIIk2kLQp/PlbN1C78YZgPyM9kIGu4SA1sxxre3JUkwVS
lDjjjA5BwnwfE0p/qMKpmnqf7aNVAuMHgpNsz9i9Pl2gB/Eeohpt9G7Jcriv2vRb
PRoYtMuB32wuTp5LscMRQJT/D3yZrhgLWXzpfOHDQyYya7Kt7IH1Hw/EOoevWec3
BAxDmFPS5daAXwMTMVZOhpl0LOwMb2Xz2ber83TlOlT4HtAnwI5qcAaC8t/YFoKp
2sLR8fDuRERFDXtyxCsD7giCBaBKzA==
=H0Be
-----END PGP SIGNATURE-----

--DLMRSUmRtt9lp7lnhRoGwepgsbG4RVfM9--
