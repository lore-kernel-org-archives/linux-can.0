From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Mon, 3 Nov 2014 13:51:35 +0100
Message-ID: <20141103135135.10fd4c6f@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-12-git-send-email-david@protonic.nl>
	<545765D8.7090906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4330 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaKCMvC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:51:02 -0500
In-Reply-To: <545765D8.7090906@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 03 Nov 2014 12:24:08 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/10/2014 05:46 PM, David Jander wrote:
> > The interrupt handler should store the error flags if needed and call
> > can_rx_fifo_irq_error() if there was an error flag set. This will trigger
> > a napi-poll that will call poll_can_state() and poll_bus_error()
> > callbacks. Those should handle can state machine and send error frames
> > as needed.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
> >  include/linux/can/dev.h |  9 +++++++++
> >  2 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> > index fc35d28..dac7579 100644
> > --- a/drivers/net/can/dev.c
> > +++ b/drivers/net/can/dev.c
> > @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_struct
> > *napi, int quota) unsigned int tail;
> >  
> >  restart_poll:
> > +	if (work_done < quota)
> > +		work_done += fifo->poll_can_state(fifo);
> > +
> 
> Do we need two callbacks in the poll-loop? I think one should be enough.
> The driver can call as many non-rx related functions as needed then.
> E.g. state change, bus error handling, tx-completion handling, etc...

Ok. I split it into two handlers, because I saw most drivers doing first
state-handling then message reception and last error handling... in this
particular order. If that order is not important, we can use one poll()
function for both state- and error-handling.
In that case... should the poll() handler be called _before_ or _after_
handling the mailboxes?

> What about adding a guard:
> 
> 	if (fifo->poll && work_done < quota)
> 		work_done += fifo->poll(fifo);
> 
> ...so that the poll callback can be NULL.

Ok, good idea.

> >  	/* handle mailboxes */
> >  	head = smp_load_acquire(&fifo->ring_head);
> >  	tail = fifo->ring_tail;
> > @@ -363,14 +366,19 @@ restart_poll:
> >  		smp_store_release(&fifo->ring_tail, tail);
> >  	}
> >  
> > +	if (work_done < quota)
> > +		work_done += fifo->poll_bus_error(fifo);
> > +
> >  	if (work_done < quota) {
> >  		napi_complete(napi);
> >  
> >  		/* Check if there was another interrupt */
> >  		head = smp_load_acquire(&fifo->ring_head);
> > -		if ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
> > -		    napi_reschedule(&fifo->napi))
> > +		if (((CIRC_CNT(head, tail, fifo->ring_size) >= 1) ||
> > +		    fifo->poll_errors) && napi_reschedule(&fifo->napi)) {
> > +			fifo->poll_errors = false;
> >  			goto restart_poll;
> > +		}
> >  	}
> >  
> >  	return work_done;
> > @@ -393,7 +401,8 @@ int can_rx_fifo_add(struct net_device *dev, struct
> > can_rx_fifo *fifo) return -EINVAL;
> >  
> >  	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer ||
> > -	    !fifo->mailbox_enable)
> > +	    !fifo->mailbox_enable || !fifo->poll_bus_error ||
> > +	    !fifo->poll_can_state)
> >  		return -EINVAL;
> >  
> >  	/* Make ring-buffer a sensible size that is a power of 2 */
> > @@ -412,6 +421,7 @@ int can_rx_fifo_add(struct net_device *dev, struct
> > can_rx_fifo *fifo) fifo->mask_low = can_rx_fifo_mask_low(fifo);
> >  	fifo->mask_high = can_rx_fifo_mask_high(fifo);
> >  	fifo->second_first = false;
> > +	fifo->poll_errors = false;
> >  	fifo->active = fifo->mask_low | fifo->mask_high;
> >  	fifo->mailbox_enable_mask(fifo, fifo->active);
> >  
> > @@ -503,6 +513,13 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
> >  }
> >  EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
> >  
> > +void can_rx_fifo_irq_error(struct can_rx_fifo *fifo)
> > +{
> > +	fifo->poll_errors = true;
> > +	can_rx_fifo_napi_schedule(fifo);
> > +}
> > +EXPORT_SYMBOL_GPL(can_rx_fifo_irq_error);
> > +
> >  void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo)
> >  {
> >  	napi_enable(&fifo->napi);
> > diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> > index c49c37b..e1ed6d4 100644
> > --- a/include/linux/can/dev.h
> > +++ b/include/linux/can/dev.h
> > @@ -75,12 +75,15 @@ struct can_rx_fifo {
> >  	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int
> > mb); unsigned int (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
> >  		struct can_frame *frame, unsigned int mb);
> > +	unsigned int (*poll_can_state)(struct can_rx_fifo *rx_fifo);
> > +	unsigned int (*poll_bus_error)(struct can_rx_fifo *rx_fifo);
> >  
> >  	u64 mask_low;
> >  	u64 mask_high;
> >  	u64 active;
> >  
> >  	unsigned int second_first;
> > +	bool poll_errors;
> >  
> >  	bool inc;
> >  
> > @@ -92,6 +95,11 @@ struct can_rx_fifo {
> >  	struct napi_struct napi;
> >  };
> >  
> > +static inline void can_rx_fifo_napi_schedule(struct can_rx_fifo *fifo)
> > +{
> > +	napi_schedule(&fifo->napi);
> > +}
> > +
> >  /*
> >   * get_can_dlc(value) - helper macro to cast a given data length code
> > (dlc)
> >   * to __u8 and ensure the dlc value to be max. 8 bytes.
> > @@ -135,6 +143,7 @@ u8 can_len2dlc(u8 len);
> >  
> >  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
> >  int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
> > +void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
> >  void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
> >  void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
> >  void can_rx_fifo_reset(struct can_rx_fifo *fifo);
> > 
> 
> Marc
> 

Best regards,

-- 
David Jander
Protonic Holland.
