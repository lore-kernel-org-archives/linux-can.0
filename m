From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Fri, 10 Aug 2012 10:21:20 +0200
Message-ID: <5024C480.2010508@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig06A525A6A602AE7934796DF9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44031 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532Ab2HJIVX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Aug 2012 04:21:23 -0400
In-Reply-To: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Cc: yegor_sub1@visionsystems.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06A525A6A602AE7934796DF9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2012 02:46 PM, Schmitt, Sven (EVM/8) wrote:
> Second try:
>=20
> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
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

Should be:
	priv->irq_flags =3D res_irq->flags & IRQF_TRIGGER_MASK;

I'm fixing this,

Marc

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


--------------enig06A525A6A602AE7934796DF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAkxIAACgkQjTAFq1RaXHNWOwCeJHpYi1AKA3Gn6aW8ifMd+XPF
fuwAn1a+vfOuQZurRHHjtvw2Dl9QS8WQ
=akTl
-----END PGP SIGNATURE-----

--------------enig06A525A6A602AE7934796DF9--
