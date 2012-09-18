From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000: Add support for listen-only mode and one-shot
 mode
Date: Tue, 18 Sep 2012 15:46:46 +0200
Message-ID: <50587B46.7060506@pengutronix.de>
References: <1347897482-26379-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig43C3B781774DF9C1AB863796"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55671 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2IRNre (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:47:34 -0400
In-Reply-To: <1347897482-26379-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43C3B781774DF9C1AB863796
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/17/2012 05:58 PM, Andreas Larsson wrote:
> Packages that fails to be transmitted in one-shot mode are never the
> less echoed back as sja1000 does not give any indication when a single
> transmission has failed.

Uhh... can any of the SJA1000 gurus comment to this?

Some write-more-readable-code comments inline :)

> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  drivers/net/can/sja1000/sja1000.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja100=
0/sja1000.c
> index 4c4f33d..cc771d9 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)=

>  	struct sja1000_priv *priv =3D netdev_priv(dev);
>  	unsigned char status =3D priv->read_reg(priv, REG_MOD);
>  	int i;
> +	u8 normal =3D priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ? MOD_LOM =
: 0;

What about a more readable:
	u8 normal =3D 0;

	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
		normal =3D MOD_LOM;

> =20
>  	for (i =3D 0; i < 100; i++) {
>  		/* check reset bit */
> @@ -156,7 +157,7 @@ static void set_normal_mode(struct net_device *dev)=

>  		}
> =20
>  		/* set chip to normal mode */
> -		priv->write_reg(priv, REG_MOD, 0x00);
> +		priv->write_reg(priv, REG_MOD, normal);
>  		udelay(10);
>  		status =3D priv->read_reg(priv, REG_MOD);
>  	}
> @@ -278,6 +279,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
>  	canid_t id;
>  	uint8_t dreg;
>  	int i;
> +	u8 oneshot;
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -310,7 +312,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
> =20
>  	can_put_echo_skb(skb, dev, 0);
> =20
> -	sja1000_write_cmdreg(priv, CMD_TR);
> +	oneshot =3D (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT) ? CMD_AT : 0=
;
> +	sja1000_write_cmdreg(priv, CMD_TR | oneshot);

something simmilar here, too

>  	return NETDEV_TX_OK;
>  }
> @@ -605,7 +608,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv=
)
>  	priv->can.do_set_mode =3D sja1000_set_mode;
>  	priv->can.do_get_berr_counter =3D sja1000_get_berr_counter;
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> -		CAN_CTRLMODE_BERR_REPORTING;
> +		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
> +		CAN_CTRLMODE_ONE_SHOT;
> =20
>  	spin_lock_init(&priv->cmdreg_lock);
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig43C3B781774DF9C1AB863796
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYe0YACgkQjTAFq1RaXHMZnQCffMqGiaFTv83WwXXQTFjlWXOt
grAAn2hW66+VN1os1hhWaIdue8vZFAth
=IR5r
-----END PGP SIGNATURE-----

--------------enig43C3B781774DF9C1AB863796--
