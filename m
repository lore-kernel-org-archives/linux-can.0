From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Tue, 18 Sep 2012 19:17:09 +0200
Message-ID: <5058AC95.5070406@pengutronix.de>
References: <5058994E.8000501@gaisler.com> <1347986041-5358-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig29B7C744C92D8DEA193DDBD4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42979 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2IRRRU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 13:17:20 -0400
In-Reply-To: <1347986041-5358-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29B7C744C92D8DEA193DDBD4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 06:34 PM, Andreas Larsson wrote:
> One-shot mode correctly refrains from trying to resend frames that
> fail. However, all can frames are echoed back by can_get_echo_skb
> regardless of whether they were transmitted successfully or not. When
> in one-shot mode, sja1000 generates a transmit interrupt both for a
> successful and a failed transmission. It is not possible to
> distinguish between the cases and therefore not possible to refrain
> from echoing back a frame that was not transmitted successfully.

Stupid hardware :/

> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  drivers/net/can/sja1000/sja1000.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja100=
0/sja1000.c
> index 4c4f33d..1a2159e 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)=

>  	struct sja1000_priv *priv =3D netdev_priv(dev);
>  	unsigned char status =3D priv->read_reg(priv, REG_MOD);
>  	int i;
> +	u8 mod;
	u8 mod =3D 0;

Why inside the loop, see below? Better do it here:

	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
		mod |=3D MOD_LOM;

(The compiler would probably move it out of the loop anyway)

> =20
>  	for (i =3D 0; i < 100; i++) {
>  		/* check reset bit */
> @@ -156,7 +157,10 @@ static void set_normal_mode(struct net_device *dev=
)
>  		}
> =20
>  		/* set chip to normal mode */
> -		priv->write_reg(priv, REG_MOD, 0x00);
> +		mod =3D 0;
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +			mod |=3D MOD_LOM;
> +		priv->write_reg(priv, REG_MOD, mod);
>  		udelay(10);
>  		status =3D priv->read_reg(priv, REG_MOD);
>  	}
> @@ -278,6 +282,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
>  	canid_t id;
>  	uint8_t dreg;
>  	int i;
> +	u8 cmd;
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -310,7 +315,10 @@ static netdev_tx_t sja1000_start_xmit(struct sk_bu=
ff *skb,
> =20
>  	can_put_echo_skb(skb, dev, 0);
> =20
> -	sja1000_write_cmdreg(priv, CMD_TR);
> +	cmd =3D CMD_TR;
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		cmd |=3D CMD_AT;
> +	sja1000_write_cmdreg(priv, cmd);
> =20
>  	return NETDEV_TX_OK;
>  }
> @@ -605,7 +613,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv=
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


--------------enig29B7C744C92D8DEA193DDBD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYrJgACgkQjTAFq1RaXHPS5QCcDRG6refDioCuxIrLA4pZ4RZ/
08kAnjjhF7KiQxLQ5u2v9Hmmc5DJY9Fc
=Xhac
-----END PGP SIGNATURE-----

--------------enig29B7C744C92D8DEA193DDBD4--
