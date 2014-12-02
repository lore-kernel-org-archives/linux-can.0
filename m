From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files modifications
Date: Tue, 02 Dec 2014 15:02:53 +0100
Message-ID: <547DC68D.3030508@pengutronix.de>
References: <54779735.8030809@pengutronix.de> <547DBADC.2020009@pengutronix.de> <547DC4CE.8080504@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e31ALSAbOrlaUHU1xLo9h5GkxWIXPljHt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41155 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaLBOC7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 09:02:59 -0500
In-Reply-To: <547DC4CE.8080504@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e31ALSAbOrlaUHU1xLo9h5GkxWIXPljHt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2014 02:55 PM, Stephane Grosjean wrote:
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> b/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> index 925ab8e..10a4ceb 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> @@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb =3D {
>>>       .name =3D "PCAN-USB",
>>>       .device_id =3D PCAN_USB_PRODUCT_ID,
>>>       .ctrl_count =3D 1,
>>> +    .ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>>> CAN_CTRLMODE_LISTENONLY,
>> This change seems unrelated to the make functions non static.
>=20
> Ok.
>=20
>>
>> and FTBFS:
>>
>>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: error: unknown
>>> field =E2=80=98ctrlmode_supported=E2=80=99 specified in initializer
>>>    .ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>>> CAN_CTRLMODE_LISTENONLY,
>>>    ^
>>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning:
>>> initialization makes pointer from integer without a cast
>>> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning: (near
>>> initialization for =E2=80=98pcan_usb.intf_probe=E2=80=99)
>=20
> well, this FTBS is "normal" while you doesn't apply PATCH 3/3. I though=
t
> a "serie" of patches was not cleavable... Can u confirm, please?

No, that would break bisection. The kernel must compile and work after
each patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--e31ALSAbOrlaUHU1xLo9h5GkxWIXPljHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfcaNAAoJECte4hHFiupUdfAP/3h/nR2AHMIc7LuSRy5bL83x
SBEzh02V5bsmUHFEDoJ9Drxh5zbz6ra7xHC24guo1J1NNLkobx908P6aNRfmhbS9
7qjW3LOKNMa3SVLjJPxCRjgREChCqEqz/CuBhI3kBItfJGlAiXsrv5sODjhEtBXq
+D7kbxxExXzCFfeQ6uFIJhTA/Nmo2HyGjDkUH8bAHH59GkazYYVE1dflgRFH75Z0
+xoU7xKgfgKjWcije75SrnPGxKUgsVOTNSbjq5WTL8lefy1THbH2OA62XaioYFZS
UUjGVPNC4bXZIuCNKxeEpbCfM5KrjkgltY8xPFlxuC3gtGHNZJ/xbS0bU6P0AilI
Ww/bW3DVn3F01TClW1g8zs8Ed2do+QKmpcjexcCyGYQW+aFV5tdNikmfX0C3lVbb
/WKJHEXilwU2K6awrZBgap5ZeTuJ/uyAw0ZUGYv0E4ZRHfrPc0XT488sn0NH1+wy
l1vACP6KttxYDaZhRB96mti+pR9JukJWfhPWqLsLBR43FYKUcSJOUrdC26B8fsUW
N5uULBgQOgxiO3EkJYAMi3nuh/VIEq1cRy1vA6jY2vZ/Dii4SKsPmRLr16AUjCXa
szzVdt86JTa+lR8DBrD5jduhZHnviCSmFYAACN+w6tywuIpLtQDhI9QtnF7flDLo
aK+SwO7ZyYu41YlpFHPL
=CHd4
-----END PGP SIGNATURE-----

--e31ALSAbOrlaUHU1xLo9h5GkxWIXPljHt--
