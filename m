From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 15:01:50 +0200
Message-ID: <5023B4BE.5000104@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg> <5023B38B.80702@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC19A401EBF0F5262ECF72C87"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40089 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab2HINCC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 09:02:02 -0400
In-Reply-To: <5023B38B.80702@visionsystems.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegor_sub1@visionsystems.de
Cc: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC19A401EBF0F5262ECF72C87
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2012 02:56 PM, Yegor Yefremov wrote:
> Am 09.08.2012 14:46, schrieb Schmitt, Sven (EVM/8):
>> Second try:
>>
>> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
>>
>> --- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
>> +++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
>> @@ -109,7 +109,9 @@ static int sp_probe(struct platform_devi
>>  	priv =3D netdev_priv(dev);
>> =20
>>  	dev->irq =3D res_irq->start;
>> -	priv->irq_flags =3D res_irq->flags & (IRQF_TRIGGER_MASK |
>> IRQF_SHARED);
>> +	priv->irq_flags &=3D IRQF_TRIGGER_MASK;
>> +	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
>> +		priv->irq_flags |=3D IRQF_SHARED;
>>  	priv->reg_base =3D addr;
>>  	/* The CAN clock frequency is half the oscillator clock
>> frequency */
>>  	priv->can.clock.freq =3D pdata->osc_freq / 2;
>>
>>
>> note: patch is compile tested only.
>>
>> Sven
>=20
> O.K. Nice catch. I just picked the wrong header file
> include/linux/interrupt.h, it should be include/linux/ioport.h. Now
> I'll have to change my board file as well.

A quick serach showed no mainline board using shared irq, have I missed o=
ne?

> You can add my
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

You mean Acked-by?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC19A401EBF0F5262ECF72C87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAjtMcACgkQjTAFq1RaXHPwFgCfZhlaB+dwdc7awn29i4h3XTnu
mEwAnjD+PjDed0x0JEcUXYnKP8aIt9Y9
=AF1r
-----END PGP SIGNATURE-----

--------------enigC19A401EBF0F5262ECF72C87--
