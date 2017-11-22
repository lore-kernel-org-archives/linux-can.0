From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Wed, 22 Nov 2017 14:56:43 +0100
Message-ID: <b427ccb3-d067-66f5-79cb-dc26d7ca4646@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
 <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de>
 <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
 <DB3PR0402MB394710921822B0FFE6D827ECF1200@DB3PR0402MB3947.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QwV3N5nIFJLn4KqIei9BE3Otj6gUiq4r3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32925 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751259AbdKVN4w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Nov 2017 08:56:52 -0500
In-Reply-To: <DB3PR0402MB394710921822B0FFE6D827ECF1200@DB3PR0402MB3947.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QwV3N5nIFJLn4KqIei9BE3Otj6gUiq4r3
Content-Type: multipart/mixed; boundary="R2jB7uD9fHnBEC1GAR0BVTVEJHQo33865";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>
Message-ID: <b427ccb3-d067-66f5-79cb-dc26d7ca4646@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
 <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de>
 <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
 <DB3PR0402MB394710921822B0FFE6D827ECF1200@DB3PR0402MB3947.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB394710921822B0FFE6D827ECF1200@DB3PR0402MB3947.eurprd04.prod.outlook.com>

--R2jB7uD9fHnBEC1GAR0BVTVEJHQo33865
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 07:27 AM, Pankaj Bansal wrote:
> Hi ZHU Yi,
>=20
>=20
>> From: ZHU Yi (ST-FIR/ENG1-Zhu) [mailto:Yi.Zhu5@cn.bosch.com]
>> Sent: Wednesday, November 22, 2017 8:27 AM
>>> [...]
>> @Pankaj, as you are currently working on patch this driver, is it poss=
ible that
>> you can help to create patch for the table and/or the PERR_STATE quirk=
 fix
>> for vf610 in case required? Thanks!
>>
>=20
> I am afraid I also do not have access to vf610. I have access to p1010.=


Please go ahead and test there.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--R2jB7uD9fHnBEC1GAR0BVTVEJHQo33865--

--QwV3N5nIFJLn4KqIei9BE3Otj6gUiq4r3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloVghsACgkQHv7KIOw4
HPYxCwf/VE56RvD2kh0WZIYe469eZWF3YVs2HD+RtsPA6V87n3PCwy2H7+4V3m99
E29iUstaIZFqRS/LzIaVXX6XkW6aEicF202XkbYALqR3Q1SEdfqoTGjMQwk3AWKd
9NpgSFlwwty2mE2BHiI1DTgNAG8gRDs9y0S1AvzJZnxs34aDqnymlOtMYvBJYvGq
amW74UGlTOE+xslBpRPSmAYm59kE/9ULvjkFVbT0cGR8n0v0vj3d5Xa7sPkeNlvx
S7jvyDPYoTLOXu5KYK5Txm5+e6opIKjQEYbb2BiTNVhW1TolHqD9hNlkojB/1N+A
XI92U4tHAqVIf8ooOKOhy/Kf7lC/ag==
=GCQt
-----END PGP SIGNATURE-----

--QwV3N5nIFJLn4KqIei9BE3Otj6gUiq4r3--
