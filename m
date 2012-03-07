From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 10:24:25 +0100
Message-ID: <4F572949.9000906@pengutronix.de>
References: <20120306112108.GA4362@elgon.mountain> <4F5722C4.7030804@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig06DD06200AABE026FCDFB738"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37771 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2CGJYr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 04:24:47 -0500
In-Reply-To: <4F5722C4.7030804@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06DD06200AABE026FCDFB738
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2012 09:56 AM, Stephane Grosjean wrote:
> Happy to have seen some of you last Monday, at iCC, it was great. It's
> always easier when we're able to attach a face to a name.

Yes, I always like that occasions.

> Back to work now:
>=20
> Le 06/03/2012 12:21, Dan Carpenter a =E9crit :
>> Hello Stephane Grosjean,
>>
>> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB
>> specific part" from Mar 2, 2012, leads to the following warning:
>>
>> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
>>      error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>>
>> drivers/net/can/usb/peak_usb/pcan_usb.c
>>     742          /* can id */
>>     743          if (cf->can_id&  CAN_EFF_FLAG) {
>>     744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id&=20
>> CAN_ERR_MASK);
>>     745
>>     746                  tmp32<<=3D 3;
>>     747                  *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>>     748                  memcpy(++pc,&tmp32, 4);
>>     749                  pc +=3D 4;
>>     750          } else {
>>     751                  __le16 tmp16 =3D cpu_to_le32(cf->can_id&=20
>> CAN_ERR_MASK);
>>                          ^^^^^^^^^^^^
>> A little endian 32 bit can't fit here.
>=20
>=20
> How may this error happen while it didn't before? Is this is due to som=
e
> (new) options of gcc, or because of a new version used? In the future,
> how could I avoid that? I mean, how to synchronize with the final GCC
> options/version?

There's no final gcc version. Gcc and the kernel will always evolve.

>=20
> FYI, the original code was:
>=20
>> >  +    else {
>> } else {
>> >  +        u16 tmp16 =3D (u16 )*cpu_to_le32*(cf->can_id&  CAN_ERR_MAS=
K);
>>                              ^^^^^^^^^^^^^^^^^
>=20
> cf->can_id is a 32-bits field which I want to keep only the lo-word par=
t...
>=20
> How to do that in the correct way, please?
>=20
> Anyway, what next? I suppose I have to submit a new patch, but comparin=
g
> to what?

Please post your patch against the can-next git repo.

https://gitorious.org/linux-can/linux-can-next

Regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig06DD06200AABE026FCDFB738
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XKU0ACgkQjTAFq1RaXHMvtwCfd5wWMNyR9jZFkz8xIq7J/GYC
jtQAnj3YQCNWZI3aNnyKH/Y74VPoyflh
=Yui3
-----END PGP SIGNATURE-----

--------------enig06DD06200AABE026FCDFB738--
