From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Mon, 6 Oct 2014 13:17:51 +0200
Message-ID: <20141006131751.75823c82@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<4712537.n1vM034J9B@ws-stein>
	<20141001110741.0e8e5ffb@archvile>
	<5856354.jaFqUxgnZF@ws-stein>
	<20141001113432.18ec8bed@archvile>
	<542BD038.2070106@pengutronix.de>
	<20141006092825.765bd50d@archvile>
	<54326823.7030000@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:28323 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaJFLRn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 07:17:43 -0400
In-Reply-To: <54326823.7030000@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


Dear Marc,

On Mon, 06 Oct 2014 12:00:03 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/06/2014 09:28 AM, David Jander wrote:
> >>> 2.- Since the problem addressed by my patch to at91_can is very similar,
> >>> what about solving these problems in the SocketCAN framework (if that is
> >>> possible)?
> >>
> >> Have you had a look at my rx-fifo branch in
> >> https://gitorious.org/linux-can/linux-can-next? It already tries to
> >> abstract the simulation of the FIFO with the linear mailboxes.
> > 
> > Looks interesting. I think it is a good idea to do this in dev.c, since
> > there are obviously more CAN drivers that can use this. Unfortunately it
> > seems you are still pretending the napi-poll handler to call
> > can_rx_fifo_poll(). Wouldn't it be better to just empty all MBs into a
> > circular buffer or kfifo from the interrupt handler instead?
> 
> Yes probably, I started the rx-fifo patch before you came up with that idea.
> 
> > I still don't understand the results Alexander is getting, though....
> > 
> > What are you going to do with the rx-fifo work? Do you recommend to base my
> > patch on that? In that case, calling can_rx_fifo_poll() from the interrupt
> > handler will look a little awkward... but it should work. Or should I
> > propose an extension to rx-fifo?
> 
> My plans, or rather the points that need to be addressed for the rx-fifo
> are:
> - improve to work with more than 32 mailboxes. 64 are probably enough
>   for everybody :)

Just did that. Basically a s/u32/u64/g and s/BIT/BIT_ULL/g sort of thing.

> - make it work with the flexcan linear buffers

I am busy with that one... one thing I am pondering whether the "disable first
and then read-out" -logic holds up here, since the flexcan has it's own locking
thing... I'll have to see.

> - make it work with the ti_hecc driver

Never seen that one...

> - add option or convert to run from interrupt handler and copy to
>   kfifo/cyclic buffer/...

Almost done. Basically I am introducing this:

--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -75,6 +75,8 @@ struct can_rx_fifo {
        void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
        void (*mailbox_disable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
        void (*mailbox_receive)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+       void (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
+               struct can_frame *frame, unsigned int mb);
 
        u64 mask_low;
        u64 mask_high;
@@ -83,6 +85,10 @@ struct can_rx_fifo {
        unsigned int next;
 
        bool inc;
+
+       struct can_frame *ring;
+       unsigned int ring_head;
+       unsigned int ring_tail;
 };

If the user defines fifo->mailbox_move_to_buffer() it is called instead of
fifo->mailbox_receive() and he whole circular buffer magic is done in
can_rx_fifo_poll(). I also need to add something like a generic NAPI poll
handler then, that just reads out this ring-buffer. Should simplify drivers a
lot I guess.

What do you think?

Best regards,

-- 
David Jander
Protonic Holland.
