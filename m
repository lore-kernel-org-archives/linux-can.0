From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 14:26:10 +0100
Message-ID: <4F5761F2.5010301@pengutronix.de>
References: <20120306112108.GA4362@elgon.mountain> <20120307122112.GC674@mwanda> <4F57549F.3050309@pengutronix.de> <20120307131741.GD674@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig200BC30865B5136AA861E667"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55938 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2CGN01 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 08:26:27 -0500
In-Reply-To: <20120307131741.GD674@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: s.grosjean@peak-system.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig200BC30865B5136AA861E667
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2012 02:17 PM, Dan Carpenter wrote:
> On Wed, Mar 07, 2012 at 01:29:19PM +0100, Marc Kleine-Budde wrote:
>> On 03/07/2012 01:21 PM, Dan Carpenter wrote:
>>> On Tue, Mar 06, 2012 at 02:21:08PM +0300, Dan Carpenter wrote:
>>>> Hello Stephane Grosjean,
>>>>
>>>> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB=20
>>>> specific part" from Mar 2, 2012, leads to the following warning:
>>>>
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
>>>> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>>>>
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c
>>>>    742          /* can id */
>>>>    743          if (cf->can_id & CAN_EFF_FLAG) {
>>>>    744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id & CA=
N_ERR_MASK);
>>>>    745 =20
>>>>    746                  tmp32 <<=3D 3;
>>>
>>> Also we can't be doing this shift on little endian data.
>>
>> This should be first shift, then convert to little endian, isn't it?
>>
>=20
> That's my guess too.
> 		__le32 tmp32 =3D cpu_to_le32((cf->can_id & CAN_ERR_MASK) << 3);

St=E9phane, do you want to make that patch?
Add my Acked-by and a
"Reported-by: Dan Carpenter <dan.carpenter@oracle.com>"

> Btw, it's slightly odd to me that CAN_EFF_MASK and CAN_ERR_MASK are
> the same.  I wouldn't comment on it except that I was wondering if
> it might be a copy and paste bug.

You're right, it odd, but it's intended to be the same. Do you want to
make a patch to add an annotation?

> #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
> #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig200BC30865B5136AA861E667
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XYfUACgkQjTAFq1RaXHPBvACfelMq/bSuf5sM9qP+WCPO8i9l
bMgAnjp+/KoGuvcLJum6SwBEDDSlfSLW
=pemR
-----END PGP SIGNATURE-----

--------------enig200BC30865B5136AA861E667--
