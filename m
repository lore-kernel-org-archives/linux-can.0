From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH] can: m_can: add support for handling arbitration error
Date: Thu, 17 Oct 2019 17:21:36 +0530
Message-ID: <000e01d584e1$3cb91c10$b62b5430$@samsung.com>
References: <CGME20191014113437epcas5p2143d7e85d5a50dad79a4a60a9d666fe4@epcas5p2.samsung.com>
        <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
        <00c5c5b7-cc90-ff6c-0c49-77fe0481dac1@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00c5c5b7-cc90-ff6c-0c49-77fe0481dac1@pengutronix.de>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, 'Sriram Dash' <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH=5D can: m_can: add support for handling arbitration=
 error
>=20
> On 10/14/19 1:34 PM, Pankaj Sharma wrote:
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
> >  drivers/net/can/m_can/m_can.c =7C 38
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c
> > b/drivers/net/can/m_can/m_can.c index b95b382eb308..7efafee0eec8
> > 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > =40=40 -778,6 +778,39 =40=40 static inline bool is_lec_err(u32 psr)
> >  	return psr && (psr =21=3D LEC_UNUSED);
> >  =7D
> >
> > +static inline bool is_protocol_err(u32 irqstatus)
>=20
> please add the comon m_can_ prefix

Alright. Will change the name =22is_protocol_err=22 to =22m_can_ is_protoco=
l_err=22

>=20
> > +=7B
> > +	if (irqstatus & IR_ERR_LEC_31X)
> > +		return 1;
> > +	else
> > +		return 0;
> > +=7D
> > +
> > +static int m_can_handle_protocol_error(struct net_device *dev, u32
> > +irqstatus) =7B
> > +	struct net_device_stats *stats =3D &dev->stats;
> > +	struct m_can_priv *priv =3D netdev_priv(dev);
> > +	struct can_frame *cf;
> > +	struct sk_buff *skb;
> > +
> > +	/* propagate the error condition to the CAN stack */
> > +	skb =3D alloc_can_err_skb(dev, &cf);
> > +	if (unlikely(=21skb))
> > +		return 0;
>=20
> please handle the stats, even if the allocation of the skb fails.

Alright. Will do as follows
+       if (unlikely(=21skb)) =7B
+               netdev_dbg(dev, =22allocation of skb failed=5Cn=22);
+               stats->tx_errors++;
+               return 0;
+       =7D

>=20
> > +
> > +	if (priv->version >=3D 31 && (irqstatus & IR_PEA)) =7B
> > +		netdev_dbg(dev, =22Protocol error in Arbitration fail=5Cn=22);
> > +		stats->tx_errors++;
> > +		priv->can.can_stats.arbitration_lost++;
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
> > =40=40 -792,6 +825,11 =40=40 static int m_can_handle_bus_errors(struct
> net_device *dev, u32 irqstatus,
> >  	    is_lec_err(psr))
> >  		work_done +=3D m_can_handle_lec_err(dev, psr & LEC_UNUSED);
> >
> > +	/* handle protocol errors in arbitration phase */
> > +	if ((priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> > +	    is_protocol_err(irqstatus))
> > +		work_done +=3D m_can_handle_protocol_error(dev, irqstatus);
> > +
> >  	/* other unproccessed error interrupts */
> >  	m_can_handle_other_err(dev, irqstatus);
> >
> >
>=20
> Marc
>=20
> --
> Pengutronix e.K.                  =7C Marc Kleine-Budde           =7C
> Industrial Linux Solutions        =7C Phone: +49-231-2826-924     =7C
> Vertretung West/Dortmund          =7C Fax:   +49-5121-206917-5555 =7C
> Amtsgericht Hildesheim, HRA 2686  =7C http://www.pengutronix.de   =7C
