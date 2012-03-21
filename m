From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 13:08:46 +0100
Message-ID: <20120321120846.GB3372@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
 <20120321110502.GA3372@vandijck-laurijssen.be>
 <4F69BEE3.2040705@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:61141 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab2CUMIt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Mar 2012 08:08:49 -0400
Content-Disposition: inline
In-Reply-To: <4F69BEE3.2040705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 12:43:31PM +0100, Marc Kleine-Budde wrote:
> On 03/21/2012 12:05 PM, Kurt Van Dijck wrote:
> > Hi Sebastian,
> > 
> > On the ICC, Bosch presentend CANFD[1].
> > I'll share my interpretation:
> > * CANFD is meant as a successor of CAN.
> > * it addressess data throughput in 2 ways:
> >   - higher data bitrate for data using a second
> >     set of bittimings.
> >   - longer message payload (up to 64 byte).
> > * it remains very compatible to CAN, although _NOT_
> >   bus-compatible (ie. you put it on a seperate bus).
> 
> This means:
> You cannot have a Bus using one (or more) of the CAN-FD features with
> non CAN-FD compatible nodes.
> 
> From my point of view this can be translated into a new property in
> "can.ctrlmode_supported". A device adds "CAN_CTRLMODE_CANFD" if it
> supports CAN FD mode. Then it's a global setting to put the device into
> CAN FD mode.
Yep, good idea.
> 
> In the TX path the stack should refuse the new 64 byte frames at all or
> frames with dlc > 8 byes if the device is not in CAN FD mode.
I did not yet do such think since I did not implement CANFD on device level yet.
I think can_send() is a good place to put such tricks.

> What about
> the RX path? We can just use the new 64 byte CAN frames and have to
> tweak the CAN_RAW if the read from the userspace is too small.
You may have noticed that I did not need to do anything
in the receive path in order to receive longer frames.

look at this block in raw_recvmsg:

	if (size < skb->len)
		msg->msg_flags |= MSG_TRUNC;
	else
		size = skb->len;

Even today already, you can recv. with smaller or bigger buffers than
the actual CAN frame.

I did try to let the kernel work with 64bytes, and still use
8byte frames in userspace. that all works, especially since noone
seems to test for MSG_TRUNC.

An improvement that just crosses my mind is something like:

	int real_len;

	real_len = offsetof(struct can_frame, data) +
		((struct can_frame)skb->data)->dlc;
	if (size < real_len)
		msg->msg_flags |= MSG_TRUNC;
	else
		size = real_len;

Such would modify the ABI a bit more, but prevents copying unused bytes
and avoids unnecessary MSG_TRUNC flags.

Regards,
Kurt
