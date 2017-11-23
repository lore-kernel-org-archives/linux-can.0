From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Thu, 23 Nov 2017 11:07:32 +0100
Message-ID: <9c8816e4-5888-0b10-34c4-0f9fddb4bd53@pengutronix.de>
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
 <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
 <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Iv0w7xEhXJjwrQ5PctwoVf7S0E2ePg4Hc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53075 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751433AbdKWKHl (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Thu, 23 Nov 2017 05:07:41 -0500
In-Reply-To: <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iv0w7xEhXJjwrQ5PctwoVf7S0E2ePg4Hc
Content-Type: multipart/mixed; boundary="hf5MgG7LBrddrmD0LHF4GtrMIbaAiMv23";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>
Message-ID: <9c8816e4-5888-0b10-34c4-0f9fddb4bd53@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
 <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
 <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--hf5MgG7LBrddrmD0LHF4GtrMIbaAiMv23
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 11:01 AM, Pankaj Bansal wrote:
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 4c873fb..21d0dd8 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -190,6 +190,7 @@
>>>   *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no=
        no
>>>   *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no=
       yes
>>>   *   VF610 FlexCAN3  ?               no       yes         ?      yes=
       yes?
>>> + * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no=
       yes
>>
>> Out of curiosity, where have you got the IP core version from?

> I got this version from Bill Of Material details of LS1021A SOC.

Oh, nice. Do you have access to the vf610 list to get the IP core version=
?


>>>   *
>>>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line
>> connected.
>>>   */
>>> @@ -304,6 +305,13 @@ static const struct flexcan_devtype_data
>> fsl_vf610_devtype_data =3D {
>>>  		FLEXCAN_QUIRK_DISABLE_MECR |
>> FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,  };
>>>
>>> +/* LS1021A-Rev2 has functional RX-FIFO mode  */
>>
>> That comment is obsolete, isn't it? If it's a noteworthy feature, add =
it to the
>> overview table above.
>=20
> Actually in LS1021A Rev1 RX-FIFO mode is broken. Rev1 is initial releas=
e, and Rev2
> Is final release. Which is why this comment.

Ahh, can you please add this to the table above.

You're not using the mailbox mode anymore, right? This means the driver
should work with the broken r1 silicon, too? Are any of these silicons
out in the wild? Does it make sense to use "fsl,ls1021ar1-flexcan" for
this compatible?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hf5MgG7LBrddrmD0LHF4GtrMIbaAiMv23--

--Iv0w7xEhXJjwrQ5PctwoVf7S0E2ePg4Hc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWneUACgkQHv7KIOw4
HPa/uQgAlCr513/MpEJjKKDBg7Q6eeLc9YnHXT7N7wm/UV5QpyhPn1ITyFTfOZFa
QYKQFBQiTJD/3lEXxGZWoqF4cQdr6rt/5YyvzVTKlBE95/7tHvGG0axlKmSU6tNz
p4vLKS7keb/CzOpuabUe90ypWa+rXXT5SsqTDq03n2syqI0RLa1alzBKCVMlR/iN
N3q25DRZ60fYHvl/zL199gZxm2Abb9g4D3qMWht3Sh9kbQ0x0C2b3REu+1odN2k/
/sQn0N4yrGYTABLSOzAEjalFv3HsEprkeX4rFCMjarKPv5I6DgzwljZWAXjZEIlv
qhWcXFDEQCGUZGfnCOwggBVtgdjqaw==
=YtUH
-----END PGP SIGNATURE-----

--Iv0w7xEhXJjwrQ5PctwoVf7S0E2ePg4Hc--
