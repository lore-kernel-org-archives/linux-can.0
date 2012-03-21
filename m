From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 13:51:30 +0100
Message-ID: <20120321125130.GC3372@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
 <20120321110502.GA3372@vandijck-laurijssen.be>
 <4F69BEE3.2040705@pengutronix.de>
 <20120321120846.GB3372@vandijck-laurijssen.be>
 <4F69CA74.3020607@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:46372 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab2CUMvg (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Mar 2012 08:51:36 -0400
Content-Disposition: inline
In-Reply-To: <4F69CA74.3020607@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 01:32:52PM +0100, Marc Kleine-Budde wrote:
> On 03/21/2012 01:08 PM, Kurt Van Dijck wrote:
> > On Wed, Mar 21, 2012 at 12:43:31PM +0100, Marc Kleine-Budde wrote:
> >> On 03/21/2012 12:05 PM, Kurt Van Dijck wrote:
> >>> Hi Sebastian,
> >>
> 
> >> What about
> >> the RX path? We can just use the new 64 byte CAN frames and have to
> >> tweak the CAN_RAW if the read from the userspace is too small.
> > You may have noticed that I did not need to do anything
> > in the receive path in order to receive longer frames.
> > 
> > look at this block in raw_recvmsg:
> > 
> > 	if (size < skb->len)
> > 		msg->msg_flags |= MSG_TRUNC;
> > 	else
> > 		size = skb->len;
> > 
> > Even today already, you can recv. with smaller or bigger buffers than
> > the actual CAN frame.
> 
> ...using an unmodified mainline kernel?

Must be. yes!
I think that's good.
> 
> > I did try to let the kernel work with 64bytes, and still use
> > 8byte frames in userspace. that all works, especially since noone
> > seems to test for MSG_TRUNC.
> 
> Have you checked _all_ CAN userspace applications? :P
> We cannot break the ABI.
I mentioned cansend & candump.
I realize there's a lot of work ahead. I just started, and tried
not to touch too much, and yet prove it can work.

I agree that we cannot break the current ABI.

> 
> > An improvement that just crosses my mind is something like:
> > 
> > 	int real_len;
> > 
> > 	real_len = offsetof(struct can_frame, data) +
> > 		((struct can_frame)skb->data)->dlc;
> > 	if (size < real_len)
> > 		msg->msg_flags |= MSG_TRUNC;
> > 	else
> > 		size = real_len;
> > 
> > Such would modify the ABI a bit more, but prevents copying unused bytes
> > and avoids unnecessary MSG_TRUNC flags.
> 
> I suggest to copy the full 8 bytes of data if dlc <= 8, for full ABI
> compatibility.

Do we then agree that it is desired not to do this beyond the first 8 bytes?
Moreover, we could depend this on the function parameter 'size'. If it
is 16bytes, do as before, else do the new trick. Did I miss something then?

Kurt
