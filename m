From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 13:39:32 +0200
Message-ID: <5023A174.7080301@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B43@vwagwox00032.vw.vwg> <50239D47.8020100@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDE347095123140F08E5D4A9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51179 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2HILjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 07:39:37 -0400
In-Reply-To: <50239D47.8020100@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven.Schmitt@volkswagen.de
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDE347095123140F08E5D4A9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2012 01:21 PM, Marc Kleine-Budde wrote:
> I've found something confusing when I wanted to use more than one

It's not confusing, it's a bug. Good catch.

> sja1000 attached to a platform bus with interrupt sharing. The flag for=

> the sja1000 resources I wanted to set first was the
> IORESOURCE_IRQ_SHAREABLE* flag because of the other IORESOURCE_IRQ_XXX
> flags. But this flag is ignored by the sja1000_platform driver because
> it has another position. If I use the generic IRQF_SHARED** flag
> everything works fine. Does it make sense to patch the driver in a way
> like that:
>=20
> --- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
> 2012-08-09 10:38:57.405381025 +0200
> +++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
> 2012-08-09 10:57:22.693364557 +0200
> @@ -109,6 +109,8 @@
>  	priv =3D netdev_priv(dev);
> =20
>  	dev->irq =3D res_irq->start;
> +	if(res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
> +		priv->irq_flags |=3D IRQF_SHARED;

Please adjust to kernel coding style, space between if and opening bracke=
t.

>  	priv->irq_flags =3D res_irq->flags & (IRQF_TRIGGER_MASK |
> IRQF_SHARED);

Please remove the IRQF_SHARED here, as IRQF_SHARED is wrong here and
means something different.

>  	priv->reg_base =3D addr;
>  	/* The CAN clock frequency is half the oscillator clock
> frequency */

If you have a look at the history of the file, it shows that this flag
was added Yegor Yefremov <yegor_sub1@visionsystems.de> in commit

abde89d can: sja1000: allow shared interrupt definition

Please resend your patch, with the problems fixed, use git send-email
for this, add Yegor on Cc and Sign your work [1]. If this is too
complicated for you, I'll fix it myself.

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298=

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCDE347095123140F08E5D4A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAjoXcACgkQjTAFq1RaXHPJAgCfYOBUYrKvoyk851uXn9UTzzAx
oS0An3zTJOrWE6GtEPUUdBOPZtCEbc8N
=MazX
-----END PGP SIGNATURE-----

--------------enigCDE347095123140F08E5D4A9--
