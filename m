From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5] net: can: flexcan: provide propper return code in
 ISR
Date: Sat, 26 Jul 2014 00:31:11 +0200
Message-ID: <53D2DAAF.1080406@pengutronix.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tdl5MUoLcKIl226rN2dBqCMOQ1kVsurLl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32794 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaGYWbX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 18:31:23 -0400
In-Reply-To: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tdl5MUoLcKIl226rN2dBqCMOQ1kVsurLl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 08:16 PM, Matthias Klein wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> flexcan_irq() always returns IRQ_HANDLED no matter if it actually did
> something or not. If the CAN interface is brought up without BERR
> reporting on a SoC which has the FLEXCAN_HAS_BROKEN_ERR_STATE feature
> then ERR reporting is activated but not really handled. That means on a=
n
> open bus one receives a lot of STF_ERR and the only thing that happens
> is that the number of interrupts is incremented.

Yes....although the interrupt is ack'ed.

> This patch ensures that in such a case the core has a chance to detect
> such (or similar) misbehavior and disable the interrupt line.

The problem is, without the enabled bus errors, you have no chance to
detect the warning interrupt, as it is not connected on some SoCs.

However, the series berr_limit addresses the problem, too.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
> ---
>  drivers/net/can/flexcan.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e381142..f677b49 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -641,6 +641,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->base;
>  	u32 reg_iflag1, reg_esr;
> +	int worked =3D 0;
> =20
>  	reg_iflag1 =3D flexcan_read(&regs->iflag1);
>  	reg_esr =3D flexcan_read(&regs->esr);
> @@ -667,6 +668,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
>  		       &regs->ctrl);
>  		napi_schedule(&priv->napi);
> +		worked =3D 1;
>  	}
> =20
>  	/* FIFO overflow */
> @@ -674,6 +676,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
>  		dev->stats.rx_over_errors++;
>  		dev->stats.rx_errors++;
> +		worked =3D 1;
>  	}
> =20
>  	/* transmission complete interrupt */
> @@ -683,9 +686,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>  		can_led_event(dev, CAN_LED_EVENT_TX);
>  		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
>  		netif_wake_queue(dev);
> +		worked =3D 1;
>  	}
> -
> -	return IRQ_HANDLED;
> +	if (worked)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
>  }
> =20
>  static void flexcan_set_bittiming(struct net_device *dev)
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tdl5MUoLcKIl226rN2dBqCMOQ1kVsurLl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPS2q8ACgkQjTAFq1RaXHMaSwCePYPcto2G5pm6Qn3Jfzx13mqb
h6kAoJcbBX7EMVaUbgsxjN7uAjrql21j
=UnkP
-----END PGP SIGNATURE-----

--tdl5MUoLcKIl226rN2dBqCMOQ1kVsurLl--
