From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Sat, 5 Apr 2014 20:57:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404052056100.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EDB36.6060404@del-llc.com> <alpine.DEB.2.02.1404041833040.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45300 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbaDES51 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Apr 2014 14:57:27 -0400
In-Reply-To: <alpine.DEB.2.02.1404041833040.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark <mark5@del-llc.com>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 4 Apr 2014, Thomas Gleixner wrote:

> On Fri, 4 Apr 2014, Mark wrote:
> > The change you describe below (clearing newdat as you go) was one of my major
> > changes -- and yes, it allows for potential packet re-ordering.  But I was
> > happy to live with that in my application -- as opposed to dropping packets.
> > 
> > The other major change was to separate the use of ifregs[0] and ifregs[1] by
> > task...not by function.  So _xmit()-related functions used one.   And
> > _poll()-related functions used the other.  This meant I didn't have to use
> > spinlock()'s to ensure mutual exclusion to those buffers.  It appears you took
> > the spinlock() path...which should work as well (assuming you can spinlock
> > both tasks that would access those registers).   I do believe splitting them
> > by task instead of tx vs. rx is a better approach however.
> 
> No. I use IF1 for RX and IF2 for TX, but TX needs a spinlock aside of
> that. See
> 
> 640916db2 and bf88a206.

Thinking with awake brain about it: You use IF1 just for the softirq
(both TX and RX) and IF2 for the xmit path. Yeah, that avoids the
spinlock. Nice! Should have thought of that.

Thanks,

	tglx
