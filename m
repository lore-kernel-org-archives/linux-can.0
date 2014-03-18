From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 01/12] can: c_can: Wait for CONTROL_INIT to be cleared
Date: Tue, 18 Mar 2014 19:19:30 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1403181918380.18573@ionos.tec.linutronix.de>
References: <20140318171007.528610837@linutronix.de> <20140318171126.593414691@linutronix.de> <53288C47.5090308@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56291 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924AbaCRSTV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Mar 2014 14:19:21 -0400
In-Reply-To: <53288C47.5090308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Markus Pargmann <mpa@pengutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org

On Tue, 18 Mar 2014, Marc Kleine-Budde wrote:
> On 03/18/2014 06:19 PM, Thomas Gleixner wrote:
> > According to the documentation the CPU must wait for CONTROL_INIT to
> > be cleared before writing to the baudrate registers.
> 
> Thanks for the catch.
> > +	return c_can_wait_for_ctrl_init(dev, priv, 0);
> 
> I'll post a patch that adds return value checking of all direct and
> indirect users of c_can_set_bittiming().

Right, I forgot to mention, that an error return gets lost in lala
land.

Thanks,

	tglx
