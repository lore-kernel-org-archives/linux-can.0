From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCAN-PCIe FD & mcba_usb mainline status?
Date: Mon, 6 Mar 2017 08:41:32 +0100
Message-ID: <3f8f48c1-1195-ffb9-3164-06805271a629@pengutronix.de>
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GAaM4J9aOV8u4v1MHuoRgJO0rMEAU7OHW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43605 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752620AbdCFHl6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Mar 2017 02:41:58 -0500
In-Reply-To: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GAaM4J9aOV8u4v1MHuoRgJO0rMEAU7OHW
Content-Type: multipart/mixed; boundary="sFOIu2luRhdc8phOX7PIEmchdxFTkU14B";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Stephane Grosjean <s.grosjean@peak-system.com>,
 =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Message-ID: <3f8f48c1-1195-ffb9-3164-06805271a629@pengutronix.de>
Subject: Re: PCAN-PCIe FD & mcba_usb mainline status?
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
In-Reply-To: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>

--sFOIu2luRhdc8phOX7PIEmchdxFTkU14B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 08:06 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> these drivers are hanging around since January:
>=20
> [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
> http://marc.info/?l=3Dlinux-can&m=3D148483988920494&w=3D2
>=20
> [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
> http://marc.info/?l=3Dlinux-can&m=3D148534935211400&w=3D2
>=20
> What prevents you from pushing these drivers to mainline?

Resources to review properly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sFOIu2luRhdc8phOX7PIEmchdxFTkU14B--

--GAaM4J9aOV8u4v1MHuoRgJO0rMEAU7OHW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli9Eq8ACgkQHv7KIOw4
HPbVcgf+J8WVvgBbruRNt2H7IdOW7APVqY5UAPucAgPi583QJag99pZ3K6SRlJiG
fSW3yZuExhjR212LEhO8LcR+AhlXzEDXab8YPmVKkR/t0EpxKDyRH1GFbJNMCx0G
07jBYmZS5Wx9pJC+h5i6qXHsHM07dAV1+4NYWsw5A7BRnR5q5GbrNUjPAesNCo+w
9KhWtMRI1yd9lM5TGs5zjCoSKxHhxtW5/2n6M3g5b8UHKfQtUo60oaGsO7ade+Pz
9k/87zp6znQ05mesbOCtpyxUF4I8tyT1UwTFQf5liu7ASt3GI2ma2hCER5Vp9uXs
BtDp6kvaGXdSkH5eWT319p4z+v+Fvg==
=SIPa
-----END PGP SIGNATURE-----

--GAaM4J9aOV8u4v1MHuoRgJO0rMEAU7OHW--
