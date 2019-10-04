From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: m_can: add support for one shot mode
Date: Fri, 4 Oct 2019 22:41:57 +0200
Message-ID: <79c10dd5-0c44-ce70-9cb9-bb61e12362d4@pengutronix.de>
References: <CGME20190925114609epcas5p305e259619c7fe8cdc75d9fd27f34e758@epcas5p3.samsung.com>
 <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KNQy1s7aRV0JZ6kdubpXOlfBA6UqZcVRZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
Sender: netdev-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNQy1s7aRV0JZ6kdubpXOlfBA6UqZcVRZ
Content-Type: multipart/mixed; boundary="C0sk6Yrc1aVlsFK5RaDCUm86gcx4AHX9F";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com,
 ludovic.desroches@microchip.com, pankaj.dubey@samsung.com,
 rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
Message-ID: <79c10dd5-0c44-ce70-9cb9-bb61e12362d4@pengutronix.de>
Subject: Re: [PATCH] can: m_can: add support for one shot mode
References: <CGME20190925114609epcas5p305e259619c7fe8cdc75d9fd27f34e758@epcas5p3.samsung.com>
 <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>

--C0sk6Yrc1aVlsFK5RaDCUm86gcx4AHX9F
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/25/19 1:45 PM, Pankaj Sharma wrote:
> According to the CAN Specification (see ISO 11898-1:2015, 8.3.4
> Recovery Management), the M_CAN provides means for automatic
> retransmission of frames that have lost arbitration or that
> have been disturbed by errors during transmission. By default
> automatic retransmission is enabled.
>=20
> The Bosch MCAN controller has support for disabling automatic
> retransmission.
>=20
> To support time-triggered communication as described in ISO
> 11898-1:2015, chapter 9.2, the automatic retransmission may be
> disabled via CCCR.DAR.
>=20
> CAN_CTRLMODE_ONE_SHOT is used for disabling automatic retransmission.
>=20
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>

The patch does not apply to net-next/master. Please use net-next/master
as a base for patches introducing new features.

I've ported the patch and applied it.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--C0sk6Yrc1aVlsFK5RaDCUm86gcx4AHX9F--

--KNQy1s7aRV0JZ6kdubpXOlfBA6UqZcVRZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2XrpUACgkQWsYho5Hk
nSC4LAf7B4D1ThldgsPxULZ3DKSuz6NzsNyzmfPiB85aempNbun/Jr9BaZxdY1sJ
VwW9wMqfuT6krH2G6NfOW9YCaRboco831q01faLJz6oXoMnH7WO96Zwsb3kcVHn5
suLbiPqDLlobXBQpNMFFN/aBwAhy50v2sRFtgw/m5EMgHDE5928YgnLfEMB2lU97
7gH4yCfc76FVC/RGAqEqqfEARw3QHrs0EoDZSLAYxvCl5sToaUC/OTibdHAuFKuc
g381dbKE+1gRmvyBNc2xAncdxoGGjXcoHQ7vtobX2V/gI/EbR3JyKZQeQGmPdmfu
3QYHjMld48w9XHZCHPS6CwRBk16haw==
=7nvC
-----END PGP SIGNATURE-----

--KNQy1s7aRV0JZ6kdubpXOlfBA6UqZcVRZ--
