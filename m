From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Thu, 26 Apr 2012 10:21:32 +0200
Message-ID: <20120426082132.GA423@vandijck-laurijssen.be>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <20120424084516.GC420@vandijck-laurijssen.be>
 <20120424203457.GB1672@gmail.com>
 <20120425080004.GB506@vandijck-laurijssen.be>
 <20120425203948.GA1585@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:41134 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754211Ab2DZIVj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 26 Apr 2012 04:21:39 -0400
Content-Disposition: inline
In-Reply-To: <20120425203948.GA1585@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On Wed, Apr 25, 2012 at 10:39:48PM +0200, Fabio Baltieri wrote:
> On Wed, Apr 25, 2012 at 10:00:04AM +0200, Kurt Van Dijck wrote:
> > On Tue, Apr 24, 2012 at 10:34:57PM +0200, Fabio Baltieri wrote:
> > > On Tue, Apr 24, 2012 at 10:45:16AM +0200, Kurt Van Dijck wrote:
> > > > On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> > > > > This patch implements the functions to add two LED triggers, named
> > > > > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > > > > 
> > > > 
> > > > > +void can_led_event(struct net_device *netdev, enum can_led_event event)
> > > > 
> > > > > +	case CAN_LED_EVENT_TX:
> > > > > +		if (led_delay && likely(tx_led) &&
> > > > > +		    !timer_pending(&tx_led->timer))
> > > > > +			mod_timer(&tx_led->timer,
> > > > I think that the latter 2 statements need threadsafe protection
> > > > _OR_ strict serialization from the caller (much more likely).
> > > > I don't think the code needs change, but it might be worth mentioning
> > > > this serialization requirement in the header.
> > > 
> > > Sure? Each device is going to have individual timer structures, and
> > > each timer_list is going to be accessed only from the event function and
> > > by the timer handler itself for retriggering.
> > > 
> > > Also, mod_timer() by itself should be safe.
> > 
> > _between_ timer_pending() & mod_timer(), which are both
> > safe I assume, an interrupt may happen.
> > In such case, it's important that can_led_event(CAN_LED_EVENT_TX)
> > is only called from either some IRQ function, or the network subsystem's softirq,
> > but NOT from both places.
> 
> Ok - but I can't think of a case where you would call this one outside
> hardirq/softirq context.  Either way, I think that the only thing which
> could happen without locks is to schedule the timer two times, which as
> I see from mod_timer implementation is already optimized out, so I think
> that no locking is needed on this one.

I neither think that locking is needed, for reasons you also mentioned.
I did think the proposed way of using can_led_event() is worth describing
in the header, so that it's clear that no locking is needed.
But maybe I'm mistaken here...

> Am I missing something?
no.

Kind regards,
Kurt
