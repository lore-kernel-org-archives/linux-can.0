From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RESEND PATCH v3 5/5] can: c_can: Add support for Bosch D_CAN
 controller
Date: Thu, 24 May 2012 09:18:57 +0200
Message-ID: <4FBDE0E1.1030706@pengutronix.de>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com> <1337775313-28219-6-git-send-email-anilkumar@ti.com> <4FBD3F32.3080104@grandegger.com> <4FBD4AEB.6000707@pengutronix.de> <4FBDDCC0.3020303@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7BE815F10D82AB5338ED7EF9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42109 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2EXHTH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 03:19:07 -0400
In-Reply-To: <4FBDDCC0.3020303@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BE815F10D82AB5338ED7EF9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/24/2012 09:01 AM, Wolfgang Grandegger wrote:
>>>> +static const struct platform_device_id c_can_id_table[] =3D {
>>>> +	{
>>>> +		.name =3D "c_can_platform",
>>>> +		.driver_data =3D C_CAN_DEVTYPE,
>>>> +	}, {
>>>> +		.name =3D "d_can_platform",
>>>
>>> s/_platform// !
>>
>> I thought about removing the "_platform", too:
>>
>> The driver is traditionally called KBUILD_MODNAME, which is
>> "c_can_platform" in this case. So we need for compatibility a
>> "c_can_platform" entry in the id_table.
>>
>> If we have a "c_can" and a "d_can" entry, the driver would still match=
 a
>> "c_can_platform" device. The platform bus match function will first
>> match the id_table, then the driver name [1]. However, only when
>> matching via the id_table, the id_entry is set. So the driver will oop=
s
>> when "id" will be dereferenced above.
>=20
> Ah, I was already wondering how that works... then my comments about
> legacy C_CAN support do not apply.

It does, but you have to handle id=3DNULL. (In case you don't have the
original driver name in the id_table).

>> We have these options:
>> a) use the patch as it is, with "c_can_platform" and "d_can_platform".=

>> b) have "c_can_platform" and "d_can", which I don't think is intuitive=

>> c) have "c_can_platform", "c_can" and "d_can"
>>
>> [1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L660
>=20
> I principle we could also use "c_can" and "d_can" and handle id=3DNULL =
as
> legacy C_CAN driver using the legacy enum default above. Well, it seems=


Yes, we could do this. But this isn't as elegant as my proposal c).

> not to be the for-seen way to handle legacy devices. My concern is
> "c_can_platform" in the DTS file and therefore I would vote for c).

With proposal c) the id_table looks like this:

+static const struct platform_device_id c_can_id_table[] =3D {
+	{
+		.name =3D KBUILD_MODNAME,
+		.driver_data =3D C_CAN_DEVTYPE,
+	}, {
+		.name =3D "c_can",
+		.driver_data =3D C_CAN_DEVTYPE,
+	}, {
+		.name =3D "d_can",
+		.driver_data =3D D_CAN_DEVTYPE,
+	}, {
+	}
+};

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7BE815F10D82AB5338ED7EF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+94OUACgkQjTAFq1RaXHPfMwCaAjC0xz4H+h3UneQjA3f/vf1F
P0cAnjBVqHELYs424CxzPxl2EE0e5nKT
=fM+B
-----END PGP SIGNATURE-----

--------------enig7BE815F10D82AB5338ED7EF9--
