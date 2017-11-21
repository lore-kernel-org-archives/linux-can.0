From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Tue, 21 Nov 2017 13:43:53 +0100
Message-ID: <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
 <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="v1LPvpKWXm3nq941j80uG67beAp4pJF7S"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40367 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752097AbdKUMoE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 07:44:04 -0500
In-Reply-To: <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v1LPvpKWXm3nq941j80uG67beAp4pJF7S
Content-Type: multipart/mixed; boundary="toWr30O5natA8L6hqfjiM3ej4ebkHtWWW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>
Message-ID: <be8f51ff-8775-fe03-d299-2dc1f963ebcc@pengutronix.de>
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
In-Reply-To: <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>

--toWr30O5natA8L6hqfjiM3ej4ebkHtWWW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 03:13 AM, ZHU Yi (ST-FIR/ENG1-Zhu) wrote:
> Hello Pankaj,
>=20
>> From: Pankaj Bansal [mailto:pankaj.bansal@nxp.com]
>> Sent: Monday, November 20, 2017 7:11 PM
>> [...]
>> Thank you Zhu Yi for this explanation. This helped me in understanding=
 the quirks.
>> Is there any flexcan core which generates passive state interrupt ?

> I'm afraid so far no known flexcan core supports it.

Should we update the table and add a "IRQ Err Passive" no for all cores?

>  * Below is some version info we got:
>  *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory er=
r RTR re-
>  *                                Filter? connected?  Passive detection=
  ception in MB
>  *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no   =
     no
>  *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no   =
     no
>  *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no   =
     no
>  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no   =
     no
>  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no   =
    yes
>  *   VF610 FlexCAN3  ?               no       yes         ?      yes   =
    yes?

And does it make sense to add "FLEXCAN_QUIRK_BROKEN_PERR_STATE" to the
vf610, too?

> static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
> 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RR=
S |
> 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
> };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--toWr30O5natA8L6hqfjiM3ej4ebkHtWWW--

--v1LPvpKWXm3nq941j80uG67beAp4pJF7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloUH4kACgkQHv7KIOw4
HPavdQf+OIRCYRVUrsTto6CR37G60X6hYkM/kWuzE6Cbt1jQLS3SOApLDFc+7G5m
LDocBqGMW069Demeeg38jXuW7kAMH0a8OMsAWVMqljvE1EfK5wu8UrTpQpzW6YA8
23G2wmjE8loQlQmel56thpo8NOcPXM86XCkodr6fPn+fOMZgOYTjIrHQ1XQxMl7A
D+PjffVozgkxqTqDVfLTlrCo1D5aCAYRBm1TA84RMbROfgX/1FAF0ZfQQNzku7du
/hMLw/GuBXH55NIztfaUg+2aseQhdPcU5QoIbh5heHO+OxMFt5zYfPCtaru9+ZEp
Cm9Qig4HU/U08C0y7WB3WavLrEzJgg==
=1BSo
-----END PGP SIGNATURE-----

--v1LPvpKWXm3nq941j80uG67beAp4pJF7S--
