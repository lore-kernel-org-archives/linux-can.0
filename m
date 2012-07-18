From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH v2 3/3] can: janz-ican3: add support for one shot mode
Date: Wed, 18 Jul 2012 11:20:48 -0700
Message-ID: <20120718182047.GB25905@ovro.caltech.edu>
References: <20120713230521.GD4538@ovro.caltech.edu>
 <1342220831-11039-1-git-send-email-iws@ovro.caltech.edu>
 <5005EC57.7030504@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:48464 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab2GRSUx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 14:20:53 -0400
Content-Disposition: inline
In-Reply-To: <5005EC57.7030504@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Wed, Jul 18, 2012 at 12:51:03AM +0200, Marc Kleine-Budde wrote:
> On 07/14/2012 01:07 AM, Ira W. Snyder wrote:
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > The Janz VMOD-ICAN3 hardware has support for one shot packet
> > transmission. This means that a packet will be attempted to be sent
> > once, with no automatic retries.
> > 
> > The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.
> > 
> > Every time a packet transmission failure happens, one packet needs to be
> > dropped from the front of the ECHO queue. This hardware lacks support
> > for TX-error interrupts, and so bus error indications are used as a
> > workaround. Every time a TX bus error is received, we know a packet
> > failed to transmit. If bus error reporting is off, do not forward the
> > bus error packets to userspace.
> 
> Can you please test in normal mode (i.e. non-oneshot-mode) on a proper
> terminated bus without a second CAN station on the bus. Send a single
> CAN message. How does the controller behave? What happens if you then
> add a second member to the bus? Is the original CAN message finally
> received?
> 

I configured the bus like so:
ip link set can0 up type can bitrate 1000000 one-shot off berr-reporting off

And get this output:
21: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 1
    janz-ican3: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

Then I ran:
cangen -n 1 -e -L 8 can0

The candump tool shows the following:
candump -e any,0:0,#FFFFFFFF
  can0  20000004  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
        controller-problem{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
  can0  20000004  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
        controller-problem{tx-error-passive}
        error-counter-tx-rx{{128}{0}}

And the ip tool shows:
21: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
    link/can 
    can state ERROR-PASSIVE restart-ms 0 
    bitrate 1000000 sample-point 0.750 
    tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 1
    janz-ican3: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          1          1          0         
    RX: bytes  packets  errors  dropped overrun mcast   
    0          0        2       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        1822    0       0       0      


After I plug in another CAN station, the bus remains in exactly the same
state. I DO NOT receive the frame I sent, on either the sending station,
nor on the newly connected station. The bus remains in ERROR-PASSIVE
state.

If I send packets with my second CAN station, it starts getting bus
errors. The first CAN station acts as if it has dropped off the bus
completely, so there is no second device on the bus.

The firmware seems to go into some bad state where it will not respond
to control messages at all. It doesn't ever respond to control messages
again until I reset the card (by rmmod + insmod the driver).

> With the scheme "drop frame from echo queue on tx error" in the worst
> case you loose some echo messages, but at least the queue will not overflow.
> 
> > 
> > The rx_bytes and tx_bytes counters were audited to make sure they only
> > reflect actual data bytes received from the bus. They do not include
> > error packets.
> > 
> > The rx_errors and tx_errors counters were audited to make sure they are
> > correct in all situations. Previously, the rx_errors counts were
> > sometimes too high.
> 
> Maybe split the _byte and _error fixes into a seperate patch (both fixes
> can be in the same patch, though).

Ok.

> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> > 
> > This patch should superceed the previous patch posted with this title.
> > 
> >  drivers/net/can/janz-ican3.c |   56 +++++++++++++++++++++++------------------
> >  1 files changed, 31 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> > index 5fff829..fccfc3a 100644
> > --- a/drivers/net/can/janz-ican3.c
> > +++ b/drivers/net/can/janz-ican3.c
> > @@ -116,6 +116,7 @@
> >  #define ICAN3_BUSERR_QUOTA_MAX	255
> >  
> >  /* Janz ICAN3 CAN Frame Conversion */
> > +#define ICAN3_SNGL	0x02
> >  #define ICAN3_ECHO	0x10
> >  #define ICAN3_EFF_RTR	0x40
> >  #define ICAN3_SFF_RTR	0x10
> > @@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
> >  	desc->data[0] |= cf->can_dlc;
> >  	desc->data[1] |= ICAN3_ECHO;
> >  
> > +	/* support single transmission (no retries) mode */
> > +	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> > +		desc->data[1] |= ICAN3_SNGL;
> > +
> 
> Is this a per-CAN-message flag, not controller wide setting?
> (just curious)
> 

Yes, this setting is per-message. The ICAN3_ECHO bit is also
per-message.

> >  	if (cf->can_id & CAN_RTR_FLAG)
> >  		desc->data[0] |= ICAN3_EFF_RTR;
> >  
> > @@ -911,7 +916,6 @@ static void ican3_handle_msglost(struct ican3_dev *mod, struct ican3_msg *msg)
> >  		cf->can_id |= CAN_ERR_CRTL;
> >  		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> >  		stats->rx_errors++;
> > -		stats->rx_bytes += cf->can_dlc;
> >  		netif_rx(skb);
> >  	}
> >  }
> > @@ -928,7 +932,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  	struct net_device *dev = mod->ndev;
> >  	struct net_device_stats *stats = &dev->stats;
> >  	enum can_state state = mod->can.state;
> > -	u8 status, isrc, rxerr, txerr;
> > +	u8 isrc, ecc, status, rxerr, txerr;
> >  	struct can_frame *cf;
> >  	struct sk_buff *skb;
> >  
> > @@ -949,6 +953,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  		return -ENOMEM;
> >  
> >  	isrc = msg->data[0];
> > +	ecc = msg->data[2];
> >  	status = msg->data[3];
> >  	rxerr = msg->data[4];
> >  	txerr = msg->data[5];
> > @@ -959,7 +964,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  		cf->can_id |= CAN_ERR_CRTL;
> >  		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> >  		stats->rx_over_errors++;
> > -		stats->rx_errors++;
> >  	}
> >  
> >  	/* error warning + passive interrupt */
> > @@ -981,11 +985,28 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  
> >  	/* bus error interrupt */
> >  	if (isrc == CEVTIND_BEI) {
> > -		u8 ecc = msg->data[2];
> > -
> >  		dev_dbg(mod->dev, "bus error interrupt\n");
> > +
> > +		/*
> > +		 * This hardware lacks any support other than bus error
> > +		 * messages to determine if the packet transmission failed.
> > +		 *
> > +		 * This is a TX error, so we free an echo skb from the front
> > +		 * of the queue.
> > +		 */
> > +		if ((ecc & ECC_DIR) == 0) {
> 
> maybe:
>     if (!(ecc & ECC_DIR)) {
> then it's consistent with the if (!...)
> 

Ok.

> > +			cf->data[2] |= CAN_ERR_PROT_TX;
> > +			kfree_skb(skb_dequeue(&mod->echoq));
> > +			stats->tx_errors++;
> > +		}
> > +
> > +		/* bus error reporting is off, drop the error skb */
> > +		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
> > +			kfree_skb(skb);
> > +			return 0;
> > +		}
> 
> Can you move the "if there is a tx-bus error, free echo queue" to the
> front and return if bus error reporting is disabled? I don't like the
> idea to alloc a skb and then free it, if it's not needed.
> 

Sure. That sounds good to me.

I will have to duplicate the "ecc & ECC_DIR" check twice in the code:
1) determine if this is a TX bus error to drop the echo packet
2) after error skb allocation, for "cf->data[2] |= CAN_ERR_PROT_TX"

> > +
> >  		mod->can.can_stats.bus_error++;
> > -		stats->rx_errors++;
> >  		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> >  
> >  		switch (ecc & ECC_MASK) {
> > @@ -1004,9 +1025,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  			break;
> >  		}
> >  
> > -		if ((ecc & ECC_DIR) == 0)
> > -			cf->data[2] |= CAN_ERR_PROT_TX;
> > -
> >  		cf->data[6] = txerr;
> >  		cf->data[7] = rxerr;
> >  	}
> > @@ -1031,8 +1049,8 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
> >  	}
> >  
> >  	mod->can.state = state;
> > -	stats->rx_errors++;
> > -	stats->rx_bytes += cf->can_dlc;
> > +	if (!(cf->data[2] & CAN_ERR_PROT_TX))
> > +		stats->rx_errors++;
> >  	netif_rx(skb);
> >  	return 0;
> >  }
> > @@ -1467,19 +1485,6 @@ static int ican3_open(struct net_device *ndev)
> >  		return ret;
> >  	}
> >  
> > -	/* set the bus error generation state appropriately */
> > -	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > -		quota = ICAN3_BUSERR_QUOTA_MAX;
> > -	else
> > -		quota = 0;
> > -
> > -	ret = ican3_set_buserror(mod, quota);
> > -	if (ret) {
> > -		dev_err(mod->dev, "unable to set bus-error\n");
> > -		close_candev(ndev);
> > -		return ret;
> > -	}
> 
> What happened to these two functions? Not needed anymore?
> 

If you look through the initialization ican3_startup_module(), the
ican3_set_buserror() function is still used.

The code above *disables* the hardware from generating bus errors if
CAN_CTRLMODE_BERR_REPORTING is not set. I am now using bus errors to
determine if a TX error happened. They must always be enabled, so this
code was removed.

Thanks for the review,
Ira

> > -
> >  	/* bring the bus online */
> >  	ret = ican3_set_bus_state(mod, true);
> >  	if (ret) {
> > @@ -1791,7 +1796,8 @@ static int __devinit ican3_probe(struct platform_device *pdev)
> >  	mod->can.do_set_mode = ican3_set_mode;
> >  	mod->can.do_get_berr_counter = ican3_get_berr_counter;
> >  	mod->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES
> > -				    | CAN_CTRLMODE_BERR_REPORTING;
> > +				    | CAN_CTRLMODE_BERR_REPORTING
> > +				    | CAN_CTRLMODE_ONE_SHOT;
> >  
> >  	/* find our IRQ number */
> >  	mod->irq = platform_get_irq(pdev, 0);
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


