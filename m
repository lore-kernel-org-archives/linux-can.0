From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 2 Sep 2014 13:15:43 +0200
Message-ID: <20140902131543.13b7268b@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-2-git-send-email-david@protonic.nl>
	<54059ADC.60309@pengutronix.de>
	<20140902123725.01808f36@archvile>
	<5405A31E.1060403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5203 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaIBLPb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:15:31 -0400
In-Reply-To: <5405A31E.1060403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 12:59:42 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/02/2014 12:37 PM, David Jander wrote:
> > On Tue, 02 Sep 2014 12:24:28 +0200
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> >> On 08/27/2014 11:58 AM, David Jander wrote:
> >>> Apparently mailboxes may contain random data at startup, causing some of
> >>> them being prepared for message reception. This causes overruns being
> >>> missed or even confusing the IRQ check for trasmitted messages,
> >>> increasing the transmit counter instead of the error counter.
> >>>
> >>> Signed-off-by: David Jander <david@protonic.nl>
> >>
> >> Before patch
> >>
> >> 0d1862e can: flexcan: fix flexcan_chip_start() on imx6
> >>
> >> there was a loop clearing the whole cantxfg register space. But this
> >> turned out to be bogus, as message buffers 1...7 are reserved by the
> >> FIFO engine and we're not allowed to tough them. This lead to some kind
> >> of abort on imx6.
> >>
> >> You may need this patch once you don't make use of the FIFO engine any
> >> more.
> > 
> > You will need this patch in either case, but indeed, if you use the FIFO,
> > you should skip the MB's that are shadowed by the FIFO.
> 
> ACK
> 
> > If you don't clear the rest of the MB's they may still contain random data
> > and the problem remains.
> > IMHO 0d1862e is wrong, since buffers are not in reset default values.
> > There is no indication of that in the reference manual, and I have
> > observed that they are indeed not cleared after reset.
> 
> Yes, 0d1862e was not complete, the initialisation was fixes with:
> 
> d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
>                        mark one MB for TX and abort pending TX
> 
> Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for tx
> and the code of the tx mailbox is set to 0x4 == tx, inactive.
> 
> This should be enough in FIFO mode, correct?

AFAICS not. There could still be other MB's with reception or transmission
enabled (randomly) causing potential data loss, extra frames sent and/or errors
in the statistics.
If the FIFO is full for example it should overflow with the next message, but
if the next message instead hits an (randomly) empty and readied RX MB
somewhere, the overflow is undetected and one (or more) frame(s) is lost.

Best regards,

-- 
David Jander
Protonic Holland.
