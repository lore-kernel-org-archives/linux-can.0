From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: sja1000: Add support for CAN_CTRLMODE_LOOPBACK
Date: Thu, 10 Jul 2014 16:25:49 +0200
Message-ID: <53BEA26D.2040007@pengutronix.de>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="51wrLMDIsARLE5gQt5ALxpqS4Vse6eO4s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbaGJOZw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Jul 2014 10:25:52 -0400
In-Reply-To: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--51wrLMDIsARLE5gQt5ALxpqS4Vse6eO4s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2014 09:31 PM, Nikita Edward Baruzdin wrote:
> This adds support for hardware loopback in SJA1000 by utilising its sel=
f
> reception request (SRR) feature. Upon SRR the message is transmitted an=
d
> received simultaneously, meaning you can't have hardware loopback
> without actually sending a message to the CAN bus in case of SJA1000.
>=20
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>

Looks good, coding style nitpick inline...

> ---
>  drivers/net/can/sja1000/sja1000.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja100=
0/sja1000.c
> index f31499a..c480bce 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -278,6 +278,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
>  	uint8_t dlc;
>  	canid_t id;
>  	uint8_t dreg;
> +	u8 cmd_reg_val =3D 0x00;
>  	int i;
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
> @@ -312,9 +313,14 @@ static netdev_tx_t sja1000_start_xmit(struct sk_bu=
ff *skb,
>  	can_put_echo_skb(skb, dev, 0);
> =20
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> -		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
> +		cmd_reg_val |=3D CMD_AT;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		cmd_reg_val |=3D CMD_SRR;
>  	else
> -		sja1000_write_cmdreg(priv, CMD_TR);
> +		cmd_reg_val |=3D CMD_TR;
> +
> +	sja1000_write_cmdreg(priv, cmd_reg_val);
> =20
>  	return NETDEV_TX_OK;
>  }
> @@ -622,9 +628,11 @@ struct net_device *alloc_sja1000dev(int sizeof_pri=
v)
>  	priv->can.do_set_bittiming =3D sja1000_set_bittiming;
>  	priv->can.do_set_mode =3D sja1000_set_mode;
>  	priv->can.do_get_berr_counter =3D sja1000_get_berr_counter;
> -	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> -		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
> -		CAN_CTRLMODE_ONE_SHOT;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK
> +				     | CAN_CTRLMODE_LISTENONLY
> +				     | CAN_CTRLMODE_3_SAMPLES
> +				     | CAN_CTRLMODE_ONE_SHOT
> +				     | CAN_CTRLMODE_BERR_REPORTING;

Please keep the '|' at the end of the lines.

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


--51wrLMDIsARLE5gQt5ALxpqS4Vse6eO4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO+om0ACgkQjTAFq1RaXHOTaQCgkq0mw5hyIYD6up6vAwqEraYS
GPIAniqqtOFr78kZbk4U2R52qfwtEiH9
=NWDO
-----END PGP SIGNATURE-----

--51wrLMDIsARLE5gQt5ALxpqS4Vse6eO4s--
