From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak: Add support for new PCIe/M2 CAN FD interfaces
Date: Fri, 10 Nov 2017 14:08:14 +0100
Message-ID: <234e490b-e065-ce26-e09d-81c0208be04c@pengutronix.de>
References: <20171109134214.29503-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aFaSscNN7lsGiHd1DeL3Efxg84cJKLhDF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34063 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752896AbdKJNIU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 08:08:20 -0500
In-Reply-To: <20171109134214.29503-1-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aFaSscNN7lsGiHd1DeL3Efxg84cJKLhDF
Content-Type: multipart/mixed; boundary="7nuCO6tkirCtpCT8nQ0rvgkj0wIEVpJB7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <234e490b-e065-ce26-e09d-81c0208be04c@pengutronix.de>
Subject: Re: [PATCH] can: peak: Add support for new PCIe/M2 CAN FD interfaces
References: <20171109134214.29503-1-s.grosjean@peak-system.com>
In-Reply-To: <20171109134214.29503-1-s.grosjean@peak-system.com>

--7nuCO6tkirCtpCT8nQ0rvgkj0wIEVpJB7
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 02:42 PM, Stephane Grosjean wrote:
> This adds support for the following PEAK-System CAN FD interfaces:
>=20
> PCAN-cPCIe FD         CAN FD Interface for cPCI Serial (2 or 4 channels=
)
> PCAN-PCIe/104-Express CAN FD Interface for PCIe/104-Express (1, 2 or 4 =
ch.)
> PCAN-miniPCIe FD      CAN FD Interface for PCIe Mini (1, 2 or 4 channel=
s)
> PCAN-PCIe FD OEM      CAN FD Interface for PCIe OEM version (1, 2 or 4 =
ch.)
> PCAN-M.2              CAN FD Interface for M.2 (1 or 2 channels)
>=20
> Like the PCAN-PCIe FD interface, all of these boards run the same IP Co=
re
> that is able to handle CAN FD (see also http://www.peak-system.com).
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Added to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7nuCO6tkirCtpCT8nQ0rvgkj0wIEVpJB7--

--aFaSscNN7lsGiHd1DeL3Efxg84cJKLhDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFpL4ACgkQHv7KIOw4
HPaQNwf9H3lg/CI+0BDBGzKUnCKFTjsR+q7g5oX+IUlHMxX5Cchou9sTZsjHzncV
k3uA1Y22X0oufj0MpG2t/XwK5rIBm2uQ5xDfrYNW34rQTyn/+Q3JR41Sfo438D5y
Mb8vQifHslD4+BHIpapiwKhbHKJi4t67bByFFZ/Vs/iykqtcqDdtp6qSNXhqq0VP
1JrV4+E1/athwHJ1ykHkjlYqFl+68pZFOzMfLEYGNnm6Ao9s9U7G6HYCZmDaK+az
qsowdl6OQOB38FZDPQsi75M3Pi11q2zKMC4pkYZ4GKWdjD0dRmUk29BIhhQrzAQ8
L7Wf0REUcYrZA5HwX6kPb85dW1cj6g==
=+Idu
-----END PGP SIGNATURE-----

--aFaSscNN7lsGiHd1DeL3Efxg84cJKLhDF--
