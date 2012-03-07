From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 13:29:19 +0100
Message-ID: <4F57549F.3050309@pengutronix.de>
References: <20120306112108.GA4362@elgon.mountain> <20120307122112.GC674@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA80B4AC20227CE5ADE0ACBF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45003 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545Ab2CGM3Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 07:29:25 -0500
In-Reply-To: <20120307122112.GC674@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: s.grosjean@peak-system.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA80B4AC20227CE5ADE0ACBF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2012 01:21 PM, Dan Carpenter wrote:
> On Tue, Mar 06, 2012 at 02:21:08PM +0300, Dan Carpenter wrote:
>> Hello Stephane Grosjean,
>>
>> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB=20
>> specific part" from Mar 2, 2012, leads to the following warning:
>>
>> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
>> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>>
>> drivers/net/can/usb/peak_usb/pcan_usb.c
>>    742          /* can id */
>>    743          if (cf->can_id & CAN_EFF_FLAG) {
>>    744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id & CAN_=
ERR_MASK);
>>    745 =20
>>    746                  tmp32 <<=3D 3;
>=20
> Also we can't be doing this shift on little endian data.

This should be first shift, then convert to little endian, isn't it?

>>    747                  *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>>    748                  memcpy(++pc, &tmp32, 4);
>>    749                  pc +=3D 4;

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEA80B4AC20227CE5ADE0ACBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XVJ8ACgkQjTAFq1RaXHPyWQCfZL9S7kCJ/BMmpJ6j81xk7uUj
mjUAnjKqbnDX24jcxqqiO03er0fLLXIk
=52PT
-----END PGP SIGNATURE-----

--------------enigEA80B4AC20227CE5ADE0ACBF--
