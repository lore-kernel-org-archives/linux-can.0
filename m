From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Wed, 25 Apr 2012 22:39:48 +0200
Message-ID: <20120425203948.GA1585@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <20120424084516.GC420@vandijck-laurijssen.be>
 <20120424203457.GB1672@gmail.com>
 <20120425080004.GB506@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38049 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830Ab2DYUi2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Apr 2012 16:38:28 -0400
Received: by wibhj6 with SMTP id hj6so5430294wib.1
        for <linux-can@vger.kernel.org>; Wed, 25 Apr 2012 13:38:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120425080004.GB506@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On Wed, Apr 25, 2012 at 10:00:04AM +0200, Kurt Van Dijck wrote:
> On Tue, Apr 24, 2012 at 10:34:57PM +0200, Fabio Baltieri wrote:
> > On Tue, Apr 24, 2012 at 10:45:16AM +0200, Kurt Van Dijck wrote:
> > > On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> > > > This patch implements the functions to add two LED triggers, named
> > > > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > > > 
> > > 
> > > > +void can_led_event(struct net_device *netdev, enum can_led_event event)
> > > 
> > > > +	case CAN_LED_EVENT_TX:
> > > > +		if (led_delay && likely(tx_led) &&
> > > > +		    !timer_pending(&tx_led->timer))
> > > > +			mod_timer(&tx_led->timer,
> > > I think that the latter 2 statements need threadsafe protection
> > > _OR_ strict serialization from the caller (much more likely).
> > > I don't think the code needs change, but it might be worth mentioning
> > > this serialization requirement in the header.
> > 
> > Sure? Each device is going to have individual timer structures, and
> > each timer_list is going to be accessed only from the event function and
> > by the timer handler itself for retriggering.
> > 
> > Also, mod_timer() by itself should be safe.
> 
> _between_ timer_pending() & mod_timer(), which are both
> safe I assume, an interrupt may happen.
> In such case, it's important that can_led_event(CAN_LED_EVENT_TX)
> is only called from either some IRQ function, or the network subsystem's softirq,
> but NOT from both places.

Ok - but I can't think of a case where you would call this one outside
hardirq/softirq context.  Either way, I think that the only thing which
could happen without locks is to schedule the timer two times, which as
I see from mod_timer implementation is already optimized out, so I think
that no locking is needed on this one. Am I missing something?

Regards,
Fabio

