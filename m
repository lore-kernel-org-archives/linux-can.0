From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RESEND PATCH v3 5/5] can: c_can: Add support for Bosch D_CAN
 controller
Date: Wed, 23 May 2012 22:39:07 +0200
Message-ID: <4FBD4AEB.6000707@pengutronix.de>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com> <1337775313-28219-6-git-send-email-anilkumar@ti.com> <4FBD3F32.3080104@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C487E518D9C44247128E3DC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51432 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758666Ab2EWUjX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 16:39:23 -0400
In-Reply-To: <4FBD3F32.3080104@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C487E518D9C44247128E3DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/23/2012 09:49 PM, Wolfgang Grandegger wrote:
> Hi AnilKumar,
>=20
> I have some more comments...
>=20
> On 05/23/2012 02:15 PM, AnilKumar Ch wrote:
>> This patch adds the support for D_CAN controller driver to the existin=
g
>> C_CAN driver.
>>
>> Bosch D_CAN controller is a full-CAN implementation which is compliant=

>> to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can =
be
>> obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
>> ipmodules_1/can/d_can_users_manual_111.pdf
>>
>> A new array is added for accessing the d_can registers, according to d=
_can
>> controller register space.
>>
>> Current D_CAN implementation has following limitations, this is done
>> to avoid large changes to the C_CAN driver.
>> 1. Message objects are limited to 32, 16 for RX and 16 for TX. C_CAN I=
P
>>    supports upto 32 message objects but in case of D_CAN we can config=
ure
>>    upto 128 message objects.
>> 2. Using two 16bit reads/writes for accessing the 32bit D_CAN register=
s.
>> 3. These patches have been tested on little endian machine, there migh=
t
>>    be some hidden endian-related issues due to the nature of the acces=
ses
>>    (32-bit registers accessed as 2 16-bit registers). However, I do no=
t
>>    have a big-endian D_CAN implementation to confirm.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> Link to previous submission
>> 	http://marc.info/?l=3Dlinux-can&m=3D133690316927301&w=3D2
>>
>>  drivers/net/can/c_can/c_can.h          |   45 +++++++++++++++++++++++=
++++
>>  drivers/net/can/c_can/c_can_platform.c |   52 +++++++++++++++++++++++=
+--------
>>  2 files changed, 84 insertions(+), 13 deletions(-)
>=20
> You should also update the Kconfig entry, name and help.
>=20
>> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_c=
an.h
>> index d1e141e..01a7049 100644
>> --- a/drivers/net/can/c_can/c_can.h
>> +++ b/drivers/net/can/c_can/c_can.h
>> @@ -102,6 +102,51 @@ static const u16 reg_map_c_can[] =3D {
>>  	[C_CAN_MSGVAL2_REG]	=3D 0xB2,
>>  };
>> =20
>> +static const u16 reg_map_d_can[] =3D {
>> +	[C_CAN_CTRL_REG]	=3D 0x00,
>> +	[C_CAN_STS_REG]		=3D 0x04,
>> +	[C_CAN_ERR_CNT_REG]	=3D 0x08,
>> +	[C_CAN_BTR_REG]		=3D 0x0C,
>> +	[C_CAN_BRPEXT_REG]	=3D 0x0E,
>> +	[C_CAN_INT_REG]		=3D 0x10,
>> +	[C_CAN_TEST_REG]	=3D 0x14,
>> +	[C_CAN_TXRQST1_REG]	=3D 0x88,
>> +	[C_CAN_TXRQST2_REG]	=3D 0x8A,
>> +	[C_CAN_NEWDAT1_REG]	=3D 0x9C,
>> +	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
>> +	[C_CAN_INTPND1_REG]	=3D 0xB0,
>> +	[C_CAN_INTPND2_REG]	=3D 0xB2,
>> +	[C_CAN_MSGVAL1_REG]	=3D 0xC4,
>> +	[C_CAN_MSGVAL2_REG]	=3D 0xC6,
>> +	[C_CAN_IF1_COMREQ_REG]	=3D 0x100,
>> +	[C_CAN_IF1_COMMSK_REG]	=3D 0x102,
>> +	[C_CAN_IF1_MASK1_REG]	=3D 0x104,
>> +	[C_CAN_IF1_MASK2_REG]	=3D 0x106,
>> +	[C_CAN_IF1_ARB1_REG]	=3D 0x108,
>> +	[C_CAN_IF1_ARB2_REG]	=3D 0x10A,
>> +	[C_CAN_IF1_MSGCTRL_REG]	=3D 0x10C,
>> +	[C_CAN_IF1_DATA1_REG]	=3D 0x110,
>> +	[C_CAN_IF1_DATA2_REG]	=3D 0x112,
>> +	[C_CAN_IF1_DATA3_REG]	=3D 0x114,
>> +	[C_CAN_IF1_DATA4_REG]	=3D 0x116,
>> +	[C_CAN_IF2_COMREQ_REG]	=3D 0x120,
>> +	[C_CAN_IF2_COMMSK_REG]	=3D 0x122,
>> +	[C_CAN_IF2_MASK1_REG]	=3D 0x124,
>> +	[C_CAN_IF2_MASK2_REG]	=3D 0x126,
>> +	[C_CAN_IF2_ARB1_REG]	=3D 0x128,
>> +	[C_CAN_IF2_ARB2_REG]	=3D 0x12A,
>> +	[C_CAN_IF2_MSGCTRL_REG]	=3D 0x12C,
>> +	[C_CAN_IF2_DATA1_REG]	=3D 0x130,
>> +	[C_CAN_IF2_DATA2_REG]	=3D 0x132,
>> +	[C_CAN_IF2_DATA3_REG]	=3D 0x134,
>> +	[C_CAN_IF2_DATA4_REG]	=3D 0x136,
>> +};
>> +
>> +enum c_can_dev_id {
>> +	C_CAN_DEVTYPE,
>=20
> Should probably be:
>=20
> 	C_CAN_DEVTYPE =3D 0,
>
> for legacy C_CAN support.

I don't understand, what you mean by legacy support.

>=20
>> +	D_CAN_DEVTYPE,
>> +};
>> +
>>  /* c_can private data structure */
>>  struct c_can_priv {
>>  	struct can_priv can;	/* must be the first member */
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/=
c_can/c_can_platform.c
>> index a6e9b93..3b1f6c7 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -71,6 +71,7 @@ static int __devinit c_can_plat_probe(struct platfor=
m_device *pdev)
>>  	void __iomem *addr;
>>  	struct net_device *dev;
>>  	struct c_can_priv *priv;
>> +	const struct platform_device_id *id;
>>  	struct resource *mem;
>>  	int irq;
>>  #ifdef CONFIG_HAVE_CLK
>> @@ -115,7 +116,32 @@ static int __devinit c_can_plat_probe(struct plat=
form_device *pdev)
>>  	}
>> =20
>>  	priv =3D netdev_priv(dev);
>> -	priv->regs =3D reg_map_c_can;
>> +	id =3D platform_get_device_id(pdev);
>> +	switch (id->driver_data) {
>> +	case C_CAN_DEVTYPE:
>> +		priv->regs =3D reg_map_c_can;
>> +		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
>> +		case IORESOURCE_MEM_32BIT:
>> +			priv->read_reg =3D c_can_plat_read_reg_aligned_to_32bit;
>> +			priv->write_reg =3D c_can_plat_write_reg_aligned_to_32bit;
>> +			break;
>> +		case IORESOURCE_MEM_16BIT:
>> +		default:
>> +			priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>> +			priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
>> +			break;
>> +		}
>> +		break;
>> +	case D_CAN_DEVTYPE:
>> +		priv->regs =3D reg_map_d_can;
>> +		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>> +		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>> +		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		goto exit_free_device;
>> +	}
>> =20
>>  	dev->irq =3D irq;
>>  	priv->base =3D addr;
>> @@ -124,18 +150,6 @@ static int __devinit c_can_plat_probe(struct plat=
form_device *pdev)
>>  	priv->priv =3D clk;
>>  #endif
>> =20
>> -	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
>> -	case IORESOURCE_MEM_32BIT:
>> -		priv->read_reg =3D c_can_plat_read_reg_aligned_to_32bit;
>> -		priv->write_reg =3D c_can_plat_write_reg_aligned_to_32bit;
>> -		break;
>> -	case IORESOURCE_MEM_16BIT:
>> -	default:
>> -		priv->read_reg =3D c_can_plat_read_reg_aligned_to_16bit;
>> -		priv->write_reg =3D c_can_plat_write_reg_aligned_to_16bit;
>> -		break;
>> -	}
>> -
>>  	platform_set_drvdata(pdev, dev);
>>  	SET_NETDEV_DEV(dev, &pdev->dev);
>> =20
>> @@ -189,6 +203,17 @@ static int __devexit c_can_plat_remove(struct pla=
tform_device *pdev)
>>  	return 0;
>>  }
>> =20
>> +static const struct platform_device_id c_can_id_table[] =3D {
>> +	{
>> +		.name =3D "c_can_platform",
>> +		.driver_data =3D C_CAN_DEVTYPE,
>> +	}, {
>> +		.name =3D "d_can_platform",
>=20
> s/_platform// !

I thought about removing the "_platform", too:

The driver is traditionally called KBUILD_MODNAME, which is
"c_can_platform" in this case. So we need for compatibility a
"c_can_platform" entry in the id_table.

If we have a "c_can" and a "d_can" entry, the driver would still match a
"c_can_platform" device. The platform bus match function will first
match the id_table, then the driver name [1]. However, only when
matching via the id_table, the id_entry is set. So the driver will oops
when "id" will be dereferenced above.

We have these options:
a) use the patch as it is, with "c_can_platform" and "d_can_platform".
b) have "c_can_platform" and "d_can", which I don't think is intuitive
c) have "c_can_platform", "c_can" and "d_can"

[1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L660

>> +		.driver_data =3D D_CAN_DEVTYPE,
>> +	}, {
>> +	}
>> +};
>> +
>>  static struct platform_driver c_can_plat_driver =3D {
>>  	.driver =3D {
>>  		.name =3D KBUILD_MODNAME,
>> @@ -196,6 +221,7 @@ static struct platform_driver c_can_plat_driver =3D=
 {
>>  	},
>>  	.probe =3D c_can_plat_probe,
>>  	.remove =3D __devexit_p(c_can_plat_remove),
>> +	.id_table =3D c_can_id_table,
>>  };
>> =20
>>  module_platform_driver(c_can_plat_driver);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2C487E518D9C44247128E3DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+9SvMACgkQjTAFq1RaXHNtpQCfZiz32om7hnPSooDo+G8pkAB+
DSQAnRD0qvNQOqp45CXR5i+bChxbUJWu
=9Yk5
-----END PGP SIGNATURE-----

--------------enig2C487E518D9C44247128E3DC--
