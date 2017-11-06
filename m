From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can: sun4i: fix overrun
Date: Mon, 6 Nov 2017 17:09:36 +0100
Message-ID: <20e91f5b-760a-55b1-b9c8-4731a92aa4e5@pengutronix.de>
References: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
 <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PlURFSjFJ2FqGB3DTX8O9ixKhA5LQKD6x"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34789 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753299AbdKFQJl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2017 11:09:41 -0500
In-Reply-To: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PlURFSjFJ2FqGB3DTX8O9ixKhA5LQKD6x
Content-Type: multipart/mixed; boundary="cc2OJC1a857sqtH22TFcQLUsDCEgn41Um";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org
Message-ID: <20e91f5b-760a-55b1-b9c8-4731a92aa4e5@pengutronix.de>
Subject: Re: [PATCH v4] can: sun4i: fix overrun
References: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
 <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
In-Reply-To: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>

--cc2OJC1a857sqtH22TFcQLUsDCEgn41Um
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 04:57 PM, GBert wrote:
> From: cb2begq <info@gerhard-bertelsmann.de>
>=20
> SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drai=
ned
> fast enough (overrun) it's getting mangled. Already received frames are=

> dropped - the data can't be restored.
>=20
> V4: add error handling
> V3: fix compilation
> V2: no duplicate error reporting
>=20
>=20
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
>=20
> ---
>  drivers/net/can/sun4i_can.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index b0c8085..1d2d12e 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -539,6 +539,15 @@ static int sun4i_can_err(struct net_device *dev, u=
8 isrc, u8 status)
>  		}
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;
> +
> +		/* reset the CAN IP by entering reset mode */
> +		err =3D set_reset_mode(dev);
> +		if (err < 0)
> +			return err;
> +		err =3D set_normal_mode(dev);
> +		if (err < 0)
> +			return err;

If an skb has been allocated it's lost here.

However, in which state is the controller if the set_reset or set_normal
doesn't work? Maybe ignore the error altogether and just carry on? If
so, add ad comment stating that the only error can be a timeout and we
ignore the errors in that case.

See the caller of sun4i_can_err() which assumes the only error will be a
ENOMEM due to no skb.

> +
>  		/* clear bit */
>  		sun4i_can_write_cmdreg(priv, SUN4I_CMD_CLEAR_OR_FLAG);
>  	}
> @@ -653,8 +663,9 @@ static irqreturn_t sun4i_can_interrupt(int irq, voi=
d *dev_id)
>  			netif_wake_queue(dev);
>  			can_led_event(dev, CAN_LED_EVENT_TX);
>  		}
> -		if (isrc & SUN4I_INT_RBUF_VLD) {
> -			/* receive interrupt */
> +		if ((isrc & SUN4I_INT_RBUF_VLD) &&
> +		    !(isrc & SUN4I_INT_DATA_OR)) {
> +			/* receive interrupt - don't read if overrun occurred */
>  			while (status & SUN4I_STA_RBUF_RDY) {
>  				/* RX buffer is not empty */
>  				sun4i_can_rx(dev);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cc2OJC1a857sqtH22TFcQLUsDCEgn41Um--

--PlURFSjFJ2FqGB3DTX8O9ixKhA5LQKD6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloAiUAACgkQHv7KIOw4
HPbwJAf9FaIxMfIWX5Oixo8xPvBhN5KtL3Zeie1kyO3Fz3B6ySsqv1zXFYtvWD4X
BN64d/vjanyAc4Hug/xHD4u8GH/2RLdxGXqQ5pHIZ+OPgIi8258makhjlUwVwr74
+eaUkamEV8V984/JC0YkYfUHSZ+0ExFFvkNtT75/zGJtB+Xq7pwgDcOoF5otolLO
2F6aSwmIYJIyu7XGfS08oRco335SbzUue2VKHJlU8ZU8eW/oe8VMuYAqtKqsE49i
HJUev6dHQzASwz4FydNNu13bItxEb7r1aIZlUWzgMSHxBDo0hX0mZtkvChk5svnA
R2hsSHSZQLeNoeDo9kh1tvQ+UGfIvw==
=FlIp
-----END PGP SIGNATURE-----

--PlURFSjFJ2FqGB3DTX8O9ixKhA5LQKD6x--
