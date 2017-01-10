From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 09:39:09 +0100
Message-ID: <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sO6sh8Sq8bdts2lhDSUonWjWgAIFTOJKA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59865 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756715AbdAJIjW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 03:39:22 -0500
In-Reply-To: <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sO6sh8Sq8bdts2lhDSUonWjWgAIFTOJKA
Content-Type: multipart/mixed; boundary="1VwS4OwUekCkF56fsxmvqDdF24UqTseWF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
In-Reply-To: <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>

--1VwS4OwUekCkF56fsxmvqDdF24UqTseWF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 06:23 PM, Oliver Hartkopp wrote:
>>>> @@ -872,10 +868,22 @@ static int can_changelink(struct net_device *d=
ev,
>>>>  		/* Do not allow changing bittiming while running */
>>>>  		if (dev->flags & IFF_UP)
>>>>  			return -EBUSY;
>>>> +
>>>> +		/* Calculate bittiming parameters based on
>>>> +		 * bittiming_const if set, otherwise pass bitrate
>>>> +		 * directly via do_set_bitrate(). Bail out if neither
>>>> +		 * is given.
>>>> +		 */
>>>> +		if (!priv->bittiming_const && !priv->do_set_bittiming)
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>
>>> I would suggest to remove this check and the comment here and better =
add
>>> an else path with
>>>
>>> 	return -EOPNOTSUPP;
>>> at
>>> 	if (priv->do_set_bittiming) { } else ...
>>
>> Then the code looks like this:
>>
>>> 	if (data[IFLA_CAN_BITTIMING]) {
>>> 		struct can_bittiming bt;
>>>
>>> 		/* Do not allow changing bittiming while running */
>>> 		if (dev->flags & IFF_UP)
>>> 			return -EBUSY;
>>>
>>> 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>>> 		if (priv->bittiming_const) {
>>> 			err =3D can_get_bittiming(dev, &bt,
>>> 						priv->bittiming_const);
>>> 			if (err)
>>> 				return err;
>>> 		}
>>> 		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>>
>>> 		if (priv->do_set_bittiming) {
>>> 			/* Finally, set the bit-timing registers */
>>> 			err =3D priv->do_set_bittiming(dev);
>>> 			if (err)
>>> 				return err;
>>> 		} else if (!priv->bittiming_const) {
>>
>> This "else" means an implicit "!priv->do_set_bittiming &&" which makes=

>> the code IMHO quite hard to understand.
>=20
> No no no.
>=20
> I just meant to throw -EOPNOTSUPP if !(priv->do_set_bittiming).

No, do_set_bittiming is not mandatory.

On SoC internal CAN cores it's easier to program the bittiming
parameters into the controller during open(). As long as the driver sets
the bittiming_const the framework will check if the bittiming parameters
are correct.

> As you suggested in the answer to my RFC these checks for existing=20
> functions can be moved to the beginning of each code section.

That's what my original patch proposes, here the resulting code of my pat=
ch:

> 	if (data[IFLA_CAN_BITTIMING]) {
> 		struct can_bittiming bt;
>=20
> 		/* Do not allow changing bittiming while running */
> 		if (dev->flags & IFF_UP)
> 			return -EBUSY;
>=20
> 		/* Calculate bittiming parameters based on
> 		 * bittiming_const if set, otherwise pass bitrate
> 		 * directly via do_set_bitrate(). Bail out if neither
> 		 * is given.
> 		 */
> 		if (!priv->bittiming_const && !priv->do_set_bittiming)
> 			return -EOPNOTSUPP;
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
> 		}
> 	}

>>> 			/* Calculate bittiming parameters based on
>>> 			 * bittiming_const if set, otherwise pass bitrate
>>> 			 * directly via do_set_bitrate(). Bail out if neither
>>> 			 * is given.
>>> 			 */
>>> 			return -EOPNOTSUPP;
>>> 		}
>>> 	}
>>
>>
>>>>  		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>>>> -		err =3D can_get_bittiming(dev, &bt, priv->bittiming_const);
>>>> -		if (err)
>>>> -			return err;
>>>> +		if (priv->bittiming_const) {
>>>> +			err =3D can_get_bittiming(dev, &bt,
>>>> +						priv->bittiming_const);
>>>> +			if (err)
>>>> +				return err;
>>>> +		}
>>>>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>>>
>>>>  		if (priv->do_set_bittiming) {
>>>> @@ -943,11 +951,23 @@ static int can_changelink(struct net_device *d=
ev,
>>>>  		/* Do not allow changing bittiming while running */
>>>>  		if (dev->flags & IFF_UP)
>>>>  			return -EBUSY;
>>>> +
>>>> +		/* Calculate bittiming parameters based on
>>>> +		 * data_bittiming_const if set, otherwise pass bitrate
>>>> +		 * directly via do_set_bitrate(). Bail out if neither
>>>> +		 * is given.
>>>> +		 */
>>>> +		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>>  		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
>>>>  		       sizeof(dbt));
>>>> -		err =3D can_get_bittiming(dev, &dbt, priv->data_bittiming_const);=

>>>> -		if (err)
>>>> -			return err;
>>>> +		if (priv->data_bittiming_const) {
>>>> +			err =3D can_get_bittiming(dev, &dbt,
>>>> +						priv->data_bittiming_const);
>>>> +			if (err)
>>>> +				return err;
>>>> +		}
>>>>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>>>>
>>>>  		if (priv->do_set_data_bittiming) {
>>>>
>>>
>>> dito here.
>>>
>>> Maybe this leads to two patches then:
>>>
>>> 1. Introduce the -EOPNOTSUPP for missing do_set[_data]_bittiming
>>
>> do_set_bittiming is and was not mandatory.
>=20
> This is broken - isn't it?
> Does it make sense to make do_set_bittiming optional?

No, it's perfectly fine, see above.

> I would think do_set_bittiming is mandatory but bittiming_const can be =

> optional to support a fixed set of bitrates e.g. for the mcba_usb drive=
r?!?

Until your patch ("08da7da41ea4 can: provide a separate bittiming_const
parameter to bittiming functions) bittiming_const was optional.

Recap: do_set_bittiming or bittiming_const (or both) must be provided.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1VwS4OwUekCkF56fsxmvqDdF24UqTseWF--

--sO6sh8Sq8bdts2lhDSUonWjWgAIFTOJKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh0na8ACgkQPTuqJayp
JWooqQf9EkyQACuMVUL0PlFnkxP012uUbq2A2ApDX/O8qkaVO2ZFd6dSlDVb1uG9
5gVGaT19aL7chZzfq5hjRsv+Y0RhbEPcIurtKF6codFU70ejgsEGdoVq+kBn+SzB
WFRssmnhRaEoUj0WxLF95+XW2a35X7PY66evxrQLD3i/lkiZ6oSScWGxvGkf0oc7
k7P1zrfzjKBLDhelTeo8IOmtJSgtNnvu5vkUanVv5CNHZMGdmZQq8ehc/PqtR9gI
FZ04j7XhIZrBjeIbjGbpGad0CCg6Icl3H77ct364cEJe3dBdSlWOP71STKBWl/Ue
px+T4vqdCn0nJR8LJmnqerihi0yxYg==
=Lrt5
-----END PGP SIGNATURE-----

--sO6sh8Sq8bdts2lhDSUonWjWgAIFTOJKA--
