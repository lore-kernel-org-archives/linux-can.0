From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/6] net: can: ifi: Treat CAN_CTRLMODE_FD_NON_ISO
 correctly
Date: Sun, 8 May 2016 20:55:27 +0200
Message-ID: <572F8B9F.3000308@pengutronix.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
 <1462660456-6179-4-git-send-email-marex@denx.de>
 <572F84C2.7040907@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o3jxd75vRuqearq0aUjkMM1QxPhFdo4d2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57784 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750854AbcEHSzo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 14:55:44 -0400
In-Reply-To: <572F84C2.7040907@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o3jxd75vRuqearq0aUjkMM1QxPhFdo4d2
Content-Type: multipart/mixed; boundary="pVWKimWbNREC9CXIWhQetpQU6oojUFcjU"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>,
 linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <572F8B9F.3000308@pengutronix.de>
Subject: Re: [PATCH 4/6] net: can: ifi: Treat CAN_CTRLMODE_FD_NON_ISO
 correctly
References: <1462660456-6179-1-git-send-email-marex@denx.de>
 <1462660456-6179-4-git-send-email-marex@denx.de>
 <572F84C2.7040907@hartkopp.net>
In-Reply-To: <572F84C2.7040907@hartkopp.net>

--pVWKimWbNREC9CXIWhQetpQU6oojUFcjU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2016 08:26 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 05/08/2016 12:34 AM, Marek Vasut wrote:
>> The CAN_CTRLMODE_FD flag is set for both ISO and BOSCH CANFD mode,
>> while the CAN_CTRLMODE_FD_NON_ISO is additional flag which is only
>> set for CANFD-BOSCH mode. Fix the handling of the flags to reflect
>> this.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Makes sense :-)
>=20
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to the patch.

Thanks,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pVWKimWbNREC9CXIWhQetpQU6oojUFcjU--

--o3jxd75vRuqearq0aUjkMM1QxPhFdo4d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL4uhAAoJED07qiWsqSVqUgoH/2tuBokd7nD6Eg1w7EIgIrey
tKZlfWWlJJPE4BtPugxOHfPyGbZn+BrAUH9nIfZ0EQ6khgpSnVFSFivt4sKUn5yi
YoKyJecWacCaoEhhx7+SM6VVMjbWxGqBbKsaSD2LSgnr9k2sJL7ZTfbuyTOy2aC7
9mj8fputdqDokzy/74irgXvOVtVi4RxTSdaoSZoqK+0jL7vtTBAE2wTQP1TYWhWe
wgBc0n2jStNPUFxNeqG9VJ+agJs+yeJkg0kt+urL1YsQDZT9qYyAC9IZWO6nKMjv
tACfRjo5B6jK+oDgoG+Xod5QYXxgkHcjWzr3y3DUa7BSTwtq104MZL79WIYa/2s=
=1rna
-----END PGP SIGNATURE-----

--o3jxd75vRuqearq0aUjkMM1QxPhFdo4d2--
