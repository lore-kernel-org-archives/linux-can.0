From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH] can: m_can: add support for one shot mode
Date: Thu, 3 Oct 2019 09:17:32 +0530
Message-ID: <010501d5799d$4b372830$e1a57890$@samsung.com>
References: <CGME20190925114609epcas5p305e259619c7fe8cdc75d9fd27f34e758@epcas5p3.samsung.com>
        <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569411904-6319-1-git-send-email-pankj.sharma@samsung.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, 'Sriram Dash' <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

Gentle Ping

> -----Original Message-----
> From: Pankaj Sharma <pankj.sharma=40samsung.com>
> Subject: =5BPATCH=5D can: m_can: add support for one shot mode
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
>  drivers/net/can/m_can/m_can.c =7C 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index deb274a19ba0..e7165404ba8a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> =40=40 -150,6 +150,7 =40=40 enum m_can_mram_cfg =7B
>  =23define CCCR_CME_CANFD_BRS	0x2
>  =23define CCCR_TXP		BIT(14)
>  =23define CCCR_TEST		BIT(7)
> +=23define CCCR_DAR		BIT(6)
>  =23define CCCR_MON		BIT(5)
>  =23define CCCR_CSR		BIT(4)
>  =23define CCCR_CSA		BIT(3)
> =40=40 -1123,7 +1124,7 =40=40 static void m_can_chip_config(struct net_de=
vice
> *dev)
>  	if (priv->version =3D=3D 30) =7B
>  	/* Version 3.0.x */
>=20
> -		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C
> +		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C CCCR_DAR =7C
>  			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) =7C
>  			(CCCR_CME_MASK << CCCR_CME_SHIFT));
>=20
> =40=40 -1133,7 +1134,7 =40=40 static void m_can_chip_config(struct net_de=
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
>  		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) =40=40 -
> 1153,6 +1154,10 =40=40 static void m_can_chip_config(struct net_device *d=
ev)
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		cccr =7C=3D CCCR_MON;
>=20
> +	/* Disable Auto Retransmission (all versions) */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		cccr =7C=3D CCCR_DAR;
> +
>  	/* Write config */
>  	m_can_write(priv, M_CAN_CCCR, cccr);
>  	m_can_write(priv, M_CAN_TEST, test);
> =40=40 -1291,7 +1296,8 =40=40 static int m_can_dev_setup(struct platform_=
device
> *pdev, struct net_device *dev,
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK =7C
>  					CAN_CTRLMODE_LISTENONLY =7C
>  					CAN_CTRLMODE_BERR_REPORTING =7C
> -					CAN_CTRLMODE_FD;
> +					CAN_CTRLMODE_FD =7C
> +					CAN_CTRLMODE_ONE_SHOT;
>=20
>  	/* Set properties depending on M_CAN version */
>  	switch (priv->version) =7B
> --
> 2.17.1
