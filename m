From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: flexcan driver: tx_bytes counter never incremented when
 CAN_RAW_LOOPBACK removed?
Date: Mon, 29 Apr 2013 15:43:19 +0200
Message-ID: <20130429134319.GC11067@vandijck-laurijssen.be>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
 <20130426205150.GA28450@thinkoso.home>
 <517E26E4.8010003@pengutronix.de>
 <517E4E01.3080705@peak-system.com>
 <517E5120.70600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:63768 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757256Ab3D2Nnv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 09:43:51 -0400
Content-Disposition: inline
In-Reply-To: <517E5120.70600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

Marc,

just my opinion:

On Mon, Apr 29, 2013 at 12:53:20PM +0200, Marc Kleine-Budde wrote:
> On 04/29/2013 12:40 PM, Stephane Grosjean wrote:
> > Hi Marc,
> > 
> > Playing with the flexcan driver, I've seen that the tx_bytes counter
> > always equals 0 while tx_packets increases.
> > I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so I
> > suppose that:
> > 
> > stats->tx_bytes += can_get_echo_skb(dev, 0);
> > 
> > doesn't do what it should.
> > Am I wrong?
> 
> Let me see. Yes you're right. can_put_echo_skb() only queues the CAN
> frame if CAN_RAW_LOOPBACK is set.
> 
> We either can change that can_put_echo_skb() always queues the CAN frame
> or that can_get_echo_skb() returns the correct number of bytes even if
> the CAN frame is not queued or put the mechanism in each driver.

fixing can_get_echo_skb() appears far more straightforward & universally
applicable. The drawback, freeing an non-loopback'd SKB a few microseconds later
that strictly necessary, seems a not-so-big one.

Differentiating the can_get_echo_skb and introducing new structs
seem overkill to me for this task.

Kind regards,
Kurt
