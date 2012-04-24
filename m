From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: c_can: fix an interrupt thrash issue with c_can
 driver
Date: Tue, 24 Apr 2012 10:01:27 +0200
Message-ID: <4F965DD7.1000804@pengutronix.de>
References: <1334915886-30076-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig583790F167911105F02FCF44"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48892 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab2DXIBg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 04:01:36 -0400
In-Reply-To: <1334915886-30076-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig583790F167911105F02FCF44
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/20/2012 11:58 AM, AnilKumar Ch wrote:
> This patch fixes an interrupt thrash issue with c_can driver.
>=20
> In c_can_isr() function interrupts are disabled and enabled only in
> c_can_poll() function. c_can_isr() & c_can_poll() both read the
> irqstatus flag. However, irqstatus is always read as 0 in c_can_poll()
> because all C_CAN interrupts are disabled in c_can_isr(). This causes
> all interrupts to be re-enabled in c_can_poll() which in turn causes
> another interrupt since the event is not really handled. This keeps
> happening causing a flood of interrupts.

Do both c_can and d_can behave the same way?

> To fix this, read the irqstatus register in isr and use the same cached=

> value in the poll function.

More comments inline:

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can.c |   19 ++++++++-----------
>  drivers/net/can/c_can/c_can.h |    1 +
>  2 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 9ac28df..09fcc50 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -946,18 +946,16 @@ static int c_can_handle_bus_err(struct net_device=
 *dev,
> =20
>  static int c_can_poll(struct napi_struct *napi, int quota)
>  {
> -	u16 irqstatus;
>  	int lec_type =3D 0;
>  	int work_done =3D 0;
>  	struct net_device *dev =3D napi->dev;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	irqstatus =3D priv->read_reg(priv, &priv->regs->interrupt);

I suggest:
	irqstatus =3D priv->irqstatus;

This would be a quite small patch, because you can keep using irqstatus
below.

> -	if (!irqstatus)
> +	if (!priv->irqstatus)
>  		goto end;
> =20
>  	/* status events have the highest priority */
> -	if (irqstatus =3D=3D STATUS_INTERRUPT) {
> +	if (priv->irqstatus =3D=3D STATUS_INTERRUPT) {
>  		priv->current_status =3D priv->read_reg(priv,
>  					&priv->regs->status);
> =20
> @@ -1008,12 +1006,12 @@ static int c_can_poll(struct napi_struct *napi,=
 int quota)
>  		lec_type =3D c_can_has_and_handle_berr(priv);
>  		if (lec_type)
>  			work_done +=3D c_can_handle_bus_err(dev, lec_type);
> -	} else if ((irqstatus >=3D C_CAN_MSG_OBJ_RX_FIRST) &&
> -			(irqstatus <=3D C_CAN_MSG_OBJ_RX_LAST)) {
> +	} else if ((priv->irqstatus >=3D C_CAN_MSG_OBJ_RX_FIRST) &&
> +			(priv->irqstatus <=3D C_CAN_MSG_OBJ_RX_LAST)) {
>  		/* handle events corresponding to receive message objects */
>  		work_done +=3D c_can_do_rx_poll(dev, (quota - work_done));
> -	} else if ((irqstatus >=3D C_CAN_MSG_OBJ_TX_FIRST) &&
> -			(irqstatus <=3D C_CAN_MSG_OBJ_TX_LAST)) {
> +	} else if ((priv->irqstatus >=3D C_CAN_MSG_OBJ_TX_FIRST) &&
> +			(priv->irqstatus <=3D C_CAN_MSG_OBJ_TX_LAST)) {
>  		/* handle events corresponding to transmit message objects */
>  		c_can_do_tx(dev);
>  	}
> @@ -1030,12 +1028,11 @@ end:
> =20
>  static irqreturn_t c_can_isr(int irq, void *dev_id)
>  {
> -	u16 irqstatus;
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	irqstatus =3D priv->read_reg(priv, &priv->regs->interrupt);
> -	if (!irqstatus)
> +	priv->irqstatus =3D priv->read_reg(priv, &priv->regs->interrupt);
> +	if (!priv->irqstatus)
>  		return IRQ_NONE;
> =20
>  	/* disable all interrupts and schedule the NAPI */
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 9b7fbef..5f32d34 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -76,6 +76,7 @@ struct c_can_priv {
>  	unsigned int tx_next;
>  	unsigned int tx_echo;
>  	void *priv;		/* for board-specific data */
> +	u16 irqstatus;
>  };
> =20
>  struct net_device *alloc_c_can_dev(void);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig583790F167911105F02FCF44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+WXdoACgkQjTAFq1RaXHNSQwCglUjF/TTx2NfR9XpLloeX8itE
Mt4AnjcHpZzLy+jOH1J9sISJkO4WqHq9
=a75w
-----END PGP SIGNATURE-----

--------------enig583790F167911105F02FCF44--
