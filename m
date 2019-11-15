From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH v3] can: m_can: add support for one shot mode
Date: Fri, 15 Nov 2019 10:50:54 +0530
Message-ID: <05f701d59b74$7610ecf0$6232c6d0$@samsung.com>
References: <CGME20191021120513epcas5p2fd23f5dbdff6a0e6aa3b0726b30e4b60@epcas5p2.samsung.com>
        <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
        <38ade7ff-0e0c-afe9-a927-17317f0f27b9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <38ade7ff-0e0c-afe9-a927-17317f0f27b9@pengutronix.de>
Content-Language: en-us
Sender: netdev-owner@vger.kernel.org
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, 'Sriram Dash' <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH v3=5D can: m_can: add support for one shot mode
>=20
> On 10/21/19 2:04 PM, Pankaj Sharma wrote:
> > According to the CAN Specification (see ISO 11898-1:2015, 8.3.4
> > Recovery Management), the M_CAN provides means for automatic
> > retransmission of frames that have lost arbitration or that have been
> > disturbed by errors during transmission. By default automatic
> > retransmission is enabled.
> >
> > The Bosch MCAN controller has support for disabling automatic
> > retransmission.
> >
> > To support time-triggered communication as described in ISO
> > 11898-1:2015, chapter 9.2, the automatic retransmission may be
> > disabled via CCCR.DAR.
> >
> > CAN_CTRLMODE_ONE_SHOT is used for disabling automatic retransmission.
> >
> > Signed-off-by: Pankaj Sharma <pankj.sharma=40samsung.com>
> > Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> > ---
> >
> > changes in v3:
> > - resolving build errors for net-next branch
> >
> > changes in v2:
> > - rebase to net-next
> >
> >  drivers/net/can/m_can/m_can.c =7C 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c
> > b/drivers/net/can/m_can/m_can.c index 562c8317e3aa..75e7490c4299
> > 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > =40=40 -123,6 +123,7 =40=40 enum m_can_reg =7B
> >  =23define CCCR_CME_CANFD_BRS	0x2
> >  =23define CCCR_TXP		BIT(14)
> >  =23define CCCR_TEST		BIT(7)
> > +=23define CCCR_DAR		BIT(6)
> >  =23define CCCR_MON		BIT(5)
> >  =23define CCCR_CSR		BIT(4)
> >  =23define CCCR_CSA		BIT(3)
> > =40=40 -1135,7 +1136,7 =40=40 static void m_can_chip_config(struct net_=
device
> *dev)
> >  	if (cdev->version =3D=3D 30) =7B
> >  	/* Version 3.0.x */
> >
> > -		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C
> > +		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C CCCR_DAR =7C
> >  			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) =7C
> >  			(CCCR_CME_MASK << CCCR_CME_SHIFT));
> >
> > =40=40 -1145,7 +1146,7 =40=40 static void m_can_chip_config(struct net_=
device
> *dev)
> >  	=7D else =7B
> >  	/* Version 3.1.x or 3.2.x */
> >  		cccr &=3D =7E(CCCR_TEST =7C CCCR_MON =7C CCCR_BRSE =7C CCCR_FDOE
> =7C
> > -			  CCCR_NISO);
> > +			  CCCR_NISO =7C CCCR_DAR);
> >
> >  		/* Only 3.2.x has NISO Bit implemented */
> >  		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) =40=40 -
> 1165,6
> > +1166,10 =40=40 static void m_can_chip_config(struct net_device *dev)
> >  	if (cdev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> >  		cccr =7C=3D CCCR_MON;
> >
> > +	/* Disable Auto Retransmission (all versions) */
> > +	if (cdev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> > +		cccr =7C=3D CCCR_DAR;
> > +
> >  	/* Write config */
> >  	m_can_write(cdev, M_CAN_CCCR, cccr);
> >  	m_can_write(cdev, M_CAN_TEST, test); =40=40 -1310,7 +1315,8 =40=40
> static
> > int m_can_dev_setup(struct m_can_classdev *m_can_dev)
> >  	m_can_dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK =7C
> >  					CAN_CTRLMODE_LISTENONLY =7C
> >  					CAN_CTRLMODE_BERR_REPORTING =7C
> > -					CAN_CTRLMODE_FD;
> > +					CAN_CTRLMODE_FD =7C
> > +					CAN_CTRLMODE_ONE_SHOT;
> >
> >  	/* Set properties depending on M_CAN version */
> >  	switch (m_can_dev->version) =7B
>=20
> What happens if you have called netif_stop_queue() and the controller was=
 not
> able to send a single frame?
>=20
> What happens to the echo_skb, if the controller was not able to send a fr=
ame?

We are aware of this issue. For this the tx frame errors are to be first ha=
ndled and=20
the error stats should be updated.
Currently in MCAN code Tx errors aren=E2=80=99t=20being=20handled.=20=0D=0A=
We=20are=20working=20on=20this=20issue=20to=20handle=20these=20errors.=20Ar=
bitration=20error=20being=20the=20first=20=0D=0Apatch=20which=20is=20alread=
y=20posted.=20Very=20soon=20will=20be=20posting=20the=20patches=20for=20tx=
=20error=20handling.=20=0D=0A=0D=0A>=20=0D=0A>=20Marc=0D=0A>=20=0D=0A>=20--=
=0D=0A>=20Pengutronix=20e.K.=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=20Marc=20Kleine-Budde=20=20=20=20=20=20=20=20=20=20=20=7C=0D=
=0A>=20Industrial=20Linux=20Solutions=20=20=20=20=20=20=20=20=7C=20Phone:=
=20+49-231-2826-924=20=20=20=20=20=7C=0D=0A>=20Vertretung=20West/Dortmund=
=20=20=20=20=20=20=20=20=20=20=7C=20Fax:=20=20=20+49-5121-206917-5555=20=7C=
=0D=0A>=20Amtsgericht=20Hildesheim,=20HRA=202686=20=20=7C=0D=0A>=20https://=
protect2.fireeye.com/url?k=3De09921cf-bd02ddac-e098aa80-=0D=0A>=200cc47a31c=
dbc-65578a3e12ca03be&u=3Dhttp://www.pengutronix.de/=20=20=20=7C=0D=0A=0D=0A=
=0D=0A
