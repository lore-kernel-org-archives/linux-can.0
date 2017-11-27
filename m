From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak/pci: fix potential bug when probe() fails
Date: Mon, 27 Nov 2017 15:16:25 +0100
Message-ID: <1a5a00a0-e7a0-ec0d-2782-5ce68fb5fbda@pengutronix.de>
References: <20171123144435.12282-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bFlCwSuSdpI4bOdDxVsvUjd2j7NkUkdpx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39049 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752682AbdK0OQd (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Mon, 27 Nov 2017 09:16:33 -0500
In-Reply-To: <20171123144435.12282-1-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bFlCwSuSdpI4bOdDxVsvUjd2j7NkUkdpx
Content-Type: multipart/mixed; boundary="LC4DvWq3Wg7uRL9jNrF1AQWSPwcr17P57";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <1a5a00a0-e7a0-ec0d-2782-5ce68fb5fbda@pengutronix.de>
Subject: Re: [PATCH] can: peak/pci: fix potential bug when probe() fails
References: <20171123144435.12282-1-s.grosjean@peak-system.com>
In-Reply-To: <20171123144435.12282-1-s.grosjean@peak-system.com>

--LC4DvWq3Wg7uRL9jNrF1AQWSPwcr17P57
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 03:44 PM, Stephane Grosjean wrote:
> PCI/PCIe drivers for PEAK-System CAN/CAN-FD interfaces do some access t=
o the
> PCI config during probing. In case one of these accesses fails, a POSIT=
IVE
> PCIBIOS_xxx error code is returned back. This POSITIVE error code MUST =
be
> converted into a NEGATIVE errno for the probe() function to indicate it=

> failed. Using the pcibios_err_to_errno() function, we make sure that th=
e
> return code will always be negative.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LC4DvWq3Wg7uRL9jNrF1AQWSPwcr17P57--

--bFlCwSuSdpI4bOdDxVsvUjd2j7NkUkdpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlocHjkACgkQHv7KIOw4
HPaucQf/RSjLHhm9UoZgEQs2VTkkyttuhBXBLwBvdE8fVNtPL/2dxLWnCvKe3p84
5gFe0W2WVKfqVV5SrfqcGxwRDNcffvzYmTq9q4ueFcnTiOAP3CjXUqrl/dkCpWKp
my9az2X6ZBwPaZrpHpDAr1+HjYy/5WcU/lTjBFqhOEjQc5l1AAYCEa8X5dnJizLr
kn7i97u51kgVz3yadnXg50aovYiX/9tJ1+fDtZVl4ZOMZQhbIz9F+1EYUrVn9YOL
c97WUom2HVTHaHB1XxA5os35457sAn6TrLFdmYaDlIUHg+nYPtRSYUZEY7Ztn9Bw
02NdSeIowSsyrc8cAZZ9QQPD+Qd/QQ==
=dpMD
-----END PGP SIGNATURE-----

--bFlCwSuSdpI4bOdDxVsvUjd2j7NkUkdpx--
