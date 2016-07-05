From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp
 based irq offloading
Date: Tue, 5 Jul 2016 11:58:51 +0000
Message-ID: <20160705115851.GA13601@maxwell>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
 <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
 <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:13072
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755506AbcGEQdo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 5 Jul 2016 12:33:44 -0400
Content-Disposition: inline
In-Reply-To: <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, david@protonic.nl

On Tue, Jul 05, 2016 at 12:30:32AM +0200, Marc Kleine-Budde wrote:
> On 07/04/2016 10:59 PM, Marc Kleine-Budde wrote:
> > Actually I want to have the difference between two timestamps in order
> > to sort . The timestamps are monotonically increasing and will
> > eventually roll over. As the flexcan core only has a 16 bit timer, I
> > shift the timestamp by 16 bit (cb = reg_ts << 16), to fill the whole 32
> > bit. This way I don't have to take care about the overflow, right?
> > 
Hmmm, yes, that is quite clever. If I understand correctly, this means that if
you have three timestamps on the roll-over boundary: 0xfffe0000, 0xffff0000 and
0x0001000, the sorting algorithm will sort them in this particular order because
	(int)(0xfffe0000 - 0xffff0000) < 0
and
	(int)(0xffff0000 - 0x00010000) < 0

Perhaps there should be a comment explaining this?

> >> main: a=0xfffffff0 b=0xfffffffc diff= 12
> >> main: a=0xfffffff0 b=0xfffffffd diff= 13
> >> main: a=0xfffffff0 b=0xfffffffe diff= 14
> >> main: a=0xfffffff0 b=0xffffffff diff= 15
> >> main: a=0xfffffff0 b=0x00000000 diff= 16
> >> main: a=0xfffffff0 b=0x00000001 diff= 17
> >> main: a=0xfffffff0 b=0x00000002 diff= 18
> >> main: a=0xfffffff0 b=0x00000003 diff= 19
> >> main: a=0xfffffff0 b=0x00000004 diff= 20
> 
> It's also working when the difference is negative:
> 
> > main: a=0xfffffffc b=0xfffffff0 diff=-12
> > main: a=0xfffffffd b=0xfffffff0 diff=-13
> > main: a=0xfffffffe b=0xfffffff0 diff=-14
> > main: a=0xffffffff b=0xfffffff0 diff=-15
> > main: a=0x00000000 b=0xfffffff0 diff=-16
> > main: a=0x00000001 b=0xfffffff0 diff=-17
> > main: a=0x00000002 b=0xfffffff0 diff=-18
> > main: a=0x00000003 b=0xfffffff0 diff=-19
> 
> It will get "problematic" if the difference between the two u32 is
> around 2^31. But then it's hard to tell which of the mailboxes holds the
> older timestamp.
> 
Yes, it's also safe to assume that if you ever get this much of a difference
between timestamps in the mailbox, something else must be wrong before that
happens.

I've run into bugs involving this kind of a comparison function where the
difference actually can be large enough to cause problems, so this was a red
flag for me, but it turns out to be OK.

Best regards,
Andri
