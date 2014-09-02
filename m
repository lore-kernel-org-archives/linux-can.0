From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 2 Sep 2014 16:27:00 +0200
Message-ID: <20140902162700.53555941@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-2-git-send-email-david@protonic.nl>
	<54059ADC.60309@pengutronix.de>
	<20140902123725.01808f36@archvile>
	<5405A31E.1060403@pengutronix.de>
	<20140902131543.13b7268b@archvile>
	<5405CBFE.5070207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5864 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaIBO0s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 10:26:48 -0400
In-Reply-To: <5405CBFE.5070207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 15:54:06 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/02/2014 01:15 PM, David Jander wrote:
> 
> >> Yes, 0d1862e was not complete, the initialisation was fixes with:
> >>
> >> d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
> >>                        mark one MB for TX and abort pending TX
> >>
> >> Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for tx
> >> and the code of the tx mailbox is set to 0x4 == tx, inactive.
> >>
> >> This should be enough in FIFO mode, correct?
> > 
> > AFAICS not. There could still be other MB's with reception or transmission
> > enabled (randomly) causing potential data loss, extra frames sent and/or
> > errors in the statistics.
> 
> > If the FIFO is full for example it should overflow with the next message,
> > but if the next message instead hits an (randomly) empty and readied RX MB
> > somewhere, the overflow is undetected and one (or more) frame(s) is lost.
> 
> Is FIFO to normal mailbox overflow a new feature of the imx6 flexcan
> core? The mx35 data sheet states:
> 
> > If the FIFO is full and more frames continue to be received, an
> > OVERFLOW interrupt is issued to the ARM and subsequent frames are not
> > accepted until the ARM creates space in the FIFO by reading one or
> > more frames.
> 
> While the mx6 states:
> 
> > Note that the flag will not be asserted when the Rx FIFO is
> > full and the message was captured by a Mailbox.
> 
> But later in the imx35:
> 
> > In the event that the FIFO is full, the matching algorithm always
> > looks for a matching message buffer outside the FIFO region.
> 
> This probably means even on the mx35 the _FIFO_ does not accept any more
> message if it's full, but the other mailboxes may....

In the i.MX6 RM there's also this (Chapter 27.6.5 Matching Process):

> [...]
> If the FIFO is enabled, the priority of scanning can be selected between
> Mailboxes and FIFO filters. In any case, the matching starts from the lowest
> number Message Buffer toward the higher ones. If no match is found within
> the first structure then the other is scanned subsequently. In the event
> that the FIFO is full, the matching algorithm will always look for a
> matching MB outside the FIFO region.

What's not quite clear to me right now, is the function of MCR_MAXMB after
reading this. As far as I have observed, MCR_MAXMB is of no influence for
this. I needed to explicitely invalidate all remaining MB's to avoid flexcan
putting overflow messages there.

Best regards,

-- 
David Jander
Protonic Holland.
