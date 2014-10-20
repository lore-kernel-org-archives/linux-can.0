From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 08/15] can: rx-fifo: fix long lines
Date: Mon, 20 Oct 2014 09:09:45 +0200
Message-ID: <20141020090945.4986875a@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-9-git-send-email-david@protonic.nl>
	<20141019211803.GA428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:1445 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbaJTHJZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Oct 2014 03:09:25 -0400
In-Reply-To: <20141019211803.GA428@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Sun, 19 Oct 2014 23:18:03 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On Fri, Oct 10, 2014 at 05:46:53PM +0200, David Jander wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/net/can/dev.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> > index 22a3955..3e1160a 100644
> > --- a/drivers/net/can/dev.c
> > +++ b/drivers/net/can/dev.c
> > @@ -301,17 +301,21 @@ static unsigned int can_rx_fifo_inc(struct
> > can_rx_fifo *fifo, unsigned int *val) static u64
> > can_rx_fifo_mask_low(struct can_rx_fifo *fifo) {
> >  	if (fifo->inc)
> > -		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
> > << fifo->low_first;
> > +		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
> > +			     << fifo->low_first;
> 
> In the kernel, a line usually doesn't start with an operator. Please keep it
> in the original line.

Right. I did this on purpose because I thought it was a lot more readable
like that for this case, but if you prefer coding-style, I'll fix it.

> >  	else
> > -		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
> > << (fifo->high_first + 1);
> > +		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
> > +			     << (fifo->high_first + 1);
> >  }
> >  
> >  static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
> >  {
> >  	if (fifo->inc)
> > -		return ~0LLU >> (64 + fifo->high_first - fifo->high_last
> > - 1) << fifo->high_first;
> > +		return ~0LLU >> (64 + fifo->high_first - fifo->high_last
> > - 1)
> > +			     << fifo->high_first;
> >  	else
> > -		return ~0LLU >> (64 - fifo->high_first + fifo->high_last
> > - 1) << fifo->high_last;
> > +		return ~0LLU >> (64 - fifo->high_first + fifo->high_last
> > - 1)
> > +			     << fifo->high_last;
> >  }
> >  
> >  static int can_rx_fifo_read_napi_frame(struct can_rx_fifo *fifo, int
> > index)
> 
> Marc
> 

Best regards,

-- 
David Jander
Protonic Holland.
