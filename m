From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Wed, 25 Apr 2012 09:50:45 +0200
Message-ID: <20120425075045.GA506@vandijck-laurijssen.be>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <20120424083806.GB420@vandijck-laurijssen.be>
 <20120424202200.GA1672@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:28515 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab2DYHus (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Apr 2012 03:50:48 -0400
Content-Disposition: inline
In-Reply-To: <20120424202200.GA1672@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On Tue, Apr 24, 2012 at 10:22:00PM +0200, Fabio Baltieri wrote:
> On Tue, Apr 24, 2012 at 10:38:06AM +0200, Kurt Van Dijck wrote:
> > On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> > > This patch implements the functions to add two LED triggers, named
> > > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > > 
> > [...]
> 
> Hello Kurt,
> 
> > If I understand well, this function is subject to maximal optimization.
> > > +void can_led_event(struct net_device *netdev, enum can_led_event event)
> > > +{
> > > +	struct can_priv *priv = netdev_priv(netdev);
> > If the assignment is postponed to withing the differenct cases, thereby
> > repeating this statement 3 times (not 4!), both for RX & TX path a single
> > assignment could be saved.
> > For stack usage, I'm not an expert, but I suspect a little less stack use.
> > I'm not sure wether it's worth the pain of extra lines of code.
> > I tried to illustrate my point here:
> 
> I'm looking at the disassembled function for both cases on ARM.  Your
> version uses some less instructions but I think the optimizer is
> crunching the whoole thing in some funny way and I'm not sure if it's
> going to make a difference at all in the end.

If the benefit cannot be proven, I'd stick to the original, as the code
is much cleaner :-)

> Do you know if there are any other part of the kernel which are using
> similar optimiziations?

No, I'm not an expert on code optimization ...

Kurt
