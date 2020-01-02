From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Thu, 2 Jan 2020 12:11:52 +0100
Message-ID: <32ea95b2-25fe-8c26-cc90-9f9264e0d8f5@pengutronix.de>
References: <20191210163204.28225-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Di8rHTXB2rcggZJiDjV7RER7SlJVMpnFs"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Di8rHTXB2rcggZJiDjV7RER7SlJVMpnFs
Content-Type: multipart/mixed; boundary="q6xRA7IIHSCP9XlJg1YgufvurNBMMGnOB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <32ea95b2-25fe-8c26-cc90-9f9264e0d8f5@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
References: <20191210163204.28225-1-dmurphy@ti.com>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>

--q6xRA7IIHSCP9XlJg1YgufvurNBMMGnOB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 5:32 PM, Dan Murphy wrote:
> The parse config function now performs action on the device either
> reading or writing and a reset.  If the regulator is managed it needs
> to be turned on.  So turn on the regulator if available if the parsing
> fails then turn off the regulator.
>=20
> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO"=
)
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v2 - Added error handling and moved regulator_get to probe
>=20
>  drivers/net/can/m_can/tcan4x5x.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/t=
can4x5x.c
> index 4e1789ea2bc3..ddf7db498241 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -374,11 +374,6 @@ static int tcan4x5x_parse_config(struct m_can_clas=
sdev *cdev)
>  	if (IS_ERR(tcan4x5x->device_state_gpio))
>  		tcan4x5x->device_state_gpio =3D NULL;
> =20
> -	tcan4x5x->power =3D devm_regulator_get_optional(cdev->dev,
> -						      "vsup");
> -	if (PTR_ERR(tcan4x5x->power) =3D=3D -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> -
>  	return 0;
>  }
> =20
> @@ -412,6 +407,12 @@ static int tcan4x5x_can_probe(struct spi_device *s=
pi)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	priv->power =3D devm_regulator_get_optional(&spi->dev, "vsup");
> +	if (PTR_ERR(priv->power) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	else
> +		priv->power =3D NULL;
> +

BTW: you are leaking the netdev allocated with m_can_class_allocate_dev()=
=2E

In order to fix this:

- introduce a m_can_class_free_dev() function that calls the
  free_candev().
- fix error path in tcan4x5x_can_probe() and m_can_plat_probe() by
  adding the missing m_can_class_free_dev()
- remove the free_candev() from the error path in m_can_class_register()
  it makes no sense that this function free a ressource it has not
  allocated
- remove the free_candev() from m_can_class_unregister()
  it makes no sense that this function free a ressource it has not
  allocated
- add needed m_can_class_free_dev() to tcan4x5x_can_remove() and
  m_can_plat_remove()

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--q6xRA7IIHSCP9XlJg1YgufvurNBMMGnOB--

--Di8rHTXB2rcggZJiDjV7RER7SlJVMpnFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4Nz/gACgkQWsYho5Hk
nSCpKwf/ZHsmy0A40kM8GPLEqFNrKr1+0fshcdbJnyiDzKvAPXuix0GsWQ3vDCaJ
WhfJLCKsUlNYokayw1MCv1jRj20QfkjXLeVnf8ygr8uU+BSgFCk76+8ZUpi0iqOh
6329aYUA6W0+aJ57D9wr1SfcmOMF9CWIXTpfX7fKLbjpa0S3FTwIgubYDeX1t3hT
XA82dejocKG8pTzWnPEjZqTqKQ2MKFzphdwRB2Skvfmoe9Ke3IS98h/BKw6ciosz
dAJ5RBidNUao6NFVqj4IBJSlBFYtuPj9TAn7p0uNXxCUNYa5Mnfqc4MFIgGxkEKx
rrsHl3tnEfSNRr0+J5kt+ltf9ZbFaw==
=/g3H
-----END PGP SIGNATURE-----

--Di8rHTXB2rcggZJiDjV7RER7SlJVMpnFs--
