From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 22:34:57 +0200
Message-ID: <20120424203457.GB1672@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <20120424084516.GC420@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46403 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab2DXUdK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 16:33:10 -0400
Received: by wejx9 with SMTP id x9so682663wej.19
        for <linux-can@vger.kernel.org>; Tue, 24 Apr 2012 13:33:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120424084516.GC420@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On Tue, Apr 24, 2012 at 10:45:16AM +0200, Kurt Van Dijck wrote:
> On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> > This patch implements the functions to add two LED triggers, named
> > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > 
> 
> > +void can_led_event(struct net_device *netdev, enum can_led_event event)
> 
> > +	case CAN_LED_EVENT_TX:
> > +		if (led_delay && likely(tx_led) &&
> > +		    !timer_pending(&tx_led->timer))
> > +			mod_timer(&tx_led->timer,
> I think that the latter 2 statements need threadsafe protection
> _OR_ strict serialization from the caller (much more likely).
> I don't think the code needs change, but it might be worth mentioning
> this serialization requirement in the header.

Sure? Each device is going to have individual timer structures, and
each timer_list is going to be accessed only from the event function and
by the timer handler itself for retriggering.

Also, mod_timer() by itself should be safe.

http://lxr.free-electrons.com/source/kernel/timer.c#L833

Regards,
Fabio
