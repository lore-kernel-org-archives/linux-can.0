From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: at91_can: prepare and unprepare the clock
Date: Wed, 17 Sep 2014 11:12:55 +0200
Message-ID: <54195097.1000106@pengutronix.de>
References: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mL6KirqTl3M2prwAuQ2UUAsLmloWb9v3n"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41177 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbaIQJNH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Sep 2014 05:13:07 -0400
In-Reply-To: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Dueck <davidcdueck@googlemail.com>, linux-arm-kernel@lists.infradead.org
Cc: wg@grandegger.com, nicolas.ferre@atmel.com, Anthony Harivel <anthony.harivel@emtrion.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mL6KirqTl3M2prwAuQ2UUAsLmloWb9v3n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2014 11:05 AM, David Dueck wrote:
> This prevents a warning.

Which warning?

Can you please check the return value of clock_prepare_enbale().

Marc

BTW: Please add linux-can@vger.kernel.org on Cc for CAN related patches.

> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
> ---
>  drivers/net/can/at91_can.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index f07fa89..7dcb790 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1123,7 +1123,7 @@ static int at91_open(struct net_device *dev)
>  	struct at91_priv *priv =3D netdev_priv(dev);
>  	int err;
> =20
> -	clk_enable(priv->clk);
> +	clk_prepare_enable(priv->clk);
> =20
>  	/* check or determine and set bittime */
>  	err =3D open_candev(dev);
> @@ -1149,7 +1149,7 @@ static int at91_open(struct net_device *dev)
>   out_close:
>  	close_candev(dev);
>   out:
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
> =20
>  	return err;
>  }
> @@ -1166,7 +1166,7 @@ static int at91_close(struct net_device *dev)
>  	at91_chip_stop(dev, CAN_STATE_STOPPED);
> =20
>  	free_irq(dev->irq, dev);
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
> =20
>  	close_candev(dev);
> =20
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--mL6KirqTl3M2prwAuQ2UUAsLmloWb9v3n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQZUJcACgkQjTAFq1RaXHPwpwCeKxHK8ONv51rs3kJGoU0DFd9m
uhoAn2B+ZuYjt7ZB8LT61U6mgGflhWeY
=ihvm
-----END PGP SIGNATURE-----

--mL6KirqTl3M2prwAuQ2UUAsLmloWb9v3n--
