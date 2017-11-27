From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 1/6] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
Date: Mon, 27 Nov 2017 15:06:17 +0100
Message-ID: <5b7085c4-650d-a12c-8e14-e2fdf3ad896a@pengutronix.de>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
 <1511529733-27942-2-git-send-email-pankaj.bansal@nxp.com>
 <44f37aef-7f45-a7c7-7320-01a62e23fbde@pengutronix.de>
 <AM0PR0402MB39405B9B5E5C04B2492221D6F1240@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6vl9IqSvh5sgXdjoWgusmvcXg1lkPCuDq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41825 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752282AbdK0OGf (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Mon, 27 Nov 2017 09:06:35 -0500
In-Reply-To: <AM0PR0402MB39405B9B5E5C04B2492221D6F1240@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6vl9IqSvh5sgXdjoWgusmvcXg1lkPCuDq
Content-Type: multipart/mixed; boundary="8jDoio6fuIRFOJFQWqkrlT1I8V3p80L5J";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Sakar Arora <Sakar.Arora@freescale.com>
Message-ID: <5b7085c4-650d-a12c-8e14-e2fdf3ad896a@pengutronix.de>
Subject: Re: [PATCH v4 1/6] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
 <1511529733-27942-2-git-send-email-pankaj.bansal@nxp.com>
 <44f37aef-7f45-a7c7-7320-01a62e23fbde@pengutronix.de>
 <AM0PR0402MB39405B9B5E5C04B2492221D6F1240@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB39405B9B5E5C04B2492221D6F1240@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--8jDoio6fuIRFOJFQWqkrlT1I8V3p80L5J
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/26/2017 03:20 AM, Pankaj Bansal wrote:
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index a13a489..4c873fb 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>
>> [...]
>> I think this will select LE for non DT devices, right?
>>
>=20
> Yes.  As per below code snippet:
>=20
> static struct property *__of_find_property(const struct device_node *np=
,
> 					   const char *name, int *lenp)
> {
> 	struct property *pp;
>=20
> 	if (!np)
> 		return NULL;
>               ....
> }
>=20
> If no device node is present null is returned.
> So we select le as default.

This is what I found out, too.

>>> +	if (of_property_read_bool(pdev->dev.of_node, "big-endian")) {
>>> +		priv->read =3D flexcan_read_be;
>>> +		priv->write =3D flexcan_write_be;
>>> +	} else {
>>> +		if (of_device_is_compatible(pdev->dev.of_node,
>>> +					    "fsl,p1010-flexcan")) {
>>> +			priv->read =3D flexcan_read_be;
>>> +			priv->write =3D flexcan_write_be;
>>> +		} else {
>>> +			priv->read =3D flexcan_read_le;
>>> +			priv->write =3D flexcan_write_le;
>>> +		}
>>> +	}
>>> +
>>>  	priv->can.clock.freq =3D clock_freq;
>>>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>>>  	priv->can.do_set_mode =3D flexcan_set_mode;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8jDoio6fuIRFOJFQWqkrlT1I8V3p80L5J--

--6vl9IqSvh5sgXdjoWgusmvcXg1lkPCuDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlocG9kACgkQHv7KIOw4
HPbTIwgAvXPBrkI75OxD3E3EG2S0bQ63WMQ76bxrdFQlv7XZm/F+dThE4pzIL2RG
VOVGRm/aeWN4cZSkOPP27YWdJvd9STBMLrCxoNrueJyoRb8BPyT4x+mpEVO8ijOz
iNUKXo++hnjf8zaMeIu6/PHm1l9bAjGhBSt9d6hMLWs46P2PDtwbyWPmcJHFPhWO
UpKIiYhZhgUdh3knZ6bcyoqWGEywMwwhVcJl4hx7hXo1OMpcK1kwFxaY4RG/H6Yc
qH4UOotLt4K81J8RoBMq72rFpEFEQXtPMmKJ1YSuk9dAyKParPiaPMBWA6LZTZKM
KW8bWYMne95YJ3IiZ9HFF0IA46ensw==
=TEZ4
-----END PGP SIGNATURE-----

--6vl9IqSvh5sgXdjoWgusmvcXg1lkPCuDq--
