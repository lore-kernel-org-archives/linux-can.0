From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH v2] can: m_can: add support for handling arbitration
 error
Date: Wed, 30 Oct 2019 11:25:20 +0530
Message-ID: <00dd01d58ee6$a8ce43d0$fa6acb70$@samsung.com>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
        <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
        <89d7b65f-e8cf-9241-5642-ab3446b464a5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <89d7b65f-e8cf-9241-5642-ab3446b464a5@pengutronix.de>
Content-Language: en-us
Sender: netdev-owner@vger.kernel.org
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com, 'Sriram Dash' <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH v2=5D can: m_can: add support for handling arbitrat=
ion error
>=20
> On 10/21/19 2:13 PM, Pankaj Sharma wrote:
> > The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> > detect Protocol error in arbitration phase.
> >
> > Transmit error statistics is currently not updated from the MCAN driver=
.
> > Protocol error in arbitration phase is a TX error and the network
> > statistics should be updated accordingly.
> >
> > The member =22tx_error=22 of =22struct net_device_stats=22 should be
> > incremented as arbitration is a transmit protocol error. Also
> > =22arbitration_lost=22 of =22struct can_device_stats=22 should be incre=
mented
> > to report arbitration lost.
> >
> > Signed-off-by: Pankaj Sharma <pankj.sharma=40samsung.com>
> > Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> > ---
> >
> > changes in v2:
> > - common m_can_ prefix for is_protocol_err function
> > - handling stats even if the allocation of the skb fails
> > - resolving build errors on net-next branch
> >
> >  drivers/net/can/m_can/m_can.c =7C 37
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c
> > b/drivers/net/can/m_can/m_can.c index 75e7490c4299..a736297a875f
> > 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > =40=40 -778,6 +778,38 =40=40 static inline bool is_lec_err(u32 psr)
> >  	return psr && (psr =21=3D LEC_UNUSED);
> >  =7D
> >
> > +static inline bool m_can_is_protocol_err(u32 irqstatus) =7B
> > +	return irqstatus & IR_ERR_LEC_31X;
> > +=7D
> > +
> > +static int m_can_handle_protocol_error(struct net_device *dev, u32
> > +irqstatus) =7B
> > +	struct net_device_stats *stats =3D &dev->stats;
> > +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +	struct can_frame *cf;
> > +	struct sk_buff *skb;
> > +
> > +	/* propagate the error condition to the CAN stack */
> > +	skb =3D alloc_can_err_skb(dev, &cf);
> > +	if (unlikely(=21skb)) =7B
> > +		netdev_dbg(dev, =22allocation of skb failed=5Cn=22);
> > +		stats->tx_errors++;
> > +		return 0;
> > +	=7D
> > +	if (cdev->version >=3D 31 && (irqstatus & IR_PEA)) =7B
> > +		netdev_dbg(dev, =22Protocol error in Arbitration fail=5Cn=22);
> > +		stats->tx_errors++;
> > +		cdev->can.can_stats.arbitration_lost++;
>=20
> If the skb allocation fails, you miss the stats here.

Alright. We shall handle the stats even when skb fails.=20
Shall post in upcoming revision.

>=20
> > +		cf->can_id =7C=3D CAN_ERR_LOSTARB;
> > +		cf->data=5B0=5D =7C=3D CAN_ERR_LOSTARB_UNSPEC;
> > +	=7D
> > +
> > +	netif_receive_skb(skb);
> > +
> > +	return 1;
> > +=7D
> > +
> >  static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstat=
us,
> >  				   u32 psr)
> >  =7B
> > =40=40 -792,6 +824,11 =40=40 static int m_can_handle_bus_errors(struct
> net_device *dev, u32 irqstatus,
> >  	    is_lec_err(psr))
> >  		work_done +=3D m_can_handle_lec_err(dev, psr & LEC_UNUSED);
> >
> > +	/* handle protocol errors in arbitration phase */
> > +	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> > +	    m_can_is_protocol_err(irqstatus))
> > +		work_done +=3D m_can_handle_protocol_error(dev, irqstatus);
> > +
> >  	/* other unproccessed error interrupts */
> >  	m_can_handle_other_err(dev, irqstatus);
>=20
> Marc
>=20
> --
> Pengutronix e.K.                  =7C Marc Kleine-Budde           =7C
> Industrial Linux Solutions        =7C Phone: +49-231-2826-924     =7C
> Vertretung West/Dortmund          =7C Fax:   +49-5121-206917-5555 =7C
> Amtsgericht Hildesheim, HRA 2686  =7C
> https://protect2.fireeye.com/url?k=3Dcb5c4e6130fb99cd.cb5dc52e-
> 7d616d604aa6cbcf&u=3Dhttp://www.pengutronix.de   =7C
