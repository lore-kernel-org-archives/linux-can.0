From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
Date: Sun, 29 Dec 2019 16:32:08 +0100
Message-ID: <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
References: <20191212161536.23264-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="N1nesT42QyOxVEMMoQougOQqY8SIbiSL0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212161536.23264-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1nesT42QyOxVEMMoQougOQqY8SIbiSL0
Content-Type: multipart/mixed; boundary="av7eADa9mYDcTsXodHZDp6AFIW6KEoww7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Message-ID: <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
References: <20191212161536.23264-1-dmurphy@ti.com>
In-Reply-To: <20191212161536.23264-1-dmurphy@ti.com>

--av7eADa9mYDcTsXodHZDp6AFIW6KEoww7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/12/19 5:15 PM, Dan Murphy wrote:
> If the device state GPIO is not connected to the host then disable the
> INH output from the TCAN device per section 8.3.5 of the data sheet.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Applied to linux-can. With some changes...

>  drivers/net/can/m_can/tcan4x5x.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/t=
can4x5x.c
> index b5d2ea0999c1..6a1f242d1876 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -102,6 +102,7 @@
>  #define TCAN4X5X_MODE_NORMAL BIT(7)
> =20
>  #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
> +#define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> =20
>  #define TCAN4X5X_SW_RESET BIT(2)
> =20
> @@ -360,6 +361,15 @@ static int tcan4x5x_disable_wake(struct m_can_clas=
sdev *cdev)
>  				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
>  }
> =20
> +static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
> +{
> +	struct tcan4x5x_priv *tcan4x5x =3D cdev->device_data;
> +
> +	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> +

Removed the stray line while applying.

> +}
> +
>  static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>  {
>  	struct tcan4x5x_priv *tcan4x5x =3D cdev->device_data;
> @@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_clas=
sdev *cdev)
>  	tcan4x5x->device_state_gpio =3D devm_gpiod_get_optional(cdev->dev,
>  							      "device-state",
>  							      GPIOD_IN);
> -	if (IS_ERR(tcan4x5x->device_state_gpio))
> +	if (IS_ERR(tcan4x5x->device_state_gpio)) {
>  		tcan4x5x->device_state_gpio =3D NULL;
> +		tcan4x5x_disable_state(cdev);
> +	}
For some reason, this hunk doesn't apply, due to the additional:

>> 	tcan4x5x->power =3D devm_regulator_get_optional(cdev->dev,
>> 						      "vsup");

I've applied the patch manually.

> =20
>  	return 0;
>  }
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--av7eADa9mYDcTsXodHZDp6AFIW6KEoww7--

--N1nesT42QyOxVEMMoQougOQqY8SIbiSL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4IxvgACgkQWsYho5Hk
nSDFkAgAh/d0YN3ZLCS7Edg2Caf0/2aoBAnjAnyPTEMN0T8VxWDaKWme8EOkMSWw
ypXN1WdSb550yQwpGdmZpbMM8wRBancV5IZ3pwjaw9/cNYVzaCxcXTCWP/BUD13Y
W9WW1SatZhHlbvDPP9XBFsxXWh7Fyac7lSAsYu/JberBTtDPrJKzXirrGcDEeh4I
/vCoT3plKv8YAIqFZSjx0CyqGlH5QYQzJnVvYFk40Sp4FMbu8UZ4L4OMQrbL+EtX
m2fEkFZXI6DfpNHxM3/VfM0DYTt7ip6icFjb3qld559TNx5yf1S+y0qwZ76TPO4I
1vMMaaRdn2CC9/nPBf+q65T+se4AAw==
=KyXS
-----END PGP SIGNATURE-----

--N1nesT42QyOxVEMMoQougOQqY8SIbiSL0--
