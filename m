From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH v3] can: m_can: add support for one shot mode
Date: Fri, 25 Oct 2019 15:13:57 +0530
Message-ID: <000001d58b18$ba756770$2f603650$@samsung.com>
References: <CGME20191021120513epcas5p2fd23f5dbdff6a0e6aa3b0726b30e4b60@epcas5p2.samsung.com>
        <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de
Cc: davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, 'Sriram Dash' <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

Gentle Ping=21

> From: Pankaj Sharma <pankj.sharma=40samsung.com>
> Subject: =5BPATCH v3=5D can: m_can: add support for one shot mode
>=20
> According to the CAN Specification (see ISO 11898-1:2015, 8.3.4 Recovery
> Management), the M_CAN provides means for automatic retransmission of
> frames that have lost arbitration or that have been disturbed by errors d=
uring
> transmission. By default automatic retransmission is enabled.
>=20
> The Bosch MCAN controller has support for disabling automatic retransmiss=
ion.
>=20
> To support time-triggered communication as described in ISO 11898-1:2015,
> chapter 9.2, the automatic retransmission may be disabled via CCCR.DAR.
>=20
> CAN_CTRLMODE_ONE_SHOT is used for disabling automatic retransmission.
>=20
> Signed-off-by: Pankaj Sharma <pankj.sharma=40samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> ---
>=20
> changes in v3:
> - resolving build errors for net-next branch
>=20
> changes in v2:
> - rebase to net-next
>=20
>  drivers/net/can/m_can/m_can.c =7C 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 562c8317e3aa..75e7490c4299 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> =40=40 -123,6 +123,7 =40=40 enum m_can_reg =7B
>  =23define CCCR_CME_CANFD_BRS	0x2
>  =23define CCCR_TXP		BIT(14)
>  =23define CCCR_TEST		BIT(7)
> +=23define CCCR_DAR		BIT(6)
>  =23define CCCR_MON		BIT(5)
>  =23define CCCR_CSR		BIT(4)
>  =23define CCCR_CSA		BIT(3)
> =40=40 -1135,7 +1136,7 =40=40 static void m_can_chip_config(struct net_de=
vice
> *dev)
>  	if (cdev->version =3D=3D 30) =7B
>  	/* Version 3.0.x */
>=20
> -		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C
> +		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C CCCR_DAR =7C
>  			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) =7C
>  			(CCCR_CME_MASK << CCCR_CME_SHIFT));
>=20
> =40=40 -1145,7 +1146,7 =40=40 static void m_can_chip_config(struct net_de=
vice
> *dev)
>  	=7D else =7B
>  	/* Version 3.1.x or 3.2.x */
>  		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C CCCR_BRSE =7C CCCR_FDOE
> =7C
> -			  CCCR_NISO);
> +			  CCCR_NISO =7C CCCR_DAR);
>=20
>  		/* Only 3.2.x has NISO Bit implemented */
>  		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) =40=40 -
> 1165,6 +1166,10 =40=40 static void m_can_chip_config(struct net_device *d=
ev)
>  	if (cdev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		cccr =7C=3D CCCR_MON;
>=20
> +	/* Disable Auto Retransmission (all versions) */
> +	if (cdev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		cccr =7C=3D CCCR_DAR;
> +
>  	/* Write config */
>  	m_can_write(cdev, M_CAN_CCCR, cccr);
>  	m_can_write(cdev, M_CAN_TEST, test);
> =40=40 -1310,7 +1315,8 =40=40 static int m_can_dev_setup(struct m_can_cla=
ssdev
> *m_can_dev)
>  	m_can_dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK =7C
>  					CAN_CTRLMODE_LISTENONLY =7C
>  					CAN_CTRLMODE_BERR_REPORTING =7C
> -					CAN_CTRLMODE_FD;
> +					CAN_CTRLMODE_FD =7C
> +					CAN_CTRLMODE_ONE_SHOT;
>=20
>  	/* Set properties depending on M_CAN version */
>  	switch (m_can_dev->version) =7B
> --
> 2.17.1
