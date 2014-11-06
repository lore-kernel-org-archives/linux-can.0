From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 02/14] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Thu, 6 Nov 2014 17:03:30 +0100
Message-ID: <20141106170330.54b6ed7e@archvile>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
	<1415262853-22907-3-git-send-email-david@protonic.nl>
	<545B3457.9030207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:27656 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaKFQCy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 11:02:54 -0500
In-Reply-To: <545B3457.9030207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Thu, 06 Nov 2014 09:41:59 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 11/06/2014 09:34 AM, David Jander wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/net/can/dev.c   | 24 ++++++++++++------------
> >  include/linux/can/dev.h | 12 ++++++------
> >  2 files changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> > index c1e53e9..930b9f4 100644
> > --- a/drivers/net/can/dev.c
> > +++ b/drivers/net/can/dev.c
> > @@ -289,20 +289,20 @@ static unsigned int can_rx_fifo_inc(struct
> > can_rx_fifo *fifo, unsigned int *val) return (*val)--;
> >  }
> >  
> > -static u32 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
> > +static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
> >  {
> >  	if (fifo->inc)
> > -		return ~0U >> (32 + fifo->low_first - fifo->high_first)
> > << fifo->low_first;
> > +		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
> > << fifo->low_first; else
> > -		return ~0U >> (32 - fifo->low_first + fifo->high_first)
> > << (fifo->high_first + 1);
> > +		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
> > << (fifo->high_first + 1);
> 
> Yesterday I stumbled over GENMASK_ULL
> http://lxr.free-electrons.com/source/include/linux/bitops.h#L22
> Does it make sense to use it here?

Looks like its exactly what is needed here.... nice.

Btw, there is a subtle bug in the line you linked to:

> #define GENMASK_ULL(h, l)       (((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))

The _ULL in the name of the macro seems to hint to "unsigned long long", while
the implementation seems to assume that it means U64_C. This is obviously
wrong, although for most platforms that are currently capable of running
Linux, those are probably equivalent...

Funny.

Best regards,

-- 
David Jander
Protonic Holland.
