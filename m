From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] can: fix sja1000 pre_irq/post_irq handling
Date: Mon, 18 Nov 2013 20:48:33 +0100
Message-ID: <20131118194833.GC1268@vandijck-laurijssen.be>
References: <5288CFEF.3060701@hartkopp.net>
 <52892C36.8060709@grandegger.com>
 <5289B0EF.3070507@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:45087 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480Ab3KRTsh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Nov 2013 14:48:37 -0500
Content-Disposition: inline
In-Reply-To: <5289B0EF.3070507@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Oliver,

just 2 small remarks below.

On Mon, Nov 18, 2013 at 07:17:19AM +0100, Oliver Hartkopp wrote:
> 
> 
> On 17.11.2013 21:51, Wolfgang Grandegger wrote:
> > Hi Oliver,
> > 
> > On 11/17/2013 03:17 PM, Oliver Hartkopp wrote:
> >> The SJA1000 driver provides optional function pointers to handle specific
> >> hardware setups at interrupt time.
> >>
> >> This patch fixes the issue that the sja1000_interrupt() function may have
> >> returned IRQ_NONE without processing the post_irq function. Additionally
> >> an introduced return value from the pre_irq function is checked to skip the
> >> entire interrupt handling on pre_irq function errors.
> >>
> >> Reported-by: Wolfgang Grandegger <wg@grandegger.com>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>
> >> ---
> >>
> >> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> >> index 7164a99..bb20470 100644
> >> --- a/drivers/net/can/sja1000/sja1000.c
> >> +++ b/drivers/net/can/sja1000/sja1000.c
> >> @@ -494,12 +494,12 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
> >>  	uint8_t isrc, status;
> >>  	int n = 0;
> >>  
> >> +	if (priv->pre_irq && priv->pre_irq(priv))
> >> +		goto out;
> >> +
> > 
> > Well, not sure if we need that. Looks like a fatal error to me.
> > 
> 
> Why?
> Think about a pre_irq() function that can look into hw specific registers and
> which can determine, that there was no interrupt for this CAN device.
> In this case the access to the sja1000 registers might/should be skipped
> depending on the new return value of pre_irq().
> 
> So what's the error here?

The accuracy of reading register SJA1000_IR remains unbeaten when
deciding if an SJA1000 has interrupts pending.
Any pre_irq() return value is close approximation.

> Btw. by now there's no user of priv->pre_irq() anyway.

"No in-kernel users" is a strong argument for deleting
the pre_irq entirely.

Kind regards,
Kurt
