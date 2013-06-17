From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 16:12:11 +0200
Message-ID: <51BF193B.1030307@pengutronix.de>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com> <51BEA863.1040704@hostmobility.com> <51BEB849.3020409@pengutronix.de> <51BF132B.3020705@hostmobility.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LKHWQCTSCRRJTKWPQNVA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46456 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3FQOMW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 10:12:22 -0400
In-Reply-To: <51BF132B.3020705@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Rickard Gustafsson <rickard.gustafsson@hostmobility.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LKHWQCTSCRRJTKWPQNVA
Content-Type: multipart/mixed;
 boundary="------------070607040505030805000407"

This is a multi-part message in MIME format.
--------------070607040505030805000407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/17/2013 03:46 PM, Mirza Krak wrote:
> My modifications to sja1000_platform.c are attached as a patch.
>=20
> Wolfgang: Using spinlock_irqsave() and spinlock_irqrestore() was also m=
y
> initial idea on the io functions but I tried this without it solving th=
e
> problem. I could try this again to be sure.

Without problem locking it not work anyway. Try the attached patch (it's
compile time tested only).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

--------------070607040505030805000407
Content-Type: text/x-diff;
 name="0001-HACK-can-sja1000_platform-add-support-for-indirect-r.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-HACK-can-sja1000_platform-add-support-for-indirect-r.pa";
 filename*1="tch"

=46rom bfebee863f12bee39dee9b00bfe9e3d8c1017d16 Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 17 Jun 2013 16:09:13 +0200
Subject: [PATCH] HACK: can: sja1000_platform: add support for indirect
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Based on a privious work by V=C3=A4nliga H=C3=A4lsningar.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c | 28 ++++++++++++++++++++++++=
+---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can=
/sja1000/sja1000_platform.c
index 8e259c5..35f279c 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -37,14 +37,33 @@ MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on =
the platform bus");
 MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_LICENSE("GPL v2");
=20
+struct sp_priv {
+	spinlock_t ind_lock;
+};
+
 static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
 {
-	return ioread8(priv->reg_base + reg);
+	struct sp_priv *sp =3D priv->priv;
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&sp->ind_lock, flags);
+	iowrite8(reg, priv->reg_base);
+	val =3D ioread8(priv->reg_base + 0x20);
+	spin_unlock_irqrestore(&sp->ind_lock, flags);
+
+	return val;
 }
=20
 static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 v=
al)
 {
-	iowrite8(val, priv->reg_base + reg);
+	struct sp_priv *sp =3D priv->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sp->ind_lock, flags);
+	iowrite8(reg, priv->reg_base);
+	iowrite8(val, (priv->reg_base + 0x20));
+	spin_unlock_irqrestore(&sp->ind_lock, flags);
 }
=20
 static u8 sp_read_reg16(const struct sja1000_priv *priv, int reg)
@@ -73,6 +92,7 @@ static int sp_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	struct net_device *dev;
 	struct sja1000_priv *priv;
+	struct sp_priv *sp;
 	struct resource *res_mem, *res_irq;
 	struct sja1000_platform_data *pdata;
=20
@@ -102,12 +122,13 @@ static int sp_probe(struct platform_device *pdev)
 		goto exit_release;
 	}
=20
-	dev =3D alloc_sja1000dev(0);
+	dev =3D alloc_sja1000dev(sizeof(struct sp_priv));
 	if (!dev) {
 		err =3D -ENOMEM;
 		goto exit_iounmap;
 	}
 	priv =3D netdev_priv(dev);
+	sp =3D priv->priv;
=20
 	dev->irq =3D res_irq->start;
 	priv->irq_flags =3D res_irq->flags & IRQF_TRIGGER_MASK;
@@ -118,6 +139,7 @@ static int sp_probe(struct platform_device *pdev)
 	priv->can.clock.freq =3D pdata->osc_freq / 2;
 	priv->ocr =3D pdata->ocr;
 	priv->cdr =3D pdata->cdr;
+	spin_lock_init(&sp->ind_lock);
=20
 	switch (res_mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
--=20
1.8.3.1


--------------070607040505030805000407--

------enig2LKHWQCTSCRRJTKWPQNVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlG/GT8ACgkQjTAFq1RaXHOKqwCeJuFvN/UOEn4h/EmwbT9pE1hy
kKUAn3mFh7vdVhlobKbdHyu+ShmqcJ5z
=Yd67
-----END PGP SIGNATURE-----

------enig2LKHWQCTSCRRJTKWPQNVA--
