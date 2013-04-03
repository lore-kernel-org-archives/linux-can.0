From: "Boris Baskevitch" <boris.baskevitch@annecy-elec.fr>
Subject: RE: BCM periodic send
Date: Wed, 3 Apr 2013 11:46:23 +0200
Message-ID: <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr>
References: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr> <5154B38F.5080404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from riga.magic.fr ([188.130.33.24]:43674 "HELO riga.magic.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763313Ab3DCJq0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 3 Apr 2013 05:46:26 -0400
In-Reply-To: <5154B38F.5080404@hartkopp.net>
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Oliver Hartkopp' <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Olivier,

> > I need some help on 2 issues, I'm using Socket-CAN BCM feature to send
> > and receive periodic messages:
> > I configured some periodic TX messages as shown below. It works great
> > except the fact that the actual period on the bus doesn't exactly
> > match the programmed period, it's a little slower, so I need to add a
> > correction factor to get the right period. I guess it's my system
> > timer which is incorrectly configured (I use a Fujitsu SoC with ARM
> > Cortex A9). I don't set the Jiffie parameter during the boot, so it's
> > recalculated each time I power-up the board. I don't know what is the
> > time reference for Socket-CAN (jiffies or something else?), do you
> > know where should I look to correct it ?
> 
> 
> The BCM has been moved from jiffies to Linux hrtimers a long time ago in
> 2.6.26.
> What Linux kernel version do you use?

I use Linux 3.0.3

> Btw. have you tried a virtual CAN interface? Do you have similar problems
> there?

Yes. It must be linked to my  CLOCK_TICK_RATE constant. I'm using a 66.66MHz
reference clock, so probably a rounding issue. I'm doing some investigation
on this point.

> > Second point, I would like to change the content of the periodic
> > frames at runtime without reconfiguring the timer, ID and flags. What
> > is the most elegant way to do it ?
> 
> 
> Send a TX_SETUP without "SETTIMER|STARTTIMER" in msg_head.flags, is the
> really most elegant way :-)

OK, thanks.

Now I have a new issue, the BCM report a RX_TIMEOUT for all periodic
messages, even if the message is present on the bus with a shorter period
than the one I configured in the BCM.
The message is correctly received as I can get the RX_CHANGED message for
the corresponding IDs.
If I use RX_FILTER_ID option, I get a RX_CHANGED and RX_TIMEOUT for each
message seen the bus (which is correct for RX_CHANGED, but not for
RX_TIMEOUT).
By the way, for a periodic RX message, which parameter is the period, ival1
or ival2 ? (I had both set for the tests)

Boris.


