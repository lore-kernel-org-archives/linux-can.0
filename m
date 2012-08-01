From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH can-next v5 2/2] can: flexcan: add LED trigger support
Date: Wed, 1 Aug 2012 14:24:43 +0200
Message-ID: <20120801122443.GA1311@gmail.com>
References: <5018F8B3.6080404@pengutronix.de>
 <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com>
 <1343821782-1346-2-git-send-email-fabio.baltieri@gmail.com>
 <501918B2.6070703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35321 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab2HAMWx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 08:22:53 -0400
Content-Disposition: inline
In-Reply-To: <501918B2.6070703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

On Wed, Aug 01, 2012 at 01:53:22PM +0200, Marc Kleine-Budde wrote:
[...]
> > @@ -635,6 +638,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
> >  	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
> >  		stats->tx_bytes += can_get_echo_skb(dev, 0);
> >  		stats->tx_packets++;
> > +		can_led_event(dev, CAN_LED_EVENT_TX);
> 
> Should the led blink on TX or TX completion interrupt?

I'd say on complention interrupt, together with can_get_echo_skb().

That was briefly discussed with Oliver in my first patch:

http://article.gmane.org/gmane.linux.can/1007

Fabio
