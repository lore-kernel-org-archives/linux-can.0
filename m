From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
Date: Sun, 5 Mar 2017 12:08:51 +0100
Message-ID: <aea7d9c5-a526-40ec-b412-bc3ba3c839e1@pengutronix.de>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
 <55FA7428.4030801@pengutronix.de> <20150917100617.GB4684@lukather>
 <83349902-ea3d-0a2a-59ee-52b88c9e5c76@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5PpLa6ME5ccif3Dd6ajX7KlreiDH4gfk0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47665 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751003AbdCELI7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Mar 2017 06:08:59 -0500
In-Reply-To: <83349902-ea3d-0a2a-59ee-52b88c9e5c76@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5PpLa6ME5ccif3Dd6ajX7KlreiDH4gfk0
Content-Type: multipart/mixed; boundary="IGdphPeboUeu0rJc84lG8dSTK2MBPk33w";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <aea7d9c5-a526-40ec-b412-bc3ba3c839e1@pengutronix.de>
Subject: Re: [PATCH v8 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
 <55FA7428.4030801@pengutronix.de> <20150917100617.GB4684@lukather>
 <83349902-ea3d-0a2a-59ee-52b88c9e5c76@posteo.de>
In-Reply-To: <83349902-ea3d-0a2a-59ee-52b88c9e5c76@posteo.de>

--IGdphPeboUeu0rJc84lG8dSTK2MBPk33w
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 11:59 AM, Patrick Menschel wrote:
> Hello Marc,
>=20
> I'm refering to this original patch.
>=20
> I just upgraded my two BananaPis to Kernel 4.9.13 and apparently the
> correct Devicetree bindings are still missing in
>=20
> arch/arm/boot/dts/sun7i-a20.dtsi
>=20
> ,so I added them manually.
>=20
> I've done some basic tests and everything works as expected.
>=20
> How is the policy?
> May I write the DT Patch or is this the domain of the original Author?

Feel free to send a patch that adds the CAN devices to all SoCs that
have one.

regrads,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IGdphPeboUeu0rJc84lG8dSTK2MBPk33w--

--5PpLa6ME5ccif3Dd6ajX7KlreiDH4gfk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli78cMACgkQHv7KIOw4
HPab/Af+PkIGjRZ8mxV9PHaHVHNpQFTh6AhS+gC9qW1AB6kW+kmWfhCcbRYBvH9D
VlwSWX6t0f62xyoTCBTNSI7q2P87RCDZoU8U6Yo0gRzcWf8Iku7HcWX76XH0LthF
wiLrd/TRE08fapUPQ89et+e0RalEqVrCE6dlZIAZKdoHB6peTvvDlsrRd0EPzGY/
vrVLVNxzYt0NP5uZMECxmbgQJCjQU4mGoT/FT+etWLZusjUrnPNRGLwwa9OZUEqE
gxrICcvIYuYLpiHVsB0+T1Xa8OrRfBgB8lAflsTAwBeA/YYAULKSD4tc/J5vF1/I
PeVCccYu9l6YHlQ49WQ1lbPHsjM/PQ==
=riJu
-----END PGP SIGNATURE-----

--5PpLa6ME5ccif3Dd6ajX7KlreiDH4gfk0--
