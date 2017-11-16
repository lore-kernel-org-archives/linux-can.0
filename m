From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
Date: Thu, 16 Nov 2017 13:04:38 +0100
Message-ID: <6b02b1e1-df20-c615-b30a-a5a9cbfacdf3@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <26cf5587-3100-e681-b477-0f87ed58b872@pengutronix.de>
 <AM0PR0402MB3940B601B1AB23500B2B49D0F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Sb0iPQjaooPxIRudEbnrm1ciHAgnhFLES"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41045 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933668AbdKPMEx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Nov 2017 07:04:53 -0500
In-Reply-To: <AM0PR0402MB3940B601B1AB23500B2B49D0F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sb0iPQjaooPxIRudEbnrm1ciHAgnhFLES
Content-Type: multipart/mixed; boundary="WShiW2uMPrdH9Xs3U2kruoFbMwvSMDctm";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Sakar Arora <Sakar.Arora@freescale.com>
Message-ID: <6b02b1e1-df20-c615-b30a-a5a9cbfacdf3@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <26cf5587-3100-e681-b477-0f87ed58b872@pengutronix.de>
 <AM0PR0402MB3940B601B1AB23500B2B49D0F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3940B601B1AB23500B2B49D0F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--WShiW2uMPrdH9Xs3U2kruoFbMwvSMDctm
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/16/2017 06:24 AM, Pankaj Bansal wrote:
>> What about this:
>>
>> 	/* set defaults */
>> 	if (of_device_is_compatible(pdev->dev.of_node,
>> 				    "fsl,p1010-flexcan")) {
>> 		priv->read =3D flexcan_read_be;
>> 		priv->write =3D flexcan_write_be;
>> 	} else {
>> 		priv->read =3D flexcan_read_le;
>> 		priv->write =3D flexcan_write_le;
>> 	}
>>
>> 	if (of_device_is_big_endian()) {
>> 		priv->read =3D flexcan_read_be;
>> 		priv->write =3D flexcan_write_be;
>> 	} else {
>> 		priv->read =3D flexcan_read_le;
>> 		priv->write =3D flexcan_write_le;
>> 	}
>>
>=20
> native-endian : Use this if the hardware "self-adjusts"
>    register endianness based on the CPU's configured endianness.

If someone set the wrong endianess, be it native, litte or big, if it's
wrong, it's wrong.

> I don=E2=80=99t see FlexCAN hardware doing that. That is why we should =
not use=20
> of_device_is_big_endian, and only check for "big-endian".

I don't mind.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WShiW2uMPrdH9Xs3U2kruoFbMwvSMDctm--

--Sb0iPQjaooPxIRudEbnrm1ciHAgnhFLES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloNftYACgkQHv7KIOw4
HPY1xwf9HQYFvV5i6lphDCEf7WRj/pz6zZr59SK5wSrHpSZLsR+oMNhdj0lANkQR
rhwx35vKiS3+YIGYA9qAl+prNm+1O393QBy8eTEEseu3uKU7n+zGxY9SuFfxtl4p
Fy55XCDyLugRP1E/B+oXv3AWLt899JvvnUR4AaTuYrpfOcuEp+CwPa4saU7WyNP+
MfL+Qc8xnOMawXo+nOAfjHQgqWr/5D4bsRlJzdL06e6G2zGALoF8ucXE0sVmdcEi
sWk19nTv1TUGjM2tIIdeTqS0Rgc9emCE+6L6D9AXJrl9t1VePj0WzLLMLBIRfeyM
pdYupvxaDCx7TNEHN4b5Y1idW4O1pQ==
=9Ern
-----END PGP SIGNATURE-----

--Sb0iPQjaooPxIRudEbnrm1ciHAgnhFLES--
