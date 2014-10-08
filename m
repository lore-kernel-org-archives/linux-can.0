From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 8 Oct 2014 16:01:13 +0200
Message-ID: <20141008160113.10c2e887@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<4712537.n1vM034J9B@ws-stein>
	<20141001110741.0e8e5ffb@archvile>
	<5856354.jaFqUxgnZF@ws-stein>
	<20141001113432.18ec8bed@archvile>
	<542BD038.2070106@pengutronix.de>
	<20141006092825.765bd50d@archvile>
	<54326823.7030000@pengutronix.de>
	<20141008110839.489a786d@archvile>
	<54350A34.1020402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:11737 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaJHOBE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Oct 2014 10:01:04 -0400
In-Reply-To: <54350A34.1020402@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wed, 08 Oct 2014 11:56:04 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/08/2014 11:08 AM, David Jander wrote:
> > 
> > Dear Marc,
> > 
> > On Mon, 06 Oct 2014 12:00:03 +0200
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> >> On 10/06/2014 09:28 AM, David Jander wrote:
> >>>>> 2.- Since the problem addressed by my patch to at91_can is very
> >>>>> similar, what about solving these problems in the SocketCAN framework
> >>>>> (if that is possible)?
> >>>>
> >>>> Have you had a look at my rx-fifo branch in
> >>>> https://gitorious.org/linux-can/linux-can-next? It already tries to
> >>>> abstract the simulation of the FIFO with the linear mailboxes.
> >>>
> >>> Looks interesting. I think it is a good idea to do this in dev.c, since
> >>> there are obviously more CAN drivers that can use this. Unfortunately it
> >>> seems you are still pretending the napi-poll handler to call
> >>> can_rx_fifo_poll(). Wouldn't it be better to just empty all MBs into a
> >>> circular buffer or kfifo from the interrupt handler instead?
> >>
> >> Yes probably, I started the rx-fifo patch before you came up with that
> >> idea.
> >>
> >>> I still don't understand the results Alexander is getting, though....
> >>>
> >>> What are you going to do with the rx-fifo work? Do you recommend to base
> >>> my patch on that? In that case, calling can_rx_fifo_poll() from the
> >>> interrupt handler will look a little awkward... but it should work. Or
> >>> should I propose an extension to rx-fifo?
> >>
> >> My plans, or rather the points that need to be addressed for the rx-fifo
> >> are:
> >> - improve to work with more than 32 mailboxes. 64 are probably enough
> >>   for everybody :)
> >> - make it work with the flexcan linear buffers
> >> - make it work with the ti_hecc driver
> >> - add option or convert to run from interrupt handler and copy to
> >>   kfifo/cyclic buffer/...
> > 
> > Can you lend you brain for a sec on this problem... I think I discovered a
> > race condition in your rx-fifo code, but it might just be me not
> > understanding it correctly....
> > 
> > 	do {
> > 		pending = fifo->read_pending(fifo);
> > 		pending &= fifo->active;
> > 
> > 		if (!(pending & BIT_ULL(fifo->next))) {
> > 			/*
> > 			 * Wrap around only if:
> > 			 * - we are in the upper group and
> > 			 * - there is a CAN frame in the first mailbox
> > 			 *   of the lower group.
> > 			 */
> > 			if (can_rx_fifo_ge(fifo, fifo->next,
> > fifo->high_first) && (pending & BIT_ULL(fifo->low_first))) {
> > 				fifo->next = fifo->low_first;
> > 				fifo->active |= fifo->mask_high;
> > 				fifo->mailbox_enable_mask(fifo,
> > fifo->mask_high); } else {
> > 				break;
> > 			}
> > 		}
> > 
> > In this piece of code, suppose that fifo->next is in the upper half and a
> > message is being written to the MB it is pointing at, but it is still not
> > pending. The lower half has already been enabled and filled up completely
> > (due to latency). In that case, fifo-next will jump back to
> > fifo->low_first and leave a lonely filled MB in the middle of the upper
> > half, that will trigger and infinite loop between IRQ and
> > can_rx_fifo_poll(). The interrupt will never get cleared again.
> > I know this is an extreme case of latency being so high as to fill more
> > than the complete lower half, but if it strikes, it results in a lock-up.
> > Am I right, or did I screw up somewhere?
> 
> Correct analysis :( At least it shows it makes sense to have this code
> in a central place.....

I placed a printk() in the interrupt handler for debugging, and that made this
issue quite likely to hit.

> If we handle the low_first mailbox, we might have to check if the "old"
> next, or better, if any of the mailboxes >= old_next are pending *and*
> there is a non pending mailbox < "old" next. This should be possible
> with one or two clever bitmasks.

I've tried to do that, but if this situation happens, then one should first
read the lower MBs anyway and then continue with the "old" next MB and
re-enable them immediately....
Problem is, I can't seem to fit this logic nicely into the current do-while
loop anymore.
Part of the problem could be solved if we could dismiss the requirement of the
"quota" parameter, i.e. support only the "empty from interrupt into circular
buffer"-scenario. Then the whole loop could get a lot simpler. Any reason not
to do this?

Besides, what about simplifying the logic just a little bit like what I did in
the original flexcan patch (mildly reworded):

" We split the MB area into two halves:
The lower half and the upper half.
We start with all MBs in EMPTY state.
The CAN controller will start filling from the lowest MB. Once this function
is called, we copy and disable in an atomic operation all FULL MBs.
The first EMPTY one we encounter may be about to get filled so we stop there.
Next time the CAN controller will have filled more MBs. Once there are no
EMPTY MBs in the lower half, we EMPTY all FULL or locked MBs again.
Next time we have the following situation:
If there is a FULL MB in the upper half, it is because it was about to get
filled when we scanned last time, or got filled just before emptying the
lowest MB, so this will be the first MB we need to copy now. If there are
no EMPTY MBs in the lower half at this time, it means we cannot guarantee
ordering anymore. It also means latency exceeded the maximum amount of
messages this controller can safely handle."

This small change avoids the pitfall we have now, because we always enable all
MBs once we crossed the split limit. To ensure ordering we only need to check
whether there are pending messages in the upper half before reading the lower
half, if previously we had crossed the split.

This means also, we can tweak performance by making an un-even split. The MBs
below the split are our "latency-buffer", while the MBs above the split are
only needed to handle incoming messages while we are busy in the read-out
loop. This part can theoretically be much smaller. The old at91_can driver
intended to work more or less like this also, so I think this will work at
least for both drivers... not sure about ti_hecc though.

Best regards,

-- 
David Jander
Protonic Holland.
