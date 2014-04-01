From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: mcp251x: Improve mcp251x_hw_reset()
Date: Tue, 01 Apr 2014 22:47:19 +0200
Message-ID: <533B25D7.8000701@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru> <1396001687-7092-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VdI1FUobThwAjkvStoOUulCfQRWPBuK3T"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49486 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaDAUrV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 16:47:21 -0400
In-Reply-To: <1396001687-7092-2-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VdI1FUobThwAjkvStoOUulCfQRWPBuK3T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
> The MCP251x utilizes an oscillator startup timer (OST), which holds the=

> chip in reset, to insure that the oscillator has stabilized before the
> internal state machine begins to operate. The OST maintains reset for
> the first 128 OSC clock cycles after power up or reset.
> So, this patch removes unnecessary loops and reduce delay for power on
> and reset to the safe value.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/net/can/mcp251x.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index 26879c7..fea41b4 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -214,6 +214,8 @@
> =20
>  #define TX_ECHO_SKB_MAX	1
> =20
> +#define MCP251X_OST_DELAY_MS	(5)
> +
>  #define DEVICE_NAME "mcp251x"
> =20
>  static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
> @@ -625,28 +627,20 @@ static int mcp251x_hw_reset(struct spi_device *sp=
i)
>  {
>  	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
>  	int ret;
> -	unsigned long timeout;
> +
> +	/* Wait for oscillator startup timer after power up */
> +	mdelay(MCP251X_OST_DELAY_MS);
> =20
>  	priv->spi_tx_buf[0] =3D INSTRUCTION_RESET;
> -	ret =3D spi_write(spi, priv->spi_tx_buf, 1);
> -	if (ret) {
> -		dev_err(&spi->dev, "reset failed: ret =3D %d\n", ret);
> -		return -EIO;
> -	}
> +	ret =3D mcp251x_spi_trans(spi, 1);
> +	if (ret)
> +		return ret;
> =20
> -	/* Wait for reset to finish */
> -	timeout =3D jiffies + HZ;
> -	mdelay(10);
> -	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK)
> -	       !=3D CANCTRL_REQOP_CONF) {
> -		schedule();
> -		if (time_after(jiffies, timeout)) {
> -			dev_err(&spi->dev, "MCP251x didn't"
> -				" enter in conf mode after reset\n");
> -			return -EBUSY;
> -		}
> -	}
> -	return 0;
> +	/* Wait for oscillator startup timer after reset */
> +	mdelay(MCP251X_OST_DELAY_MS);
> +=09
> +	return ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) =3D=3D
> +		CANCTRL_REQOP_CONF) ? 0 : -ENODEV;

I've converted this into a more standard/readable:

+       reg =3D mcp251x_read_reg(spi, CANSTAT);
+       if ((reg & CANCTRL_REQOP_MASK) !=3D CANCTRL_REQOP_CONF)
+               return -ENODEV;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VdI1FUobThwAjkvStoOUulCfQRWPBuK3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7JdcACgkQjTAFq1RaXHPOmQCdGYNXqBJXbbVJGzjL965SohUw
+bkAn1ReukOvowv0X+ewDjbQN/2UTFgC
=4Sc1
-----END PGP SIGNATURE-----

--VdI1FUobThwAjkvStoOUulCfQRWPBuK3T--
