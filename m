From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: sun4i: fix overrun
Date: Thu, 19 Oct 2017 14:10:53 +0200
Message-ID: <5511583c-37ac-c6b7-f88d-1fd740fae3f5@pengutronix.de>
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
 <4bd237f72c933953238738b1d12d11ff16a0b6b0.1502971879.git.info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TKb9vLXODggd54lgOuN3KAR3pwipeAmLp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57987 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752704AbdJSMK6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 08:10:58 -0400
In-Reply-To: <4bd237f72c933953238738b1d12d11ff16a0b6b0.1502971879.git.info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TKb9vLXODggd54lgOuN3KAR3pwipeAmLp
Content-Type: multipart/mixed; boundary="Oq9AhsiPf0LIUJEicdqgR6DJMmjiGjDeF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org
Message-ID: <5511583c-37ac-c6b7-f88d-1fd740fae3f5@pengutronix.de>
Subject: Re: [PATCH 1/2] can: sun4i: fix overrun
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
 <4bd237f72c933953238738b1d12d11ff16a0b6b0.1502971879.git.info@gerhard-bertelsmann.de>
In-Reply-To: <4bd237f72c933953238738b1d12d11ff16a0b6b0.1502971879.git.info@gerhard-bertelsmann.de>

--Oq9AhsiPf0LIUJEicdqgR6DJMmjiGjDeF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:59 PM, GBert wrote:
> From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
>=20
> SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drai=
ned
> fast enough (overrun) it's getting mangled.

What does that mean?

> The fix resets the buffer for faster recovery - unrecoverable data in
> the buffer will be ignored
So already received CAN frames are dropped?

> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> ---
>  drivers/net/can/sun4i_can.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git drivers/net/can/sun4i_can.c drivers/net/can/sun4i_can.c
> index 68ef0a4..0d673ff 100644
> --- drivers/net/can/sun4i_can.c
> +++ drivers/net/can/sun4i_can.c
> @@ -531,6 +531,7 @@ static int sun4i_can_err(struct net_device *dev, u8=
 isrc, u8 status)
>  	}
> =20
>  	if (isrc & SUN4I_INT_DATA_OR) {
> +		int err;
>  		/* data overrun interrupt */
>  		netdev_dbg(dev, "data overrun interrupt\n");
>  		if (likely(skb)) {
> @@ -539,6 +540,15 @@ static int sun4i_can_err(struct net_device *dev, u=
8 isrc, u8 status)
>  		}
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;
> +
> +		/* reset the CAN IP by entering reset mode */
> +		err =3D set_reset_mode(dev);
> +		if (err)
> +			netdev_err(dev, "could not enter reset mode\n");

No need to print an error here set_{reset,normal}_mode() already do this.=


> +		err =3D set_normal_mode(dev);
> +		if (err)
> +			netdev_err(dev, "could not enter normal mode\n");
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


--Oq9AhsiPf0LIUJEicdqgR6DJMmjiGjDeF--

--TKb9vLXODggd54lgOuN3KAR3pwipeAmLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnolk0ACgkQHv7KIOw4
HPZSDwf/d5hhg61ujYQ5Vs0Tv5Mu8JefYi1MPQJXcnneFmq3SOOOokKMSzg2U3bs
+5i3cy1wH/XaHyYl5WUMipAs3dsHyS9h/K1bbQjvL44y3aVjGGrl9BHdtCYiNOdY
l0DIFlMAni6BmAw9wiq8XmQy7Sjqo6hQX1YxgRHKhRUwPkL2Ru/u/F7FJvEKFqXK
ck4snNgAJ67SWIpiaoc3TjYHpYWF+X06yiOU108XOu8XCg2Cea+X5mT7LKtxYPDW
Kr+ieE1RB5X6WzG5UnOVIFZGRo9mCKy+APS6qvaAMpVRJAtMrLHzur60s5aIIxi+
rhIwSEqAhd0mwrN89E4GlWO8+FT8eA==
=4Ogv
-----END PGP SIGNATURE-----

--TKb9vLXODggd54lgOuN3KAR3pwipeAmLp--
