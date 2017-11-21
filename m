From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
Date: Tue, 21 Nov 2017 13:38:58 +0100
Message-ID: <5ddaf4c7-e5c5-434a-f15e-5d8bc3c043b5@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <26cf5587-3100-e681-b477-0f87ed58b872@pengutronix.de>
 <AM0PR0402MB3940428AF84544CD28F613B4F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="54HMc42D5cRdtHkC8LRoxRji0voqSka8T"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51275 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752104AbdKUMjK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 07:39:10 -0500
In-Reply-To: <AM0PR0402MB3940428AF84544CD28F613B4F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--54HMc42D5cRdtHkC8LRoxRji0voqSka8T
Content-Type: multipart/mixed; boundary="dAH8BL6tF5G4raB2ExJUpRMggFXUO2pE8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>
Message-ID: <5ddaf4c7-e5c5-434a-f15e-5d8bc3c043b5@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <26cf5587-3100-e681-b477-0f87ed58b872@pengutronix.de>
 <AM0PR0402MB3940428AF84544CD28F613B4F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3940428AF84544CD28F613B4F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--dAH8BL6tF5G4raB2ExJUpRMggFXUO2pE8
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 01:18 PM, Pankaj Bansal wrote:
>> Looks better now. Please add note to
>> "Documentation/devicetree/bindings/net/can/fsl-flexcan.txt" that we no=
w
>> support endianess and state the default endianess.
>>
>> What about:
>>
>> On a "fsl,p1010-flexcan" device BE is default, on all other devices LE=
 is.
>>
>> Please remove the existing "fsl,p1010-flexcan" from "arch/arm/boot/dts=
"
>> and add fsl,imx25-flexcan, fsl,imx35-flexcan and fsl,imx53-flexcan sup=
port to
>> the driver.
>=20
> @Marc Kleine-Budde :
> Should we keep=20
> .compatible =3D "fsl,imx25-flexcan", .data =3D &fsl_p1010_devtype_data,=

> or=20
> .compatible =3D "fsl,imx25-flexcan", .data =3D &fsl_imx25_devtype_data,=

>=20
> in flexcan.c ? right now imx25, imx35, imx53 use same dev_data as p1010=
=2E

Yes, keep it this way.

> So If any quirk is added to p1010, it's also applicable for other 3
> platforms.

Probably... I've never had a p1010 in my hands.

> Once we remove p1010 compatible from their device-tree, should we
> keep The dev_data as p1010 or make it separate too ?
Keep it until there is a change makes separating them necessary.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dAH8BL6tF5G4raB2ExJUpRMggFXUO2pE8--

--54HMc42D5cRdtHkC8LRoxRji0voqSka8T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloUHmUACgkQHv7KIOw4
HPbBJgf6A8UsfyPgxSY9z+LCrDF8rQ4Q9iO9zj7bFJCaTmv2Y7ZCW4KRnm08Pqap
Nv+JdLb75rIcjg6yUggLJyFGm/c14rG9ubnMLKg45PjIymJ/+3JCIElHWDKLZYG6
pYby2c+WNP6gcn/WUtbrej99dXbqVFuETiXpfNjyLpXnT9mKUDfTyQuwkKBpj1SM
8ifv6Y2CZJhDl02ZFJNdF284fEt7xvFNwyZY3zKvOTnOq9FN5LUqK3Y0PiOkHgrT
1uL/ckglVojAQEg6P27HE0AmDOzfBwX7vG9uoSrbGW7V3N4xTS2ST3p1zRQBToiM
4GRPNqJJG8GeaoCZSnUA0a2ywqal0w==
=Z+XA
-----END PGP SIGNATURE-----

--54HMc42D5cRdtHkC8LRoxRji0voqSka8T--
