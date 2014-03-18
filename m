From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 02/12] can: c_can: Fix hardware raminit function
Date: Tue, 18 Mar 2014 23:15:56 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1403182313110.18573@ionos.tec.linutronix.de>
References: <20140318171007.528610837@linutronix.de> <20140318171126.720944558@linutronix.de> <532892BC.7080406@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57729 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbaCRWPr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Mar 2014 18:15:47 -0400
In-Reply-To: <532892BC.7080406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Markus Pargmann <mpa@pengutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org

On Tue, 18 Mar 2014, Marc Kleine-Budde wrote:
> On 03/18/2014 06:19 PM, Thomas Gleixner wrote:
> > +static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
> > +				  u32 val)
> > +{
> > +	/* We look only at the bits of our instance. */
> > +	val &= mask;
> > +	while ((readl(priv->raminit_ctrlreg) & mask) != val)
> > +		udelay(1);
> 
> Do we have to add a timeout here, or is it "safe" to have a potential
> endless loop here? As you have probably tortured the hardware and driver
> a lot (or have been tortured by them), I assume you would have added a
> timeout check if you had seen a lockup here.

I haven't seen any failure on that. We could add a timeout for
paranoia reasons. I'm quite sure that the raminit works as advertised
when we do it the right way. The only way to wreckage it so far is by
not waiting for it to complete.

Thanks,

	tglx
