From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH v3] can: m_can: add support for handling arbitration
 error
Date: Wed, 6 Nov 2019 11:29:24 +0530
Message-ID: <01db01d59467$597156c0$0c540440$@samsung.com>
References: <CGME20191030114039epcas5p434c9a7ffb715f2af2f4d3745239b5bbd@epcas5p4.samsung.com>
        <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: mkl@pengutronix.de, wg@grandegger.com
Cc: davem@davemloft.net, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com, 'Sriram Dash' <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Gentle Ping=21

> From: Pankaj Sharma <pankj.sharma=40samsung.com>
> Subject: =5BPATCH v3=5D can: m_can: add support for handling arbitration =
error
>=20
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to dete=
ct
> Protocol error in arbitration phase.
>=20
> Transmit error statistics is currently not updated from the MCAN driver.
> Protocol error in arbitration phase is a TX error and the network statist=
ics should
> be updated accordingly.
>=20
> The member =22tx_error=22 of =22struct net_device_stats=22 should be incr=
emented as
> arbitration is a transmit protocol error. Also =22arbitration_lost=22 of =
=22struct
> can_device_stats=22 should be incremented to report arbitration lost.
>=20
> Signed-off-by: Pankaj Sharma <pankj.sharma=40samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> ---
>=20
> changes in v3:
> - handle arbitration lost stats even if the allocation of the skb fails
>=20
> changes in v2:
> - common m_can_ prefix for is_protocol_err function
> - handling stats even if the allocation of the skb fails
> - resolving build errors on net-next branch
>=20
>  drivers/net/can/m_can/m_can.c =7C 42
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 75e7490c4299..02c5795b7393 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> =40=40 -778,6 +778,43 =40=40 static inline bool is_lec_err(u32 psr)
>  	return psr && (psr =21=3D LEC_UNUSED);
>  =7D
>=20
> +static inline bool m_can_is_protocol_err(u32 irqstatus) =7B
> +	return irqstatus & IR_ERR_LEC_31X;
> +=7D
> +
> +static int m_can_handle_protocol_error(struct net_device *dev, u32
> +irqstatus) =7B
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	/* propagate the error condition to the CAN stack */
> +	skb =3D alloc_can_err_skb(dev, &cf);
> +
> +	/* update tx error stats since there is protocol error */
> +	stats->tx_errors++;
> +
> +	/* update arbitration lost status */
> +	if (cdev->version >=3D 31 && (irqstatus & IR_PEA)) =7B
> +		netdev_dbg(dev, =22Protocol error in Arbitration fail=5Cn=22);
> +		cdev->can.can_stats.arbitration_lost++;
> +		if (skb) =7B
> +			cf->can_id =7C=3D CAN_ERR_LOSTARB;
> +			cf->data=5B0=5D =7C=3D CAN_ERR_LOSTARB_UNSPEC;
> +		=7D
> +	=7D
> +
> +	if (unlikely(=21skb)) =7B
> +		netdev_dbg(dev, =22allocation of skb failed=5Cn=22);
> +		return 0;
> +	=7D
> +	netif_receive_skb(skb);
> +
> +	return 1;
> +=7D
> +
>  static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus=
,
>  				   u32 psr)
>  =7B
> =40=40 -792,6 +829,11 =40=40 static int m_can_handle_bus_errors(struct ne=
t_device
> *dev, u32 irqstatus,
>  	    is_lec_err(psr))
>  		work_done +=3D m_can_handle_lec_err(dev, psr & LEC_UNUSED);
>=20
> +	/* handle protocol errors in arbitration phase */
> +	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> +	    m_can_is_protocol_err(irqstatus))
> +		work_done +=3D m_can_handle_protocol_error(dev, irqstatus);
> +
>  	/* other unproccessed error interrupts */
>  	m_can_handle_other_err(dev, irqstatus);
>=20
> --
> 2.17.1
