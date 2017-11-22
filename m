From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Wed, 22 Nov 2017 12:59:48 +0100
Message-ID: <ced1aea2-144d-9bd5-8ab7-b19492512815@pengutronix.de>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jq34Ra15oCVT9U4PK0lDMO5720D7pRvKi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37039 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752199AbdKVMAA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Nov 2017 07:00:00 -0500
In-Reply-To: <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Stefan Agner <stefan@agner.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jq34Ra15oCVT9U4PK0lDMO5720D7pRvKi
Content-Type: multipart/mixed; boundary="rEcCK8oHthjqDPC3ROWnB5ppeg8ww8UuS";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Stefan Agner <stefan@agner.ch>
Message-ID: <ced1aea2-144d-9bd5-8ab7-b19492512815@pengutronix.de>
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
In-Reply-To: <3e201945af364c5a8a92dd6a931f4448@SGPMBX1017.APAC.bosch.com>

--rEcCK8oHthjqDPC3ROWnB5ppeg8ww8UuS
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 03:56 AM, ZHU Yi (ST-FIR/ENG1-Zhu) wrote:
>>> I'm afraid so far no known flexcan core supports it.
>>
>> Should we update the table and add a "IRQ Err Passive" no for all
>> cores?
> By look into the reference manual of MX25[1], MX35[2] and VF610[3],
> it turns out that none of them support the error passive interrupt.
> So we should update the "IRQ Err Passive" to no for all cores.

I'll create a patch.

> Interestingly, seems the new RM of MX25 (Rev.2) and MX35 (Rev.3)
> states that both core have the [TR]WRN_INT connected, so I guess the
> no in that column were added for the legacy core.

What do you mean by connected exactly?

As fas as I know these IP cores have these interrupts lines, but they
are not properly wired to the IRQ line that leaves the IP core. To quote
Shawn Guo from the discussion back in 2012:

>> From what I can tell, i.MX35, i.MX51 and i.MX53 use the same version,
>> so they should all have the bug.  And for i.MX6Q, since it uses a newe=
r
>> version even than i.MX28, I would believe it's affected by the bug.
>> But I'm copying Dong who should have better knowledge about this to
>> confirm.

Further Dong Aisheng says:

>> Our IC owner double checked the MX35 and MX53 IP and found the
>> RX_WARN & TX_WARN Interrupt source actually are not connected to
>> ARM. That means flexcan will not trigger interrupt to ARM core even
>> RX_WARN or TX_WARN Happens. This may be the root cause that why you
>> cannot see RX_WARN interrupt if not enable bus error interrupt on
>> mx35. He also checked that mx6q has the rx/tx warning interrupt
>> connected to arm. So we guess mx6q does not have this issue.=20
>> Anyway, we can test to confirm.

> However, as the driver also needs to work with the legacy core, and
> they share the same devtype_data as p1010, so I think we should leave
> it as it is.

>>>  * Below is some version info we got:
>>>  *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory =
err RTR re-
>>>  *                                Filter? connected?  Passive detecti=
on  ception in MB
>>>  *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no =
       no
>>>  *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no =
       no
>>>  *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no =
       no
>>>  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no =
       no
>>>  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no =
      yes
>>>  *   VF610 FlexCAN3  ?               no       yes         ?      yes =
      yes?
>>
>> And does it make sense to add "FLEXCAN_QUIRK_BROKEN_PERR_STATE" to the=

>> vf610, too?

> I think vf610 will need this quirk to report correct state transitions.=

> The reason last time we do not touch this is because neither Wolfgang
> nor I had access to vf610, so we can only test with MX28, MX53 and MX6.=

> We thought someone will speak out if they meet problems with this core,=

> and then they can help to fix and test it.

Cc'ed Stefan Agner - maybe he has access to this SoC.

> @Marc, @Wolfgang,
> What do you think? Or shall we fix first and then wait?

Let's wait if Stefan can test, otherwise just fix.

> @Pankaj, as you are currently working on patch this driver, is it
> possible that you can help to create patch for the table and/or the
> PERR_STATE quirk fix for vf610 in case required? Thanks!
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rEcCK8oHthjqDPC3ROWnB5ppeg8ww8UuS--

--jq34Ra15oCVT9U4PK0lDMO5720D7pRvKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloVZrQACgkQHv7KIOw4
HPbRFwgAwqJ3Oh6apj/lHwWHbL+k1sU4Av5NbeEXeTFUkxvnyAgbbQLNq7DBl1ef
Zeh5D66UW31Y2KgPrzeMZo92nDUWqfMASrXmbmDYU8IB+SWXEVzCig7096ec9pPe
dS9kFaMt0ogKmdGaZBn26+L8k3JiK6N8bHh0cvVAkdOpxhcKxYJpw8JMOLhRyPai
LFiRQ3GZCrOc2G4FGxt5T5sEDUkiEmeh2S+8CQnreShVn1jZniZhhiDxY4GSpqWP
Jxg+xK2Hv027M4K/nE8R8aBm5XV5UStn9M7wlCHN8fr/Fja680m6D1yQm9Pr9QLY
6prYxUSYaSnVqrQ9p6EfPCIXHRDwRQ==
=Cbbn
-----END PGP SIGNATURE-----

--jq34Ra15oCVT9U4PK0lDMO5720D7pRvKi--
