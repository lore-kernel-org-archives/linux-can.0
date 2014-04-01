From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/4] can: mcp251x: Improve mcp251x_hw_probe()
Date: Tue, 01 Apr 2014 22:46:02 +0200
Message-ID: <533B258A.3030801@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru> <1396001687-7092-3-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M4OGbL6C4v1boMwOiR0Ep0CgSKHBAxVLm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaDAUqK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 16:46:10 -0400
In-Reply-To: <1396001687-7092-3-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M4OGbL6C4v1boMwOiR0Ep0CgSKHBAxVLm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
> This patch adds check for mcp251x_hw_reset() result on startup and
> removes unnecessary checking for CANSTAT register since this value
> is being checked in mcp251x_hw_reset().
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/net/can/mcp251x.c | 41 ++++++++++++++++++---------------------=
--
>  1 file changed, 18 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index fea41b4..f4786c8 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -645,23 +645,19 @@ static int mcp251x_hw_reset(struct spi_device *sp=
i)
> =20
>  static int mcp251x_hw_probe(struct spi_device *spi)
>  {
> -	int st1, st2;
> +	u8 ctrl;
> +	int ret;
> =20
> -	mcp251x_hw_reset(spi);
> +	ret =3D mcp251x_hw_reset(spi);
> +	if (ret)
> +		return ret;
> =20
> -	/*
> -	 * Please note that these are "magic values" based on after
> -	 * reset defaults taken from data sheet which allows us to see
> -	 * if we really have a chip on the bus (we avoid common all
> -	 * zeroes or all ones situations)
> -	 */
> -	st1 =3D mcp251x_read_reg(spi, CANSTAT) & 0xEE;
> -	st2 =3D mcp251x_read_reg(spi, CANCTRL) & 0x17;
> +	ctrl =3D mcp251x_read_reg(spi, CANCTRL);
> =20
> -	dev_dbg(&spi->dev, "CANSTAT 0x%02x CANCTRL 0x%02x\n", st1, st2);
> +	dev_dbg(&spi->dev, "CANCTRL 0x%02x\n", ctrl);
> =20
> -	/* Check for power up default values */
> -	return (st1 =3D=3D 0x80 && st2 =3D=3D 0x07) ? 1 : 0;
> +	/* Check for power up default value */
> +	return ((ctrl & 0x17) =3D=3D 0x07) ? 0 : -ENODEV;

I've converted this into:

+       if ((ctrl & 0x17) !=3D 0x07)
+               return -ENODEV;
+
+       return 0;

=2E..which is more readable, IMHO.

>  }
> =20
>  static int mcp251x_power_enable(struct regulator *reg, int enable)
> @@ -1138,19 +1134,18 @@ static int mcp251x_can_probe(struct spi_device =
*spi)
>  	SET_NETDEV_DEV(net, &spi->dev);
> =20
>  	/* Here is OK to not lock the MCP, no one knows about it yet */
> -	if (!mcp251x_hw_probe(spi)) {
> -		ret =3D -ENODEV;
> -		goto error_probe;
> -	}
> -	mcp251x_hw_sleep(spi);
> +	ret =3D mcp251x_hw_probe(spi);
> +	if (!ret) {

I don't like the idea due to readability, that the non-error path is
inside the if () { }. I've fixed this, the diff is even smaller.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M4OGbL6C4v1boMwOiR0Ep0CgSKHBAxVLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7JYoACgkQjTAFq1RaXHNYPwCgjvO+gMb/o2qMo7672SgUOJc4
SjQAni/K6kEqibZzUHFRFokb9CkJaFLm
=mqCf
-----END PGP SIGNATURE-----

--M4OGbL6C4v1boMwOiR0Ep0CgSKHBAxVLm--
