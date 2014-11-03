From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 07/15] can: rx-fifo: Change to do controller off-load in
 interrupt and NAPI poll
Date: Mon, 3 Nov 2014 13:44:12 +0100
Message-ID: <20141103134412.60107f15@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-8-git-send-email-david@protonic.nl>
	<20141019220909.GC428@pengutronix.de>
	<20141020090613.63044885@archvile>
	<54576299.6080907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4297 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaKCMnk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:43:40 -0500
In-Reply-To: <54576299.6080907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 03 Nov 2014 12:10:17 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/20/2014 09:06 AM, David Jander wrote:
> >>> +static int can_rx_fifo_napi_poll(struct napi_struct *napi, int quota)
> >>> +{
> >>> +	struct can_rx_fifo *fifo = container_of(napi, struct
> >>> can_rx_fifo, napi);
> >>> +	int work_done = 0;
> >>> +	int ret;
> >>> +	unsigned int head;
> >>> +	unsigned int tail;
> >>> +
> >>> +restart_poll:
> >>> +	/* handle mailboxes */
> >>> +	head = smp_load_acquire(&fifo->ring_head);
> >>> +	tail = fifo->ring_tail;
> >>> +	while ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
> >>> +			(work_done < quota)) {
> >>> +		ret = can_rx_fifo_read_napi_frame(fifo, tail);
> >>> +		work_done += ret;
> >>> +		tail = (tail + 1) & (fifo->ring_size -1);
> >>> +		smp_store_release(&fifo->ring_tail, tail);
> >>> +	}
> >>> +
> >>> +	if (work_done < quota) {
> >>> +		napi_complete(napi);
> >>> +
> >>> +		/* Check if there was another interrupt */
> >>> +		head = smp_load_acquire(&fifo->ring_head);
> >>> +		if ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
> >>> +		    napi_reschedule(&fifo->napi))
> >>> +			goto restart_poll;
> >>
> >> Hmmm, this looks a bit strange. If I understand the code correctly you ask
> >> that napi should be started again, but then jump directly to the
> >> beginning.
> > 
> > The documentation seems to say that one should use it like that:
> > 
> > http://www.linuxfoundation.org/collaborate/workgroups/networking/napi
> 
> Some drivers do it this way, other don't.
> 
> > If you still think it is wrong, then tell me how to re-enable napi and
> > continue correctly. AFAIK it is done like this in order to avoid a race
> > when the interrupt is called while NAPI polling was underway.
> > napi_schedule() just sets a flag, and does _not_ add work to a queue...
> 
> I think your code is correct. There are several aspects to it, as far as
> I understand the NAPI code:
> - NAPI_STATE_SCHED means a poll is scheduled
> - napi_reschedule(): if NAPI_STATE_SCHED is already set it will return
>   false. Otherwise NAPI_STATE_SCHED will be set and a sofirq will be
>   raised, true is returned.
> - I think the "goto restart_poll" is an optimisation, as the softirq
>   will schedule the poll function again. But AFAICS it's fine, as
>   napi_complete() checks for NAPI_STATE_SCHED set.
> - The above code is needed for devices on an edge triggered interrupt
>   line. As there is a race window between checking the RX buffer and
>   enabling the interrupt line. As we don't have an interrupt here at
>   all, we must have this code. Good work!

Exactly. Thanks!

> >>> +	}
> >>> +
> >>> +	return work_done;
> >>> +}
> >>> +
> >>>  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
> >>>  {
> >>> +	unsigned int weight;
> >>>  	fifo->dev = dev;
> >>>  
> >>>  	if ((fifo->low_first < fifo->high_first) &&
> >>> -	    (fifo->high_first < fifo->high_last))
> >>> +	    (fifo->high_first < fifo->high_last)) {
> >>>  		fifo->inc = true;
> >>> -	else if ((fifo->low_first > fifo->high_first) &&
> >>> -		 (fifo->high_first > fifo->high_last))
> >>> +		weight = fifo->high_last - fifo->low_first;
> >>> +	} else if ((fifo->low_first > fifo->high_first) &&
> >>> +		 (fifo->high_first > fifo->high_last)) {
> >>>  		fifo->inc = false;
> >>> -	else
> >>> +		weight = fifo->low_first - fifo->high_last;
> >>> +	} else
> >>>  		return -EINVAL;
> >>
> >> Please but { } at every branch of the if else.
> > 
> > Ok, will do.
> > 
> >>>  
> >>> -	if (!fifo->read_pending || !fifo->mailbox_enable_mask ||
> >>> -	    !fifo->mailbox_disable || !fifo->mailbox_receive)
> >>> +	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer
> >>> ||
> >>> +	    !fifo->mailbox_enable)
> >>>  		return -EINVAL;
> >>>  
> >>> +	/* Make ring-buffer a sensible size that is a power of 2 */
> >>> +	fifo->ring_size = (2 << fls(weight));
> >>> +	fifo->ring = kzalloc(sizeof(struct can_frame) * fifo->ring_size,
> >>> +			     GFP_KERNEL);
> >>> +	if (!fifo->ring)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	fifo->ring_head = fifo->ring_tail = 0;
> >>> +
> >>> +	/* Take care of NAPI handling */
> >>> +	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
> >>
> >> I'm not sure, if the rx-fifo should take care of the whole NAPI, I think
> >> it's better to provide helper functions instead.
> > 
> > Why not? We are removing the messages from the CAN controller in the IRQ
> > already, so why would the CAN driver have to even care about NAPI which
> > happens _after_ all that? Can you come up with an example where this may
> > not be desirable?
> 
> If NAPI is handled by the rx-fifo exclusively, everything else i.e.
> tx-complete and error handling cannot be done in NAPI. Thinking more
> about this and looking at the above discussed code, maybe it's better to
> have the napi in the rx-fifo code.

Ok, so we keep it there...

> > Can you illustrate your idea with helper functions?
> 
> Something like can_rx_fifo_napi_poll() would be our helper function,
> it's supposed to be called from the NAPI handler the driver has
> registered. But the driver has to take care about the napi_complete()
> and napi_reschedule(), which is probably quite fragile.... So keep it as
> it is.

That's what I thought too.

> > 
> >>> +
> >>>  	/* init variables */
> >>>  	fifo->mask_low = can_rx_fifo_mask_low(fifo);
> >>>  	fifo->mask_high = can_rx_fifo_mask_high(fifo);
> >>> -	fifo->next = fifo->low_first;
> >>> +	fifo->second_first = false;
> >>>  	fifo->active = fifo->mask_low | fifo->mask_high;
> >>>  	fifo->mailbox_enable_mask(fifo, fifo->active);
> >>>  
> >>> @@ -338,60 +420,95 @@ int can_rx_fifo_add(struct net_device *dev, struct
> >>> can_rx_fifo *fifo) }
> >>>  EXPORT_SYMBOL_GPL(can_rx_fifo_add);
> >>>  
> >>> -int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
> >>> +static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo
> >>> *fifo, unsigned int n) +{
> >>> +	unsigned int head = fifo->ring_head;
> >>> +	unsigned int tail = ACCESS_ONCE(fifo->ring_tail);
> >>> +	unsigned int ret = 0;
> >>> +
> >>> +	if (CIRC_SPACE(head, tail, fifo->ring_size) >= 1) {
> >>> +		ret = fifo->mailbox_move_to_buffer(fifo,
> >>> &fifo->ring[head], n);
> >>> +		if (ret)
> >>> +			smp_store_release(&fifo->ring_head,
> >>> +				(head + 1) & (fifo->ring_size - 1));
> >>> +	} else {
> >>> +		ret = fifo->mailbox_move_to_buffer(fifo,
> >>> &fifo->overflow, n);
> >>> +		if (ret)
> >>> +			fifo->dev->stats.rx_dropped++;
> >>> +	}
> >>
> >> That's the purpose of the overflow mailbox? fifo-> overflow seems to be
> >> write only?
> > 
> > Yes.
> > The idea is to simplify the code for the user. mailbox_move_to_buffer()
> > should just move the corresponding can message to the provided buffer and
> > do all interrupt-flag clearing and stuff the driver needs to do in order
> > to free the MB. Its just that in the case we don't have space in the
> > circular buffer, I don't want to complicate things for the driver and tell
> > him that this message should be discarded. Just think of fifo->overflow as
> > a sort of /dev/null. Of course I could just pass NULL to that function,
> > but IMHO that's dangerous because since it happens only very seldom, a
> > missing check for NULL in that function may bite you when it is already
> > too late (i.e. the driver already hit mainline).
> 
> Okay, got it, nice idea. Can you put a comment in the struct rx-fifo.
> Can you also document the requirements on the mailbox_move_to_buffer()
> callback, I remember you've written this in some email....

Ok, will do. It might take a few days until I can post the next version
unfortunately....

Best regards,

-- 
David Jander
Protonic Holland.
