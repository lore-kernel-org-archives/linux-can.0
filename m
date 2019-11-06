From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: m_can: add support for one shot mode
Date: Wed, 6 Nov 2019 11:34:26 +0100
Message-ID: <38ade7ff-0e0c-afe9-a927-17317f0f27b9@pengutronix.de>
References: <CGME20191021120513epcas5p2fd23f5dbdff6a0e6aa3b0726b30e4b60@epcas5p2.samsung.com>
 <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aeTzOOUikqsVKEOsx0QyyLYXFesD57WRP"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aeTzOOUikqsVKEOsx0QyyLYXFesD57WRP
Content-Type: multipart/mixed; boundary="016AdyxrEnrgKM0NsyoJtaE66CTZDe96W";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com,
 ludovic.desroches@microchip.com, pankaj.dubey@samsung.com,
 rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
Message-ID: <38ade7ff-0e0c-afe9-a927-17317f0f27b9@pengutronix.de>
Subject: Re: [PATCH v3] can: m_can: add support for one shot mode
References: <CGME20191021120513epcas5p2fd23f5dbdff6a0e6aa3b0726b30e4b60@epcas5p2.samsung.com>
 <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>

--016AdyxrEnrgKM0NsyoJtaE66CTZDe96W
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/21/19 2:04 PM, Pankaj Sharma wrote:
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
> ---
>=20
> changes in v3:=20
> - resolving build errors for net-next branch
>=20
> changes in v2:
> - rebase to net-next
>=20
>  drivers/net/can/m_can/m_can.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 562c8317e3aa..75e7490c4299 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -123,6 +123,7 @@ enum m_can_reg {
>  #define CCCR_CME_CANFD_BRS	0x2
>  #define CCCR_TXP		BIT(14)
>  #define CCCR_TEST		BIT(7)
> +#define CCCR_DAR		BIT(6)
>  #define CCCR_MON		BIT(5)
>  #define CCCR_CSR		BIT(4)
>  #define CCCR_CSA		BIT(3)
> @@ -1135,7 +1136,7 @@ static void m_can_chip_config(struct net_device *=
dev)
>  	if (cdev->version =3D=3D 30) {
>  	/* Version 3.0.x */
> =20
> -		cccr &=3D ~(CCCR_TEST | CCCR_MON |
> +		cccr &=3D ~(CCCR_TEST | CCCR_MON | CCCR_DAR |
>  			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
>  			(CCCR_CME_MASK << CCCR_CME_SHIFT));
> =20
> @@ -1145,7 +1146,7 @@ static void m_can_chip_config(struct net_device *=
dev)
>  	} else {
>  	/* Version 3.1.x or 3.2.x */
>  		cccr &=3D ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE |
> -			  CCCR_NISO);
> +			  CCCR_NISO | CCCR_DAR);
> =20
>  		/* Only 3.2.x has NISO Bit implemented */
>  		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> @@ -1165,6 +1166,10 @@ static void m_can_chip_config(struct net_device =
*dev)
>  	if (cdev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		cccr |=3D CCCR_MON;
> =20
> +	/* Disable Auto Retransmission (all versions) */
> +	if (cdev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		cccr |=3D CCCR_DAR;
> +
>  	/* Write config */
>  	m_can_write(cdev, M_CAN_CCCR, cccr);
>  	m_can_write(cdev, M_CAN_TEST, test);
> @@ -1310,7 +1315,8 @@ static int m_can_dev_setup(struct m_can_classdev =
*m_can_dev)
>  	m_can_dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>  					CAN_CTRLMODE_LISTENONLY |
>  					CAN_CTRLMODE_BERR_REPORTING |
> -					CAN_CTRLMODE_FD;
> +					CAN_CTRLMODE_FD |
> +					CAN_CTRLMODE_ONE_SHOT;
> =20
>  	/* Set properties depending on M_CAN version */
>  	switch (m_can_dev->version) {

What happens if you have called netif_stop_queue() and the controller
was not able to send a single frame?

What happens to the echo_skb, if the controller was not able to send a
frame?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--016AdyxrEnrgKM0NsyoJtaE66CTZDe96W--

--aeTzOOUikqsVKEOsx0QyyLYXFesD57WRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3CobIACgkQWsYho5Hk
nSA7sQf/er69fJSsoOBvGBnxpQKBjmWY1mb8W24+ZjzyfK54b6h5XI/PgTebMYZt
O8nrRzTbhV+vTshWwN2ik77LrWDQ/YnfYtqKvz/Tyo1abacbGJKHZpORwY3zQk0t
DXdy0XaktNnf846YGywsj2mBzUXCTClttcsW7mJ0jj0u2cCarrUZzqKgN1fGyE+W
Zw3TtP6XiFSLPFFus4g2DH298EfL3ODPzR8Rz6bboT9p/X+jZl8V30gxjoJBKgye
uuDHXoSLqAqr0YAMIBJ2zt4Rf4zx1omjI3vuXfvstSEUoasatcc8LCA7gKYpmLTS
OifZ8cgIBmG+F/jbOVDG8LsPMZN02g==
=LZVO
-----END PGP SIGNATURE-----

--aeTzOOUikqsVKEOsx0QyyLYXFesD57WRP--
