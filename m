From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: c_can: Add device tree support to Bosch C_CAN/D_CAN
 controller
Date: Wed, 25 Jul 2012 12:11:21 +0200
Message-ID: <500FC649.2000103@pengutronix.de>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com> <1343197417-27481-2-git-send-email-anilkumar@ti.com> <500FBB48.60005@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA03290@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA9A5A9956831503F4AC2022"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GYKLa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 06:11:30 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA03290@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA9A5A9956831503F4AC2022
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 12:06 PM, AnilKumar, Chimata wrote:
[...]
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -30,6 +30,8 @@
>>>  #include <linux/io.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/clk.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> =20
>>>  #include <linux/can/dev.h>
>>> =20
>>> @@ -65,17 +67,51 @@ static void c_can_plat_write_reg_aligned_to_32bit=
(struct c_can_priv *priv,
>>>  	writew(val, priv->base + 2 * priv->regs[index]);
>>>  }
>>> =20
>>> +static struct platform_device_id c_can_id_table[] =3D {
>>> +	{
>>> +		.name =3D KBUILD_MODNAME,
>>> +		.driver_data =3D C_CAN_DEVTYPE,
>>> +	}, {
>>> +		.name =3D "c_can",
>>> +		.driver_data =3D C_CAN_DEVTYPE,
>>> +	}, {
>>> +		.name =3D "d_can",
>>> +		.driver_data =3D D_CAN_DEVTYPE,
>>> +	}, {
>>> +	}
>>> +};
>>> +
>>> +static const struct of_device_id c_can_of_table[] =3D {
>>> +	{ .compatible =3D "bosch,c_can_platform", .data =3D &c_can_id_table=
[0] },
>>
>> Please don't add the "legacy bosch,c_can_platform" to the device tree
>=20
> I will remove this from DT bindings.
>=20
>> bindings. I personally would appreciate if you introduce an enum as
>> array index (BOSCH_C_CAN_PLATFORM, BOSCH_C_CAN, BOSCH_D_CAN) and
>> initialize the c_can_id_table above using the array indexes, then you
>> can use these indexes here too.
>=20
> What about having the same enum for devtype and index like

That was 100% exactly what I was thinking of :)

> enum c_can_dev_id {
> 	BOSCH_C_CAN_PLATFORM,
> 	BOSCH_C_CAN,
> 	BOSCH_D_CAN,
> };
>=20
> static struct platform_device_id c_can_id_table[] =3D {
> 	[BOSCH_C_CAN_PLATFORM] =3D {
> 		.name =3D KBUILD_MODNAME,
> 		.driver_data =3D BOSCH_C_CAN,
> 	},
> };

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEA9A5A9956831503F4AC2022
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAPxkwACgkQjTAFq1RaXHMp2gCfeX52O9mW7qhttP/yQ7EMB9rp
jusAn0pDKZD13A8c2UuAl9ncCzjhOyAe
=wTQT
-----END PGP SIGNATURE-----

--------------enigEA9A5A9956831503F4AC2022--
