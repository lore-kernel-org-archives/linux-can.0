From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Subject: AW: AW: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 9 Aug 2012 15:23:39 +0200
Message-ID: <6C5A3B79888A804CAB605257CD26D37703955B67@vwagwox00032.vw.vwg>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg> <1236253306.453.1344517522410.JavaMail.trustmail@VW2BWOSEVG02>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:37849 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab2HINXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 09:23:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1236253306.453.1344517522410.JavaMail.trustmail@VW2BWOSEVG02>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Great. Thanks.

Sven=09

-----Urspr=FCngliche Nachricht-----
Von: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kerne=
l.org] Im Auftrag von Marc Kleine-Budde
Gesendet: Donnerstag, 9. August 2012 15:05
An: Schmitt, Sven (EVM/8)
Cc: unlisted-recipients; yegor_sub1@visionsystems.de; linux-can@vger.ke=
rnel.org
Betreff: Re: AW: Fwd: [Socketcan-users] sja1000_platform interrupt shar=
ing

On 08/09/2012 02:46 PM, Schmitt, Sven (EVM/8) wrote:
> Second try:

Here should go the patch description. I'll compose a nice one from the
information form your first patch.

> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>

Given that you're behind VW's firewall, I'll take care of applying the
patch by hand, as some mail clients tend to mess with line breaks.

Marc
>=20
> --- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
> +++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
> @@ -109,7 +109,9 @@ static int sp_probe(struct platform_devi
>  	priv =3D netdev_priv(dev);
> =20
>  	dev->irq =3D res_irq->start;
> -	priv->irq_flags =3D res_irq->flags & (IRQF_TRIGGER_MASK |
> IRQF_SHARED);
> +	priv->irq_flags &=3D IRQF_TRIGGER_MASK;
> +	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
> +		priv->irq_flags |=3D IRQF_SHARED;
>  	priv->reg_base =3D addr;
>  	/* The CAN clock frequency is half the oscillator clock
> frequency */
>  	priv->can.clock.freq =3D pdata->osc_freq / 2;
>=20
>=20
> note: patch is compile tested only.
>=20
> Sven
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

