From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: mcp251x: Check return value of spi_setup()
Date: Tue, 01 Apr 2014 13:56:41 +0200
Message-ID: <533AA979.9060201@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="coeBJ8xKnwttvQdV2e7OCvDRdevsORJR8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbaDAL4y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 07:56:54 -0400
In-Reply-To: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--coeBJ8xKnwttvQdV2e7OCvDRdevsORJR8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
> This patch moves setup of SPI bus a bit earlier and adds check
> for spi_setup() result to be sure SPI bus is communicated with the
> device properly.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/net/can/mcp251x.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index 28c11f8..26879c7 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -1032,8 +1032,8 @@ static int mcp251x_can_probe(struct spi_device *s=
pi)
>  	struct mcp251x_platform_data *pdata =3D dev_get_platdata(&spi->dev);
>  	struct net_device *net;
>  	struct mcp251x_priv *priv;
> -	int freq, ret =3D -ENODEV;
>  	struct clk *clk;
> +	int freq, ret;
> =20
>  	clk =3D devm_clk_get(&spi->dev, NULL);
>  	if (IS_ERR(clk)) {
> @@ -1076,6 +1076,18 @@ static int mcp251x_can_probe(struct spi_device *=
spi)
>  	priv->net =3D net;
>  	priv->clk =3D clk;
> =20
> +	spi_set_drvdata(spi, priv);
> +
> +	/* Configure the SPI bus */
> +	spi->bits_per_word =3D 8;
> +	if (mcp251x_is_2510(spi))
> +		spi->max_speed_hz =3D spi->max_speed_hz ? : 5 * 1000 * 1000;
> +	else
> +		spi->max_speed_hz =3D spi->max_speed_hz ? : 10 * 1000 * 1000;
> +	ret =3D spi_setup(spi);
> +	if (ret)
> +		return ret;

You're omitting the error handling here. I'll send a v2.

> +
>  	priv->power =3D devm_regulator_get(&spi->dev, "vdd");
>  	priv->transceiver =3D devm_regulator_get(&spi->dev, "xceiver");
>  	if ((PTR_ERR(priv->power) =3D=3D -EPROBE_DEFER) ||
> @@ -1088,8 +1100,6 @@ static int mcp251x_can_probe(struct spi_device *s=
pi)
>  	if (ret)
>  		goto out_clk;
> =20
> -	spi_set_drvdata(spi, priv);
> -
>  	priv->spi =3D spi;
>  	mutex_init(&priv->mcp_lock);
> =20
> @@ -1134,15 +1144,6 @@ static int mcp251x_can_probe(struct spi_device *=
spi)
> =20
>  	SET_NETDEV_DEV(net, &spi->dev);
> =20
> -	/* Configure the SPI bus */
> -	spi->mode =3D spi->mode ? : SPI_MODE_0;
> -	if (mcp251x_is_2510(spi))
> -		spi->max_speed_hz =3D spi->max_speed_hz ? : 5 * 1000 * 1000;
> -	else
> -		spi->max_speed_hz =3D spi->max_speed_hz ? : 10 * 1000 * 1000;
> -	spi->bits_per_word =3D 8;
> -	spi_setup(spi);
> -
>  	/* Here is OK to not lock the MCP, no one knows about it yet */
>  	if (!mcp251x_hw_probe(spi)) {
>  		ret =3D -ENODEV;
>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--coeBJ8xKnwttvQdV2e7OCvDRdevsORJR8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM6qXkACgkQjTAFq1RaXHPJmQCgkOx4qOfuEZNsDmiYSiVemlHJ
fssAnAqTWg/3EotmWR//imwdrLC7SV7h
=xtwl
-----END PGP SIGNATURE-----

--coeBJ8xKnwttvQdV2e7OCvDRdevsORJR8--
