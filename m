From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 15:05:13 +0200
Message-ID: <5023B589.4010102@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig774A6D9E314685B25F8BF288"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab2HINFR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 09:05:17 -0400
In-Reply-To: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Cc: yegor_sub1@visionsystems.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig774A6D9E314685B25F8BF288
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

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
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig774A6D9E314685B25F8BF288
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAjtYkACgkQjTAFq1RaXHNPoQCgkRr9L84ntZUQ16gM7hOhVpf+
b1IAnjnovao57hKZi2aIOBPhXKz8l9ci
=R+to
-----END PGP SIGNATURE-----

--------------enig774A6D9E314685B25F8BF288--
