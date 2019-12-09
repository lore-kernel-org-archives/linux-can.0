From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Mon, 9 Dec 2019 23:07:58 +0100
Message-ID: <10c83189-eb3e-e6c3-b053-a204bc6d3132@pengutronix.de>
References: <20191209192440.998659-1-sean@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Unv0w6PGu62BFLpbvSgSY6yTzvNySuFBN"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Unv0w6PGu62BFLpbvSgSY6yTzvNySuFBN
Content-Type: multipart/mixed; boundary="EpL6olUdIMg4qCb87mq0s5VtdwokDiXiL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <10c83189-eb3e-e6c3-b053-a204bc6d3132@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191209192440.998659-1-sean@geanix.com>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>

--EpL6olUdIMg4qCb87mq0s5VtdwokDiXiL
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
>=20
> When the tcan device comes out of reset it comes out in standby mode.
> The m_can driver tries to access the control register but fails due to
> the device is in standby mode.
> So this patch will put the tcan device in normal mode before the m_can
> driver does the initialization.
>=20
> Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> tcan4x5x_init will now be called from probe and the m_can call.
> Would it be better to move the mode switch only to the probe function?
>=20
>  drivers/net/can/m_can/tcan4x5x.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/t=
can4x5x.c
> index 4e1789ea2bc3..3c30209ca84c 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -455,6 +455,8 @@ static int tcan4x5x_can_probe(struct spi_device *sp=
i)
>  	if (ret)
>  		goto out_clk;
> =20
> +	tcan4x5x_init(mcan_class);

add error handling

> +
>  	tcan4x5x_power_enable(priv->power, 1);
> =20
>  	ret =3D m_can_class_register(mcan_class);
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--EpL6olUdIMg4qCb87mq0s5VtdwokDiXiL--

--Unv0w6PGu62BFLpbvSgSY6yTzvNySuFBN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3uxb4ACgkQWsYho5Hk
nSCw7Af/TjVuu65VzsMgenpE9qf8TfOxnwUcoQxbA7OTryMUkO7R0qLyJCxos9OF
ndu/tlP/X78S7Z4G8R4PcD9XWgTAakXUm2ufir1XQ64/a0aMMic/wyXfg3Pb4sPU
OltridPf2+WUDeUakm3Gf+3b6ytlOX4mR4zMNM1t2HF0rxuvmIA4RlDxqKUiKndX
xmc0FSH+yUiKimxLbPFLoP9HXjZbAFIGYy6XyUDa95nGYe3HXcfF0Gv5enDlczQ+
iZ8ZwE/U9hwfLJn+5kd3MKqeRjkqQjQRpr6EXwx8YLpOMsHjyzJ31crhWwcTKRe6
5hxMz9VenEMh8yYg1zgQ+ySra4fJ6w==
=j2QW
-----END PGP SIGNATURE-----

--Unv0w6PGu62BFLpbvSgSY6yTzvNySuFBN--
