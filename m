From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 20:42:25 +0100
Message-ID: <5290875c-bd2a-e23e-e679-93c6d2216530@pengutronix.de>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
 <f4845404-5e63-40ea-3861-129f114b6508@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6wo6fWbDoSrpkHN0x4wkdf9Q4QFNujoPt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47427 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031680AbdAJTmg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 14:42:36 -0500
In-Reply-To: <f4845404-5e63-40ea-3861-129f114b6508@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wo6fWbDoSrpkHN0x4wkdf9Q4QFNujoPt
Content-Type: multipart/mixed; boundary="FJdfQNwrwWghX9gQapOkHu2Q56nJT7G16";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <5290875c-bd2a-e23e-e679-93c6d2216530@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
 <f4845404-5e63-40ea-3861-129f114b6508@hartkopp.net>
In-Reply-To: <f4845404-5e63-40ea-3861-129f114b6508@hartkopp.net>

--FJdfQNwrwWghX9gQapOkHu2Q56nJT7G16
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 05:54 PM, Oliver Hartkopp wrote:
> On 01/10/2017 09:39 AM, Marc Kleine-Budde wrote:
>=20
>>>> This "else" means an implicit "!priv->do_set_bittiming &&" which mak=
es
>>>> the code IMHO quite hard to understand.
>>>
>>> No no no.
>>>
>>> I just meant to throw -EOPNOTSUPP if !(priv->do_set_bittiming).
>>
>> No, do_set_bittiming is not mandatory.
>>
>> On SoC internal CAN cores it's easier to program the bittiming
>> parameters into the controller during open(). As long as the driver se=
ts
>> the bittiming_const the framework will check if the bittiming paramete=
rs
>> are correct.
>=20
> Oh. Didn't know that use-case for SoCs.
>=20
>>> As you suggested in the answer to my RFC these checks for existing
>>> functions can be moved to the beginning of each code section.
>>
>> That's what my original patch proposes, here the resulting code of my =
patch:
>>
>>> 	if (data[IFLA_CAN_BITTIMING]) {
>>> 		struct can_bittiming bt;
>>>
>>> 		/* Do not allow changing bittiming while running */
>>> 		if (dev->flags & IFF_UP)
>>> 			return -EBUSY;
>>>
>>> 		/* Calculate bittiming parameters based on
>>> 		 * bittiming_const if set, otherwise pass bitrate
>>> 		 * directly via do_set_bitrate(). Bail out if neither
>>> 		 * is given.
>>> 		 */
>>> 		if (!priv->bittiming_const && !priv->do_set_bittiming)
>>> 			return -EOPNOTSUPP;
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
>=20
> I was stumbling upon this additional check.
>=20
> But now it seems correct to me ;-)
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

tnx.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FJdfQNwrwWghX9gQapOkHu2Q56nJT7G16--

--6wo6fWbDoSrpkHN0x4wkdf9Q4QFNujoPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh1OSEACgkQPTuqJayp
JWqiewgApQHN7qhgSbvoLoR4Ac9ixvGkxzeJeCBPD4VSyMnPJIbxfHCRAQajG1bt
mJC3kCVMe9ejru0kYV9Klu27XAHoWNszvuTL24VSpqr2pbZ0LL5LP+cpBTl1HW8P
8vNM9Ix/aKGF7I55U5G7KHcDVqV6Ukepbyr2Y6sivFhARluXyKQT6JoesxXNPgMw
wLlP/wUvqREzYsgHNFRZlFSjmg5ee6DGfuFb6pLCIHgWjtCzRlIU7fkMsThEpw6S
/63SaP3b69BG5+lukPkKB7lMYuup0/wmCsCcmXT4oR/qN8vhQxFfwILnBKkhpzEV
Ux3pSo5UKV5liMbHbQpsanZ3lWbGHA==
=5lnN
-----END PGP SIGNATURE-----

--6wo6fWbDoSrpkHN0x4wkdf9Q4QFNujoPt--
