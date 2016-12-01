From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak: Add support for PCAN-USB X6 USB interface
Date: Thu, 1 Dec 2016 10:35:19 +0100
Message-ID: <7531f825-ff66-3d66-6971-b2bca2bead6a@pengutronix.de>
References: <1480087252-32411-1-git-send-email-s.grosjean@peak-system.com>
 <da984b9d-36fd-6f0c-7337-0ad35c028b4d@hartkopp.net>
 <b050a763-ed2f-6fd7-87ee-a015cc692856@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="F2TKDIQKwcJPcFj1woEbCr9E27dGwHF5M"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32895 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750831AbcLAJ4w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2016 04:56:52 -0500
In-Reply-To: <b050a763-ed2f-6fd7-87ee-a015cc692856@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F2TKDIQKwcJPcFj1woEbCr9E27dGwHF5M
Content-Type: multipart/mixed; boundary="JnianPfPNU1GH0eEsT4ij44xQ1mhwSICl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <7531f825-ff66-3d66-6971-b2bca2bead6a@pengutronix.de>
Subject: Re: [PATCH] can: peak: Add support for PCAN-USB X6 USB interface
References: <1480087252-32411-1-git-send-email-s.grosjean@peak-system.com>
 <da984b9d-36fd-6f0c-7337-0ad35c028b4d@hartkopp.net>
 <b050a763-ed2f-6fd7-87ee-a015cc692856@peak-system.com>
In-Reply-To: <b050a763-ed2f-6fd7-87ee-a015cc692856@peak-system.com>

--JnianPfPNU1GH0eEsT4ij44xQ1mhwSICl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2016 10:30 AM, Stephane Grosjean wrote:
> You're welcome Oliver, thanks for your tested-by... *BUT*:
>=20
> We've got another patch to submit, and this patch fixes the bittiming=20
> ranges defined for the CAN-FD adapters, because current definition of=20
> some of these fields is actually obsolete and should be enlarged.
>=20
> So, what's the best way to proceed?
>=20
> 1 - submit the fix (for supported USB adapters) before adding the=20
> (fixed) patch adding support of the PCAN-USB X6,

Yes please.

> 2 - submit a (deliberately wrong) patch adding support of the new=20
> adapter, then submitting a path that fixes ALL the CAN-FD USB adapters
>=20
> Both fix and add patches will be obviously submitted by the mean of a=20
> single serie.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JnianPfPNU1GH0eEsT4ij44xQ1mhwSICl--

--F2TKDIQKwcJPcFj1woEbCr9E27dGwHF5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlg/7tkACgkQPTuqJayp
JWp2yggAiGPI1GmaQYthE/Z8GO7Fs1cVKAHG2o5Xh+WIn/R4AbiTWIfyNTXbC1TX
NkbroGvo0yisfhGvvmxZ6Artk+D/rjpEoNO6O/LbE9ygus9THtoWD14PBdDrj9e9
SXX2pDDOkbEZJshwgSJbGhsUP+WmtcP40YGhkuOx4tW1zeSEsDERBswwDtfsayuo
F90LuZmMd4ITKaCR/UXBsv0TOPuwAAwuewa3uFOVm1oH17hOaPysXFfUJYF+Tkc/
Yli7sRtoUTXsA9H3/WqGnee4ps930kQtQZrOVF2tmKVGr2TlYGW2JPgqabdSwpNz
l96zFtyF/eG/zC45B2tw20vSuek75w==
=134+
-----END PGP SIGNATURE-----

--F2TKDIQKwcJPcFj1woEbCr9E27dGwHF5M--
