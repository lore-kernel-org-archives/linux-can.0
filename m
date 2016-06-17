From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
Date: Fri, 17 Jun 2016 11:22:12 +0200
Message-ID: <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xetiB6ei3TB4WLmG6TQK8tMBMaCTvP4FA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38034 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754038AbcFQJWU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:22:20 -0400
In-Reply-To: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xetiB6ei3TB4WLmG6TQK8tMBMaCTvP4FA
Content-Type: multipart/mixed; boundary="FPSjQhLpkHENsQgE8JKpa1fVTCufjqV7s"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org
Message-ID: <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
In-Reply-To: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>

--FPSjQhLpkHENsQgE8JKpa1fVTCufjqV7s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/29/2016 03:59 AM, Ed Spiridonov wrote:
> Print error message if mcp251x_hw_probe() fails (e.g. MCP2515 isn't con=
nected or other wiring issue).
> Print information message if mcp251x_can_probe() is successful.

Can I add your S-o-b to the patch?

> ---
>  drivers/net/can/spi/mcp251x.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> index cf36d26..49453f7 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1145,8 +1145,10 @@ static int mcp251x_can_probe(struct spi_device *=
spi)
> =20
>  	/* Here is OK to not lock the MCP, no one knows about it yet */
>  	ret =3D mcp251x_hw_probe(spi);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&spi->dev, "hw_probe failed, err=3D%d (wrong wiring?)\n", -r=
et);
>  		goto error_probe;
> +	}
> =20
>  	mcp251x_hw_sleep(spi);
> =20
> @@ -1156,6 +1158,8 @@ static int mcp251x_can_probe(struct spi_device *s=
pi)
> =20
>  	devm_can_led_init(net);
> =20
> +	netdev_info(net, "successfully initialized.\n");

I'll remove this hunk, as we try to make the CAN devices as silent as
possible in case of no errors.

> +
>  	return 0;
> =20
>  error_probe:
>=20

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FPSjQhLpkHENsQgE8JKpa1fVTCufjqV7s--

--xetiB6ei3TB4WLmG6TQK8tMBMaCTvP4FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY8FEAAoJED07qiWsqSVqAzEH/A0kKyjI6gija/O98Ysa2icS
U3xF9GH9Q1iRlg4Yv4Gt0AqCP+yo08D4WywtH36IgSC4GCiWKRTL+sUARXr/INEp
kJOUPmigH84cPiuWm7lCAAM8qH8BcxWAsMhh2jGzb+q7P8mnWDMfsFOxW+q3yPLR
1OCxlrCUyUk7HlbvcGEQSf/WtpjeLRKvyvUCcnxJd/KUqVZBCa9fa7KJtM3tRVoZ
Gjg09UHiypJZUnjWKQ3S2ksH3KkZHeuzJkwQ/zBVC54ZHV6zF7CyFk+6cUMK4swb
bgFCiZq5E1dqXkyZQ9RAamxqP2R1GGprHj9p2oYng+iQG55SXMUmDbFLCjYi4fA=
=ezJC
-----END PGP SIGNATURE-----

--xetiB6ei3TB4WLmG6TQK8tMBMaCTvP4FA--
