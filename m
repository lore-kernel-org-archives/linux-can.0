From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Mon, 9 Jan 2017 11:39:47 +0100
Message-ID: <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8D7kHXkO2LiiWXctBjhg9dmuGeHcxXavn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33695 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751302AbdAIKjy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2017 05:39:54 -0500
In-Reply-To: <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8D7kHXkO2LiiWXctBjhg9dmuGeHcxXavn
Content-Type: multipart/mixed; boundary="HRmpPTrCw4jBuck52IJFCC3Kh283pdMPt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
In-Reply-To: <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>

--HRmpPTrCw4jBuck52IJFCC3Kh283pdMPt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/07/2017 02:22 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> On 01/06/2017 01:53 PM, Marc Kleine-Budde wrote:
>=20
>> @@ -872,10 +868,22 @@ static int can_changelink(struct net_device *dev=
,
>>  		/* Do not allow changing bittiming while running */
>>  		if (dev->flags & IFF_UP)
>>  			return -EBUSY;
>> +
>> +		/* Calculate bittiming parameters based on
>> +		 * bittiming_const if set, otherwise pass bitrate
>> +		 * directly via do_set_bitrate(). Bail out if neither
>> +		 * is given.
>> +		 */
>> +		if (!priv->bittiming_const && !priv->do_set_bittiming)
>> +			return -EOPNOTSUPP;
>> +
>=20
> I would suggest to remove this check and the comment here and better ad=
d=20
> an else path with
>=20
> 	return -EOPNOTSUPP;
> at
> 	if (priv->do_set_bittiming) { } else ...

Then the code looks like this:

> 	if (data[IFLA_CAN_BITTIMING]) {
> 		struct can_bittiming bt;
>=20
> 		/* Do not allow changing bittiming while running */
> 		if (dev->flags & IFF_UP)
> 			return -EBUSY;
>=20
> 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
> 		if (priv->bittiming_const) {
> 			err =3D can_get_bittiming(dev, &bt,
> 						priv->bittiming_const);
> 			if (err)
> 				return err;
> 		}
> 		memcpy(&priv->bittiming, &bt, sizeof(bt));
>=20
> 		if (priv->do_set_bittiming) {
> 			/* Finally, set the bit-timing registers */
> 			err =3D priv->do_set_bittiming(dev);
> 			if (err)
> 				return err;
> 		} else if (!priv->bittiming_const) {

This "else" means an implicit "!priv->do_set_bittiming &&" which makes
the code IMHO quite hard to understand.

> 			/* Calculate bittiming parameters based on
> 			 * bittiming_const if set, otherwise pass bitrate
> 			 * directly via do_set_bitrate(). Bail out if neither
> 			 * is given.
> 			 */
> 			return -EOPNOTSUPP;
> 		}
> 	}


>>  		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>> -		err =3D can_get_bittiming(dev, &bt, priv->bittiming_const);
>> -		if (err)
>> -			return err;
>> +		if (priv->bittiming_const) {
>> +			err =3D can_get_bittiming(dev, &bt,
>> +						priv->bittiming_const);
>> +			if (err)
>> +				return err;
>> +		}
>>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>
>>  		if (priv->do_set_bittiming) {
>> @@ -943,11 +951,23 @@ static int can_changelink(struct net_device *dev=
,
>>  		/* Do not allow changing bittiming while running */
>>  		if (dev->flags & IFF_UP)
>>  			return -EBUSY;
>> +
>> +		/* Calculate bittiming parameters based on
>> +		 * data_bittiming_const if set, otherwise pass bitrate
>> +		 * directly via do_set_bitrate(). Bail out if neither
>> +		 * is given.
>> +		 */
>> +		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
>> +			return -EOPNOTSUPP;
>> +
>>  		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
>>  		       sizeof(dbt));
>> -		err =3D can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
>> -		if (err)
>> -			return err;
>> +		if (priv->data_bittiming_const) {
>> +			err =3D can_get_bittiming(dev, &dbt,
>> +						priv->data_bittiming_const);
>> +			if (err)
>> +				return err;
>> +		}
>>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>>
>>  		if (priv->do_set_data_bittiming) {
>>
>=20
> dito here.
>=20
> Maybe this leads to two patches then:
>=20
> 1. Introduce the -EOPNOTSUPP for missing do_set[_data]_bittiming

do_set_bittiming is and was not mandatory. Before your patch it was
mandatory to have one (bittiming_const or do_set_bittiming) or both.
With your patch bittiming_const got mandatory, too. My patch
re-introduces the "bittiming_const or do_set_bittiming" state, which is
directly reflected by the "if (!priv->bittiming_const &&
!priv->do_set_bittiming)" statement.

> 2. Allow to set bitrates without providing bittiming_const

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HRmpPTrCw4jBuck52IJFCC3Kh283pdMPt--

--8D7kHXkO2LiiWXctBjhg9dmuGeHcxXavn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhzaHMACgkQPTuqJayp
JWrWzAf/StZaoChP35S9VbVrj/5BgWTC8IzFtmPoPqeyObDAXubvd1Ypp9/I/iM0
fehbbERKThTQMeqS6pNM0Hln1UZakJHx7YZuoUb3hVYQCwS2CQwsPhokecN+THSQ
XEzqDX1ggtMI46gfYw6DZodjd4hFf7TAXjGrksFp7b4B/27v8HuJs0btBdXtoH6i
FEXv2nRyBl5ykRvqq2aP4rWEJbQ6Dp/PLl840NAJCASrCL02bB6GAdG29FvW2CU4
5qQMGVCqSioQHvIc3ut/DqIQy5JOEdgv6Myt21XlMrvlStIWptCIb7ueJEX7Mikj
pU+XkRMKd0lZ5FKxcm1WYN+ehom/BQ==
=pfn+
-----END PGP SIGNATURE-----

--8D7kHXkO2LiiWXctBjhg9dmuGeHcxXavn--
