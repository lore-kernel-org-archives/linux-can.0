From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
Date: Thu, 23 Nov 2017 10:18:13 +0100
Message-ID: <7244fe2c-173f-be96-8ec5-1f5d78d8ec53@pengutronix.de>
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Rb0AjSNRTeDLuTusdkSNqhUBQ6UblEw0w"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41393 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751755AbdKWJS3 (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Thu, 23 Nov 2017 04:18:29 -0500
In-Reply-To: <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rb0AjSNRTeDLuTusdkSNqhUBQ6UblEw0w
Content-Type: multipart/mixed; boundary="m1kHUK3orOWccj8O6vt8mxMGqnOqi6438";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Sakar Arora <Sakar.Arora@freescale.com>
Message-ID: <7244fe2c-173f-be96-8ec5-1f5d78d8ec53@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
In-Reply-To: <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>

--m1kHUK3orOWccj8O6vt8mxMGqnOqi6438
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 10:09 AM, Pankaj Bansal wrote:
> The FlexCAN driver assumed that FlexCAN controller is big endian for
> powerpc architecture and little endian for other architectures.
>=20
> But this may not be the case. FlexCAN controller can be little or big
> endian on any architecture. For e.g. NXP LS1021A ARM based SOC has big
> endian FlexCAN controller.
>=20
> Therefore, the driver has been modified to add a provision for both
> types of controllers using an additional device tree property. On a
> "fsl,p1010-flexcan" device BE is default, on all other devices LE is.
>=20
> Big Endian controllers should have "big-endian" set in the device tree.=

> check "Documentation/devicetree/bindings/net/can/fsl-flexcan.txt" for
> usage.
>=20
> This is the standard practice followed in linux. for more info check:
> Documentation/devicetree/bindings/common-properties.txt
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>

I'm missing the update of the fsl-flexcan.txt in this series.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--m1kHUK3orOWccj8O6vt8mxMGqnOqi6438--

--Rb0AjSNRTeDLuTusdkSNqhUBQ6UblEw0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWklUACgkQHv7KIOw4
HPYHfAf+M+xN+1wyfQpE1FwTXZHGK4sCqmqOvNciZSkdEfGZ4Ijvl/ZSqWsX3Su8
obx65Wy0PhOJBf6wX1n8ULrxjljZPWI6iYeCzM7e5u8exncG/BSfPItVIf9N5HIn
v0N8Abkg0pCZGX2e3uqPSMPBRHpZAWjtYmXnt1vzFrHAPw8wZX0NzQsuV7wsdlWQ
mC4ky6AhFMcJUL0MaLMDYSkbA3nLD0BxNrJDsR3iXK9C0r8apN90DR8pFaWrO4kt
+QKbs2hqIb/ip9W4JjEeJo0xDIzLGB5qnKibsY3RrJICKW4k17Yb1pPNOEt6GQXm
lJnpEHIYDKmB/8u/ZXF5+qoDTca1Ig==
=Pc8A
-----END PGP SIGNATURE-----

--Rb0AjSNRTeDLuTusdkSNqhUBQ6UblEw0w--
