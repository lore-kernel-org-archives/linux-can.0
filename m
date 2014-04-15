From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 15:42:32 +0200
Message-ID: <534D3748.6060602@pengutronix.de>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net> <534D270D.5060705@pengutronix.de> <534D31EF.6050107@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="47pm6pcgfEGlpFOv8wO3vNgcE0aRvBaMb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45562 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaDONmi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 09:42:38 -0400
In-Reply-To: <534D31EF.6050107@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: khurram gulzar <khurramgulzar@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47pm6pcgfEGlpFOv8wO3vNgcE0aRvBaMb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 03:19 PM, Oliver Hartkopp wrote:
> Something like this?

Yes, no need to move the "base =3D pric->reg_base" under the lock though.=


Marc

> It uses the dev->dev_id which was missed in the 3e66d0138c05d9792f patc=
h before.
>=20
> Just compile-tested by now ...
>=20
> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sj=
a1000/sja1000_isa.c
> index df136a2..46e1784 100644
> --- a/drivers/net/can/sja1000/sja1000_isa.c
> +++ b/drivers/net/can/sja1000/sja1000_isa.c
> @@ -46,6 +46,7 @@ static int clk[MAXDEV];
>  static unsigned char cdr[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D 0xff};
>  static unsigned char ocr[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D 0xff};
>  static int indirect[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D -1};
> +static spinlock_t indirect_lock[MAXDEV];  /* lock for indirect access =
mode */
> =20
>  module_param_array(port, ulong, NULL, S_IRUGO);
>  MODULE_PARM_DESC(port, "I/O port number");
> @@ -101,19 +102,28 @@ static void sja1000_isa_port_write_reg(const stru=
ct sja1000_priv *priv,
>  static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_priv=
 *priv,
>  					     int reg)
>  {
> -	unsigned long base =3D (unsigned long)priv->reg_base;
> +	unsigned long base, flags;
> +	u8 readval;
> =20
> +	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
> +	base =3D (unsigned long)priv->reg_base;
>  	outb(reg, base);
> -	return inb(base + 1);
> +	readval =3D inb(base + 1);
> +	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
> +
> +	return readval;
>  }
> =20
>  static void sja1000_isa_port_write_reg_indirect(const struct sja1000_p=
riv *priv,
>  						int reg, u8 val)
>  {
> -	unsigned long base =3D (unsigned long)priv->reg_base;
> +	unsigned long base, flags;
> =20
> +	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
> +	base =3D (unsigned long)priv->reg_base;
>  	outb(reg, base);
>  	outb(val, base + 1);
> +	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
>  }
> =20
>  static int sja1000_isa_probe(struct platform_device *pdev)
> @@ -169,6 +179,7 @@ static int sja1000_isa_probe(struct platform_device=
 *pdev)
>  		if (iosize =3D=3D SJA1000_IOSIZE_INDIRECT) {
>  			priv->read_reg =3D sja1000_isa_port_read_reg_indirect;
>  			priv->write_reg =3D sja1000_isa_port_write_reg_indirect;
> +			spin_lock_init(&indirect_lock[idx]);
>  		} else {
>  			priv->read_reg =3D sja1000_isa_port_read_reg;
>  			priv->write_reg =3D sja1000_isa_port_write_reg;
> @@ -198,6 +209,7 @@ static int sja1000_isa_probe(struct platform_device=
 *pdev)
> =20
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
> +	dev->dev_id =3D idx;
> =20
>  	err =3D register_sja1000dev(dev);
>  	if (err) {
>=20
>=20
>=20
> On 15.04.2014 14:33, Marc Kleine-Budde wrote:
>> On 04/15/2014 02:00 PM, Oliver Hartkopp wrote:
>>> As I wrote in the other thread:
>>>
>>>> The command i am executing is=20
>>>> modprobe sja1000_isa port=3D0x200,0x204 irq=3D10,11 indirect=3D1=20
>>>
>>> The parameters for each interface are given separately
>>
>> The indirect mode is racy, btw....
>>
>>> static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_pri=
v *priv,
>>>                                              int reg)
>>> {
>>>         unsigned long base =3D (unsigned long)priv->reg_base;
>>>
>>>         outb(reg, base);
>>>         return inb(base + 1);
>>> }
>>>
>>> static void sja1000_isa_port_write_reg_indirect(const struct sja1000_=
priv *priv,
>>>                                                 int reg, u8 val)
>>> {
>>>         unsigned long base =3D (unsigned long)priv->reg_base;
>>>
>>>         outb(reg, base);
>>>         outb(val, base + 1);
>>> }
>>
>> We need locks.
>>
>> Marc
>>
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--47pm6pcgfEGlpFOv8wO3vNgcE0aRvBaMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNNN0gACgkQjTAFq1RaXHOCVQCdFjUfzDbyjtDbump03IQ4KGFv
K2UAn0GCYkf70EPxAj+jWAuyKjyS/N13
=Wk1w
-----END PGP SIGNATURE-----

--47pm6pcgfEGlpFOv8wO3vNgcE0aRvBaMb--
