From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ
 offloading
Date: Thu, 3 Sep 2015 10:38:27 +0200
Message-ID: <20150903103827.5d08e957@archvile>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
	<55E78D42.1060109@optusnet.com.au>
	<20150903083208.29333e01@archvile>
	<55E7EF8D.306@pengutronix.de>
	<55E80231.30808@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5809 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbICIi3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 04:38:29 -0400
In-Reply-To: <55E80231.30808@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On Thu, 3 Sep 2015 18:17:53 +1000
Tom Evans <tom_usenet@optusnet.com.au> wrote:

> On 03/09/15 16:58, Marc Kleine-Budde wrote:
> > On 09/03/2015 08:32 AM, David Jander wrote:
> >>>> this series adds a software FIFO implementation and switches
> 
> Thank you both for explaining that.
> 
> It seems fairly bulletproof as long as it doesn't overflow. There are 64 
> buffers, so 32 in the first half, so that handles a 1.5ms interrupt latency.
> 
> A shame Freescale didn't think of that method instead of requiring the
> driver run quicksort somewhere.
> 
>  > In an atomic operation, the MB's that have been served are
>  > now disabled.
> 
> That's the sort of tricky operation that exposes nasty silicon bugs. I'd 
> suggest that this mode be made easy to turn off in case some chip variant
> has a problem like htis.

The use of RX-FIFO, either the simple IRQ off-load or full implementation for
linear MB areas is selectable and optional. Each driver can choose to use the
mechanism most suited for it. If there are silicon-bugs, the necessary
run-time detection in the driver should choose to use or not to use either.

> This feature looks to be enabled as a "QUIRK" of the CPU.

Not really. The problem with flexcan specifically is that the flexcan cores
prior to revision 10 are not able to receive RTR messages in the MB area, so
using the full implementation of RX-FIFO in that case would break RTR
reception. That's the reason why for V10 and newer flexcan cores we use the
full implementation, while for older ones, the simple IRQ off-load method is
used, retaining the hardware FIFO functionality of the peripheral.

The fact that these "FEATURE" bits where all renamed to be "QUIRK"s is 75%
better than before, but in this case (the other 25%) the name "FEATURE" would
be more fitting, I agree :-)

> In an old generation kernel this might be optionally enabled in the .config 
> file, as NAPI is in the 2.6.35 FEC drivers I'm stuck with using at the
> moment on the i.MX53. In the current kernel, could this mode of operation
> (and/or hardware FIFO using NAPI) be made configurable in the Device Tree
> instead?

Why would you want to do that? It should be known to either work or not for
specific hardware (-version), so the decision can be hard-coded in the driver.
In other words: if RX-FIFO works fine for your chip, why would you ever want
to disable it in the DT?

Best regards,

-- 
David Jander
Protonic Holland.
