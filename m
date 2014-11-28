From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v4 6/6] can: handle bus-off in can_change_state()
Date: Fri, 28 Nov 2014 12:33:29 +0000
Message-ID: <20141128123329.26409.61305@shannon>
References: <d9f1108f-a284-4b48-9bd0-2a5906c954f3@GRBSR0089.marel.net>
 <9cb398d87d94313de88eb421f75735b1@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0053.outbound.protection.outlook.com ([157.55.234.53]:44170
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750984AbaK1Mdk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Nov 2014 07:33:40 -0500
In-Reply-To: <9cb398d87d94313de88eb421f75735b1@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

Quoting Wolfgang Grandegger (2014-11-28 12:21:53)
> On Fri, 28 Nov 2014 12:12:28 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
> > Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> > ---
> >  drivers/net/can/dev.c             |  1 +
> >  drivers/net/can/flexcan.c         |  3 ---
> >  drivers/net/can/mscan/mscan.c     | 11 +++++------
> >  drivers/net/can/sja1000/sja1000.c |  3 ---
> >  4 files changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> > index 3e2da66..17fce72 100644
> > --- a/drivers/net/can/dev.c
> > +++ b/drivers/net/can/dev.c
> > @@ -340,6 +340,7 @@ void can_change_state(struct net_device *dev, struct
> > can_frame *cf,
> >  
> >       if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
> >               cf->can_id |= CAN_ERR_BUSOFF;
> > +             can_bus_off(dev);
> >               return;
> >       }
> >  
> > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > index 9f91735..0823956 100644
> > --- a/drivers/net/can/flexcan.c
> > +++ b/drivers/net/can/flexcan.c
> > @@ -612,9 +612,6 @@ static int flexcan_poll_state(struct net_device
> *dev,
> > u32 reg_esr)
> >  
> >       can_change_state(dev, cf, tx_state, rx_state);
> >  
> > -     if (unlikely(new_state == CAN_STATE_BUS_OFF))
> > -             can_bus_off(dev);
> > -
> >       netif_receive_skb(skb);
> >  
> >       dev->stats.rx_packets++;
> > diff --git a/drivers/net/can/mscan/mscan.c
> b/drivers/net/can/mscan/mscan.c
> > index e36b740..2eb84f1 100644
> > --- a/drivers/net/can/mscan/mscan.c
> > +++ b/drivers/net/can/mscan/mscan.c
> > @@ -362,11 +362,7 @@ static void mscan_get_err_frame(struct net_device
> > *dev, struct can_frame *frame,
> >  
> >       new_state = get_new_state(dev, canrflg);
> >       if (new_state != priv->can.state) {
> > -             can_change_state(dev, frame,
> > -                              state_map[MSCAN_STATE_TX(canrflg)],
> > -                              state_map[MSCAN_STATE_RX(canrflg)]);
> > -
> > -             if (priv->can.state == CAN_STATE_BUS_OFF) {
> > +             if (new_state == CAN_STATE_BUS_OFF) {
> >                       /*
> >                        * The MSCAN on the MPC5200 does recover from bus-off
> >                        * automatically. To avoid that we stop the chip doing
> > @@ -378,8 +374,11 @@ static void mscan_get_err_frame(struct net_device
> > *dev, struct can_frame *frame,
> >                               setbits8(&regs->canctl0,
> >                                        MSCAN_SLPRQ | MSCAN_INITRQ);
> >                       }
> > -                     can_bus_off(dev);
> >               }
> > +
> > +             can_change_state(dev, frame,
> > +                              state_map[MSCAN_STATE_TX(canrflg)],
> > +                              state_map[MSCAN_STATE_RX(canrflg)]);
> >       }
> >       priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
> >       frame->can_dlc = CAN_ERR_DLC;
> > diff --git a/drivers/net/can/sja1000/sja1000.c
> > b/drivers/net/can/sja1000/sja1000.c
> > index 32bd7f4..37b6392 100644
> > --- a/drivers/net/can/sja1000/sja1000.c
> > +++ b/drivers/net/can/sja1000/sja1000.c
> > @@ -479,9 +479,6 @@ static int sja1000_err(struct net_device *dev,
> uint8_t
> > isrc, uint8_t status)
> >               rx_state = txerr <= rxerr ? state : 0;
> >  
> >               can_change_state(dev, cf, tx_state, rx_state);
> > -
> > -             if(state == CAN_STATE_BUS_OFF)
> > -                     can_bus_off(dev);
> 
> Ah, no, that's wrong because not all devices use this function. I thought
> just moving the counter incrementation out of can_bus_off() back to
> the driver (for all drivers not yet using can_change_state). Sorry for
> confusion.

There wasn't any confusion. I just felt like this might be a good idea, so I
included it. Turns out it isn't. It's a separate patch, so it can be easily
omitted.

What you described is in patch 5.

--
Andri.
