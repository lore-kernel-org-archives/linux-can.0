From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 18:40:06 +0800
Message-ID: <20140715104005.GA3837@shlinux1.ap.freescale.net>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com>
 <1405338041-19945-2-git-send-email-b29396@freescale.com>
 <53C3C97A.7080102@pengutronix.de>
 <20140715033324.GC21584@shlinux1.ap.freescale.net>
 <53C4D872.9060707@pengutronix.de>
 <20140715082637.GA2601@shlinux1.ap.freescale.net>
 <53C4EA68.5090606@pengutronix.de>
 <20140715090719.GA3374@shlinux1.ap.freescale.net>
 <53C4F2B5.7050704@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:27919
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758690AbaGOKpO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Jul 2014 06:45:14 -0400
Content-Disposition: inline
In-Reply-To: <53C4F2B5.7050704@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com

On Tue, Jul 15, 2014 at 11:21:57AM +0200, Marc Kleine-Budde wrote:
> On 07/15/2014 11:07 AM, Dong Aisheng wrote:
> > On Tue, Jul 15, 2014 at 10:46:32AM +0200, Marc Kleine-Budde wrote:
> >> On 07/15/2014 10:26 AM, Dong Aisheng wrote:
> >>>>>>> +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> >>>>>>> +			    u32 rxfs)
> >>>>>>> +{
> >>>>>>> +	struct m_can_priv *priv = netdev_priv(dev);
> >>>>>>> +	u32 flags, fgi;
> >>>>>>> +
> >>>>>>> +	/* calculate the fifo get index for where to read data */
> >>>>>>> +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> >>>>>>> +	flags = m_can_fifo_read(priv, fgi, 0x0);
> >>>>>>                                            ^^^
> >>>>>>
> >>>>>> Can you introduce an enum for the offsets, please adjust the signature
> >>>>>> of m_can_fifo_read() accordingly.
> >>>>>>
> >>>>>
> >>>>> I wonder enum may not be suitable.
> >>>>> The Rx Buffer and FIFO Element is as follows:
> >>>>>    31 24 23 16 15 8 7 0
> >>>>> R0 ESI XTD RTR ID[28:0]
> >>>>
> >>>> M_CAN_FIFO_ID
> >>>>
> >>>>> R1 ANMF FIDX[6:0] res EDL BRS DLC[3:0] RXTS[15:0]
> >>>>
> >>>> M_CAN_FIFO_DLC
> >>>>
> >>>>> R2 DB3[7:0] DB2[7:0] DB1[7:0] DB0[7:0]
> >>>>> R3 DB7[7:0] DB6[7:0] DB5[7:0] DB4[7:0]
> >>>>
> >>>> M_CAN_FIFO_DATA0
> >>>> M_CAN_FIFO_DATA1
> >>>>
> >>>
> >>> You mean as follows?
> >>> enum m_can_fifo {
> >>>         M_CAN_FIFO_ID = 0,
> >>>         M_CAN_FIFO_DLC,
> >> = 0x4,
> >>>         M_CAN_FIFO_DATA0,
> >> = 0x8,
> >>>         M_CAN_FIFO_DATA1,
> >> = 0xc,
> >>> };
> >>>
> >>> static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
> >>>                                   u32 fgi, enum m_can_fifo fifo)
> >>> {
> >>>         return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
> >>>                      fgi * RXF0_ELEMENT_SIZE + fifo * 0x4);
> >>> }
> >>
> >> without the * 0x4
> >>
> >>> id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
> >>>
> >>> The problem is when adding long frames support, it becomes:
> >>> enum m_can_fifo {
> >>>         M_CAN_FIFO_ID = 0,
> >>>         M_CAN_FIFO_DLC,
> >>>         M_CAN_FIFO_DATA0,
> >>>         M_CAN_FIFO_DATA1,
> >>>         ....
> >>>         M_CAN_FIFO_DATA15,
> >>> };
> >>
> >> #define M_CAN_FIFO_DATA(n)
> >> 	(enum m_can_fifo)(M_CAN_FIFO_DATA_0 + (n) << 2)
> >>
> > 
> > This is a bit strange using and we may still have to define other M_CAN_FIFO_DATAx
> > to avoid the enum value exceeds the defined range.
> > enum m_can_fifo {
> >         M_CAN_FIFO_ID = 0,
> >         M_CAN_FIFO_DLC = 0x4,
> >         M_CAN_FIFO_DATA0 = 0x8,
> >         M_CAN_FIFO_DATA1 = 0xc,
> > 	....
> >         M_CAN_FIFO_DATA15 = 0xc,
> > };
> > 
> > However, actually we will not use them at all after introducing M_CAN_FIFO_DATA(n).
> > If that, why we still need define them in enum?
> > 
> > Comparing to this way, why not simply just do as follows:
> > #define M_CAN_FIFO_ID		0x0
> > #define M_CAN_FIFO_DLC		0x4
> > #define M_CAN_FIFO_DATA(n)	(0x8 + (n) << 2)
> > 
> > What do you think?
> 
> Looks good.
> 
> > 
> >>> But it's useless because we may not use enum to read fifo data anymore.
> >>> It's not suitable to read fifo one by one:
> >>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA0);
> >>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA1);
> >>> ..
> >>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA15);
> >>>
> >>>
> >>> Instead, we may read data according to real dlc value within a for loop like:
> >>> #define M_CAN_FIFO(n)   (n * 0x4)
> >>> id = m_can_fifo_read(priv, fgi, M_CAN_FIFO(0));
> >>> dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO(1));
> >>> for (i = 0; dlc > 0; dlc -= 0x4, i++) {
> >>>         ....
> >>>         data[i] = m_can_fifo_read(priv, fgi, M_CAN_FIFO(i + 2));
> >>> }
> >>
> >> id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
> >> dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> >> for (i = 0; i <= dlc; i++)
> >> 	data[i] = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA(i));
> > 
> > Does it work?
> > The dlc is in bytes while m_can_fifo_read is read in words.
> 
> Doh! probably not :) But should work with something like this:
> 
> int len = DIV_ROUND_UP(dlc, 4);
> 

Good point!
Will try this when adding canfd format support.

Regards
Dong Aisheng

> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


