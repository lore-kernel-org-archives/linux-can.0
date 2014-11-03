From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 09/15] can: rx-fifo: Add can_rx_fifo_reset() function
Date: Mon, 3 Nov 2014 13:46:55 +0100
Message-ID: <20141103134655.1108332b@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-10-git-send-email-david@protonic.nl>
	<54576408.5040709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4316 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbaKCMqW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:46:22 -0500
In-Reply-To: <54576408.5040709@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 03 Nov 2014 12:16:24 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/10/2014 05:46 PM, David Jander wrote:
> > This function needs to be called every time the CAN controller is reset
> > and before interrupts are enabled. Otherwise the irq-offload loop gets
> > out of sync. Detect this and BUG() to the user if he forgot.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/net/can/dev.c   | 20 ++++++++++++++++++--
> >  include/linux/can/dev.h |  1 +
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> > index 3e1160a..fc35d28 100644
> > --- a/drivers/net/can/dev.c
> > +++ b/drivers/net/can/dev.c
> > @@ -487,8 +487,17 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
> >  		fifo->second_first = true;
> >  	}
> >  
> > -	if (received)
> > -		napi_schedule(&fifo->napi);
> > +	if (received) {
> > +		can_rx_fifo_napi_schedule(fifo);
> > +	} else {
> > +		/*
> > +		 * This should only happen if the CAN conroller was
> > reset, but
> > +		 * can_rx_fifo_reset() was not called. BUG();
> > +		 */
> > +		netdev_warn(fifo->dev, "%s: No messages found,"
> > +			    " RX-FIFO out of sync?\n", __func__);
> > +		BUG();
> 
> Can you replace the BUG() (which crashes the system) by something less
> fatal? E.g. by some of the WARN function [1]? Does it make sense to call
> the fifo_reset() function after this? We'll loose up to a FIFO size
> amount of CAN frames, but the system stays hopefully working.

Ok. We just need to make enough noise, so that the potential driver's author
sees it before release... a WARN*() should do.

> Marc
> 
> [1] http://lxr.free-electrons.com/source/include/asm-generic/bug.h#L84
> 

Best regards,

-- 
David Jander
Protonic Holland.
