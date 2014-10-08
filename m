From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Wed, 08 Oct 2014 12:36:49 +0200
Message-ID: <1544714.FueVS1KdZh@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <20141008110839.489a786d@archvile> <54350A34.1020402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56113 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755571AbaJHKo4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Oct 2014 06:44:56 -0400
In-Reply-To: <54350A34.1020402@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wednesday 08 October 2014 11:56:04, Marc Kleine-Budde wrote:
> On 10/08/2014 11:08 AM, David Jander wrote:
> > 
> > Dear Marc,
> > 
> > On Mon, 06 Oct 2014 12:00:03 +0200
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> >> On 10/06/2014 09:28 AM, David Jander wrote:
> >>>>> 2.- Since the problem addressed by my patch to at91_can is very similar,
> >>>>> what about solving these problems in the SocketCAN framework (if that is
> >>>>> possible)?
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
> >> Yes probably, I started the rx-fifo patch before you came up with that idea.
> >>
> >>> I still don't understand the results Alexander is getting, though....
> >>>
> >>> What are you going to do with the rx-fifo work? Do you recommend to base my
> >>> patch on that? In that case, calling can_rx_fifo_poll() from the interrupt
> >>> handler will look a little awkward... but it should work. Or should I
> >>> propose an extension to rx-fifo?
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
> > race condition in your rx-fifo code, but it might just be me not understanding
> > it correctly....
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
> > 			if (can_rx_fifo_ge(fifo, fifo->next, fifo->high_first) &&
> > 			    (pending & BIT_ULL(fifo->low_first))) {
> > 				fifo->next = fifo->low_first;
> > 				fifo->active |= fifo->mask_high;
> > 				fifo->mailbox_enable_mask(fifo, fifo->mask_high);
> > 			} else {
> > 				break;
> > 			}
> > 		}
> > 
> > In this piece of code, suppose that fifo->next is in the upper half and a
> > message is being written to the MB it is pointing at, but it is still not
> > pending. The lower half has already been enabled and filled up completely (due
> > to latency). In that case, fifo-next will jump back to fifo->low_first and
> > leave a lonely filled MB in the middle of the upper half, that will trigger
> > and infinite loop between IRQ and can_rx_fifo_poll(). The interrupt will never
> > get cleared again.
> > I know this is an extreme case of latency being so high as to fill more than
> > the complete lower half, but if it strikes, it results in a lock-up. Am I
> > right, or did I screw up somewhere?
> 
> Correct analysis :( At least it shows it makes sense to have this code
> in a central place.....

I didn't reviewed that piece of code, I just read David's description. Well, I actually saw this scenario on pch_can where the rx mailboxes are split in lower and upper half. The current upper MB was empty and rx_poll left handling MBs and freed the lower MB. Meanwhile a frame was about beeing inserted in the current upper MB. Upon next interrupt reception started on lower MBs until eventually the remained frame in upper MB was read. But at this time the order is messed up. There was no lockup, because the interrupt signaling worked a bit different.

> If we handle the low_first mailbox, we might have to check if the "old"
> next, or better, if any of the mailboxes >= old_next are pending *and*
> there is a non pending mailbox < "old" next. This should be possible
> with one or two clever bitmasks.

If we detect that (all) MBs before the old one are pending again, we even can't ensure proper CAN frame order. All MBs below and even after old_next coul have been written meanwhile. That's why I hate those MB interfaces and prefer a real FIFO.
Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

