From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add CAN interface termination API
Date: Fri, 13 Jan 2017 12:30:11 +0100
Message-ID: <a29c5428-65f1-278a-03ae-50c146fe476d@pengutronix.de>
References: <20170111152758.3578-1-mkl@pengutronix.de>
 <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="k7RKPKSdiOWfIaAtWFAK7Iq6CpuCCCGo4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57481 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751441AbdAMLaY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 06:30:24 -0500
In-Reply-To: <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k7RKPKSdiOWfIaAtWFAK7Iq6CpuCCCGo4
Content-Type: multipart/mixed; boundary="QECsOVs8EKa7igJXxsmPj7xmUOt1cxBQs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a29c5428-65f1-278a-03ae-50c146fe476d@pengutronix.de>
Subject: Re: [PATCH] can: add CAN interface termination API
References: <20170111152758.3578-1-mkl@pengutronix.de>
 <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>
In-Reply-To: <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>

--QECsOVs8EKa7igJXxsmPj7xmUOt1cxBQs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 09:03 AM, Ramesh Shanmugasundaram wrote:
> HI Oliver, Marc,
>=20
>> Subject: [PATCH] can: add CAN interface termination API
>>
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> This patch adds a netlink interface to configure the CAN bus terminati=
on
>> of CAN interfaces.
>>
>> Inside the driver an array of supported termination values is defined:=

>>
>> const u16 drvname_termination[] =3D { 60, 120, CAN_TERMINATION_DISABLE=
D };
>>
>> struct drvname_priv *priv;
>> priv =3D netdev_priv(dev);
>>
>> priv->termination_const =3D &drvname_termination; termination_const_cn=
t =3D
>> priv->ARRAY_SIZE(drvname_termination);
>> priv->termination =3D CAN_TERMINATION_DISABLED;
>>
>> And the funtion to set the value has to be defined:
>>
>> priv->do_set_termination =3D drvname_set_termination;
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> picking up Oliver's work.
>>
>> Changes since v3:
>> - can_changelink: use "const".
>> - register_candev: add consistency check for termination_const and
>> termination_const_cnt
>> - can_get_size & can_fill_info: remove check for termination_const_cnt=

>> - can_get_size: reorder to match IFLA_CAN_ enum.
>> - can_get_size & can_fill_info: convert sizeof(u16) to use appropriate=

>> member of struct can_priv.
>> - can_fill_info: use || to chain multiple nla_put.
>=20
> These are nice additions.=20
> One minor comment further down. Otherwise
>=20
> Reviewed-by: Ramesh Shanmugasundaram <Ramesh.shanmugasundaram@bp.renesa=
s.com>
>=20
>>
>>  drivers/net/can/dev.c            | 48
>> +++++++++++++++++++++++++++++++++++++++-
>>  include/linux/can/dev.h          |  4 ++++
>>  include/uapi/linux/can/netlink.h |  5 +++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>> c240cd9f823b..254183e5baf9 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -978,6 +978,30 @@ static int can_changelink(struct net_device *dev,=

>>  		}
>>  	}
>>
>> +	if (data[IFLA_CAN_TERMINATION]) {
>> +		const u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);
>> +		const int num_term =3D priv->termination_const_cnt;
>> +		int i;
>=20
> The above two definitions can be unsigned int.

Changed that, thanks.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QECsOVs8EKa7igJXxsmPj7xmUOt1cxBQs--

--k7RKPKSdiOWfIaAtWFAK7Iq6CpuCCCGo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh4ukMACgkQPTuqJayp
JWqO/gf/TWVXVrGx+f4stw6cTdH5tRMZMF3YGWeh4XxCkAMkGJV0KgDQx73tWlxF
C3eKiGD0iYMADtf2F4AzLvrv642eaXXbpEqKmZohTQTZcGI8hRb6uY46e8RdwJD/
Gmn174Odp/D56H9aSQs2pVezXmhSgBCcBuNUhy/4sSAxaVJQN/9Vxl7Tg9QFJo3i
wYCjIeaZyI6PtvbhhT+K0mMYo5IuN3P+aDyChNIdDnC784z7YyFBcC6zrFALm/jE
vdRAGP3FPZY8YUUqZHfY/dPLRTNW+aBCAkZefdHkpHMK2pOh68PcAL8mlYrRaarG
+phGVgIxvU1YG7aS/g/WYuyiJqXxsg==
=8o19
-----END PGP SIGNATURE-----

--k7RKPKSdiOWfIaAtWFAK7Iq6CpuCCCGo4--
