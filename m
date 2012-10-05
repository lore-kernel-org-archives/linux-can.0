From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC: PATCH 5/5] can: sja1000_platform: add device tree bindings
Date: Fri, 05 Oct 2012 18:42:05 +0200
Message-ID: <506F0DDD.4010101@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de> <1349447947-18451-6-git-send-email-mkl@pengutronix.de> <506F0114.3010708@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35BC8190C8F31CBCB2756523"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2JEQmT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 12:42:19 -0400
In-Reply-To: <506F0114.3010708@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, andreas@gaisler.com, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35BC8190C8F31CBCB2756523
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/05/2012 05:47 PM, Wolfgang Grandegger wrote:
> Hi Marc,
>=20
> On 10/05/2012 04:39 PM, Marc Kleine-Budde wrote:
>> This patch add device tree bindings, the are ported from the
>=20
> typo?

yes.

>=20
>> sja1000_of_platform driver:
>>
>>     Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>>
>> The use of "of_get_property()" has been converted to "of_property_read=
_u32()"
>> to be endianess safe.
>>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/sja1000/sja1000_platform.c |   91 +++++++++++++++++++=
++++++---
>>  1 file changed, 84 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/=
can/sja1000/sja1000_platform.c
>> index 6260209..91f7404 100644
>> --- a/drivers/net/can/sja1000/sja1000_platform.c
>> +++ b/drivers/net/can/sja1000/sja1000_platform.c
>> @@ -1,6 +1,7 @@
>>  /*
>>   * Copyright (C) 2005 Sascha Hauer, Pengutronix
>> - * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
>> + * Copyright (C) 2007-2009 Wolfgang Grandegger <wg@grandegger.com>
>> + * Copyright (C) 2012 Marc Kleine-Budde <mkl@pengutronix.de>
>>   *
>>   * This program is free software; you can redistribute it and/or modi=
fy
>>   * it under the terms of the version 2 of the GNU General Public Lice=
nse
>> @@ -11,15 +12,28 @@
>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>   * GNU General Public License for more details.
>>   *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA
>> + * This is a generic driver for SJA1000 chips on the OpenFirmware
>> + * platform bus found on embedded systems. You need a SJA1000 CAN nod=
e
>> + * definition in your flattened device tree source (DTS) file similar=

>> + * to:
>> + *
>> + *   can@3,100 {
>> + *           compatible =3D "nxp,sja1000";
>> + *           reg =3D <3 0x100 0x80>;
>> + *           interrupts =3D <2 0>;
>> + *           interrupt-parent =3D <&mpic>;
>> + *           nxp,external-clock-frequency =3D <16000000>;
>> + *   };
>> + *
>> + * See "Documentation/devicetree/bindings/net/can/sja1000.txt" for
>> + * further information.
>>   */
>> =20
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/netdevice.h>
>> +#include <linux/of.h>
>>  #include <linux/delay.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>> @@ -30,6 +44,8 @@
>> =20
>>  #include "sja1000.h"
>> =20
>> +#define SP_DEFAULT_CLOCK	(16000000 / 2)
>> +
>>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>>  MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus=
");
>>  MODULE_LICENSE("GPL v2");
>> @@ -72,6 +88,61 @@ static void __devinit sp_probe_pdata(struct sja1000=
_priv *priv, const struct sja
>>  	priv->cdr =3D pdata->cdr;
>>  }
>> =20
>> +#ifdef CONFIG_OF
>=20
> Do we still need that dependency?

We don't need it in order to compile without OF support, but I think it
will make the module a bit bigger. However I'll check this.

> Thanks for cleaning up! Unfortunately, I do not have a board with a
> platform sja1000. Well, I have a phyCORE-PXA270, but I'm not sure if I
> get it working with the mainline kernel quickly.

I'm more interested if the powerpc board is still working. The one you
wrote the of platform driver in the first place.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig35BC8190C8F31CBCB2756523
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBvDeEACgkQjTAFq1RaXHNlyQCeLLMo7v35WtqslghEpQjAaWzK
QIsAnROkN3ogKlOplQEh/Y4SsqocGJQj
=75x1
-----END PGP SIGNATURE-----

--------------enig35BC8190C8F31CBCB2756523--
