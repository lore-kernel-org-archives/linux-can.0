From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Mon, 6 Oct 2014 09:28:25 +0200
Message-ID: <20141006092825.765bd50d@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<4712537.n1vM034J9B@ws-stein>
	<20141001110741.0e8e5ffb@archvile>
	<5856354.jaFqUxgnZF@ws-stein>
	<20141001113432.18ec8bed@archvile>
	<542BD038.2070106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:27731 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaJFH2T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 03:28:19 -0400
In-Reply-To: <542BD038.2070106@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


Dear Marc,

On Wed, 01 Oct 2014 11:58:16 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/01/2014 11:34 AM, David Jander wrote:
> [...]
> 
> > Back to topic: Can one of the maintainers (Wolfgang, Marc) give an opinion
> > on how to best solve the following two issues:
> > 
> > 1.- Using MB area instead of FIFO for flexcan breaks RTR reception on older
> > SoC's. My proposal is to modify my approach as to have two different IRQ
> > handling paths: One that off-loads the RX-FIFO into the cyclic-buffer for
> > older chips and one that uses the whole MB area and off-loads it into the
> > same cyclic buffer for i.MX6, Vybrid and newer chips.
> 
> Sounds good.

Ok thanks. I will try to do that.

> > 2.- Since the problem addressed by my patch to at91_can is very similar,
> > what about solving these problems in the SocketCAN framework (if that is
> > possible)?
> 
> Have you had a look at my rx-fifo branch in
> https://gitorious.org/linux-can/linux-can-next? It already tries to
> abstract the simulation of the FIFO with the linear mailboxes.

Looks interesting. I think it is a good idea to do this in dev.c, since there
are obviously more CAN drivers that can use this. Unfortunately it seems you
are still pretending the napi-poll handler to call can_rx_fifo_poll().
Wouldn't it be better to just empty all MBs into a circular buffer or kfifo
from the interrupt handler instead?

I still don't understand the results Alexander is getting, though....

What are you going to do with the rx-fifo work? Do you recommend to base my
patch on that? In that case, calling can_rx_fifo_poll() from the interrupt
handler will look a little awkward... but it should work. Or should I propose
an extension to rx-fifo?

Best regards,

-- 
David Jander
Protonic Holland.
