From: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Subject: Re: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off
 to reduce irq flood
Date: Sun, 18 Jan 2015 19:52:56 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1501181938030.32136@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login>
 <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login> <54BBFCAF.2090603@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.renyi.hu ([193.224.79.18]:37869 "EHLO smtp.renyi.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbbARSxG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 18 Jan 2015 13:53:06 -0500
In-Reply-To: <54BBFCAF.2090603@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viktor Babrian <babrian.viktor@renyi.mta.hu>, Andri Yngvason <andri.yngvason@marel.com>, Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org


> NACK. The transitions are important for some applications. I've an not
> yet mainlined series that limits the bus errors. I'm going to port them
> to the current kernel tomorrow. Can you test it?

This controller simply does not have a warn->pass state transition 
interrupt. The only way to accurately (right on time) report this 
transition is to switch on all error interrupts (ie the status interrupt) 
that cause interrupt flood in some scenarios e.g. when frame is not acked 
by other parties.
If we don't turn on the status interrupt, the warn->pass state transition 
can be detected later on a successful rx/tx event (or when entering bus 
off etc).

I have learned that the warn->pass transition interrupt is also missing 
from other controllers as well (like Flexcan). Interrupt flood caused by 
enabling error interrupts regardless of the berr-reporting state is an 
issue there too.

Also note that when the system is flooded by these error interrupts, 
system performace degrades so much that serial terminal echo becomes 
annoyingly long. When this happens, I wonder how usable the "accurate" 
state transition reports are anyway.

Regards,
Viktor



