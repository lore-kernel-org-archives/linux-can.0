From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 7 Mar 2012 15:21:12 +0300
Message-ID: <20120307122112.GC674@mwanda>
References: <20120306112108.GA4362@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:36402 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2CGMSz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 07:18:55 -0500
Content-Disposition: inline
In-Reply-To: <20120306112108.GA4362@elgon.mountain>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 02:21:08PM +0300, Dan Carpenter wrote:
> Hello Stephane Grosjean,
>=20
> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB=20
> specific part" from Mar 2, 2012, leads to the following warning:
>=20
> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>=20
> drivers/net/can/usb/peak_usb/pcan_usb.c
>    742          /* can id */
>    743          if (cf->can_id & CAN_EFF_FLAG) {
>    744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id & CAN_ERR=
_MASK);
>    745 =20
>    746                  tmp32 <<=3D 3;

Also we can't be doing this shift on little endian data.

>    747                  *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>    748                  memcpy(++pc, &tmp32, 4);
>    749                  pc +=3D 4;

regards,
dan carpenter


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV1K4AAoJEOnZkXI/YHqRcN8P/2MlHKSaVLhGEUKcrP1vswne
ZtOuENqml/l+EpxbeZsH0zGaqvDaoeoiFOztHlVZmDj1ZmtpezBGxuhwj2pbEFo5
GL2a8pla87pIC3huSAag0bDNXSS/m4uJsYXanf7Z8Zt8RDR8Jkt5E0RTRva7RXZS
SJlWa4oXeLBcjr5fIqyH4ZWOcuHwZtST2FD9pWTE3kuKwTXNh81OaPyvgEJxBJpA
cv83Xv8fJvy+yh6uUF0TX2fdv5TUCtzWFi5FT9twytsjl8jJBk2aH4WKgbhbxPYg
jIGSdkfAQu613VQjzx3ZrNCS9swGIa8OzswrfSEve7CLW81QQxbtgsSuJ91YDu06
ZqYL9RExOr1J0VHLh5GYCYUrlXz+5w6x6/YCS5oPe3wSqFIKrf9q2f0bFrTpaRd6
UMb/VCQbmZ0prtIH0lLe4V8qCloFdlY/2CnMQ7/w0JaMVGO5wiKAyB2RMgZ+Yb/n
ef5Af1pWqx1HCaD1r95V/ceYn+g5BH2QXTiGLNqBxetkReBt1p6wivzY7bIFKzhI
7Wgx9NefuzaP0Ol5U/oExAcy6/pobpPcE4q9bMvUlPloHef0wTWlw/yPlOkgXWVN
2EV0GP5PhYmlD578+PuJyE+RFOPpmQM/kiySk20k84b+k2JGpmvebkF9SP3Scewo
0M2tgzSDidA+c/qHEB9m
=WZd2
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
