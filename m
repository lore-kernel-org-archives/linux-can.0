From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 13:21:43 +0200
Message-ID: <50239D47.8020100@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B43@vwagwox00032.vw.vwg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B0CD4C1B2757452CB1CB8F1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757768Ab2HILVt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 07:21:49 -0400
In-Reply-To: <6C5A3B79888A804CAB605257CD26D37703955B43@vwagwox00032.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven.Schmitt@volkswagen.de
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B0CD4C1B2757452CB1CB8F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Sven,

please use our new mailinglist linux-can@vger.kernel.org (Cc'ed), and ple=
ase don't send HTML emails.

-------- Original Message --------
Subject: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 9 Aug 2012 12:43:38 +0200
From: Schmitt, Sven (EVM/8) <Sven.Schmitt@volkswagen.de>
To: <socketcan-users@lists.berlios.de>

Hi,

I've found something confusing when I wanted to use more than one
sja1000 attached to a platform bus with interrupt sharing. The flag for
the sja1000 resources I wanted to set first was the
IORESOURCE_IRQ_SHAREABLE* flag because of the other IORESOURCE_IRQ_XXX
flags. But this flag is ignored by the sja1000_platform driver because
it has another position. If I use the generic IRQF_SHARED** flag
everything works fine. Does it make sense to patch the driver in a way
like that:

--- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
2012-08-09 10:38:57.405381025 +0200
+++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
2012-08-09 10:57:22.693364557 +0200
@@ -109,6 +109,8 @@
 	priv =3D netdev_priv(dev);
=20
 	dev->irq =3D res_irq->start;
+	if(res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
+		priv->irq_flags |=3D IRQF_SHARED;
 	priv->irq_flags =3D res_irq->flags & (IRQF_TRIGGER_MASK |
IRQF_SHARED);
 	priv->reg_base =3D addr;
 	/* The CAN clock frequency is half the oscillator clock
frequency */



*
include/linux/ioport.h:
#define IORESOURCE_IRQ_SHAREABLE
<http://lxr.free-electrons.com/ident?i=3DIORESOURCE_IRQ_SHAREABLE>
(1<<4)

**
include/linux/interrupt.h:
#define IRQF_SHARED <http://lxr.free-electrons.com/ident?i=3DIRQF_SHARED>=

0x00000080=20


Best regards,
Sven Schmitt


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--------------enig8B0CD4C1B2757452CB1CB8F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAjnUoACgkQjTAFq1RaXHN/nACfc9D1u481MA4pAtwFhbbckrxv
+goAnj2Faeni+dcPSmczlhy0p7ts9K4k
=yNDV
-----END PGP SIGNATURE-----

--------------enig8B0CD4C1B2757452CB1CB8F1--
