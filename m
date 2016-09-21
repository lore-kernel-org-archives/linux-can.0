From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: ifi: Configure transmitter delay
Date: Wed, 21 Sep 2016 10:36:11 +0200
Message-ID: <c5b00d2d-504f-ee9a-5dcd-d33db0940f72@pengutronix.de>
References: <20160919193401.8320-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QaVkBEEvfmTasKmfKMHOBkIL2l45F85TP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35864 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754783AbcIUIgW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2016 04:36:22 -0400
In-Reply-To: <20160919193401.8320-1-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QaVkBEEvfmTasKmfKMHOBkIL2l45F85TP
Content-Type: multipart/mixed; boundary="62gjCINjoV30qhw8Mxmo5UDrmqFwVqQ8c";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <c5b00d2d-504f-ee9a-5dcd-d33db0940f72@pengutronix.de>
Subject: Re: [PATCH] net: can: ifi: Configure transmitter delay
References: <20160919193401.8320-1-marex@denx.de>
In-Reply-To: <20160919193401.8320-1-marex@denx.de>

--62gjCINjoV30qhw8Mxmo5UDrmqFwVqQ8c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2016 09:34 PM, Marek Vasut wrote:
> Configure the transmitter delay register at +0x1c to correctly handle
> the CAN FD bitrate switch (BRS). This moves the SSP (secondary sample
> point) to a proper offset, so that the TDC mechanism works and won't
> generate error frames on the CAN link.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Wolfgang Grandegger <wg@grandegger.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--62gjCINjoV30qhw8Mxmo5UDrmqFwVqQ8c--

--QaVkBEEvfmTasKmfKMHOBkIL2l45F85TP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX4kZ7AAoJED07qiWsqSVqimsH/jMpGU/GswUCOCkFYgPqxhr8
sAEbUinto3Sks33UOb/BjZwhVK3ehuo4gdMeXiZhaTo4/3DMtVPI17qNg1gKcitF
hxrkKlknUmSbdj7RlNaTTFK2H/Hi0a7DsoJvTnMaxt7HDYlnCSbqEh8wBDqcg+c7
wDY511AhADxJwsgCAHXpW+dqfCxTESVsxRqlKerzhKFDMTd5R0989uLXm2p91XvQ
sxQYiQ86mjbF/sWNdvknI9vDltkJduaWPj9VNWhEByAJJE/BdzEsnKTTEjoWqWdf
NIZ86cj81ti/2MXuMLvxXDiVPzRk3b3bPDN5Q3QY9ephlsp7AVUoK1F3gWg1VfM=
=SIMw
-----END PGP SIGNATURE-----

--QaVkBEEvfmTasKmfKMHOBkIL2l45F85TP--
