From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 20:32:14 +0100
Message-ID: <4F3C083E.5080709@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net> <4F3B58D1.1040804@grandegger.com> <4F3B6755.7080602@hartkopp.net> <4F3B6EC7.2090400@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:15741 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab2BOTc0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 14:32:26 -0500
In-Reply-To: <4F3B6EC7.2090400@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 15.02.2012 09:37, Wolfgang Grandegger wrote:


> Why do we care so much about improper handling of the hardware. It is
> *illegal* to unplug the device while it's under operation and if it
> happens we cannot guarantee valid behavior and data anyway. The system
> should not hang, of course, everything else is not that dramatic, I
> think. Mark, what is your opinion?


Hello Wolfgang,

i wonder if people will stop pulling hotplug devices because it is *illegal*

http://www.deq.louisiana.gov/portal/portals/0/news/pdf/IllegalDumpingSign.jpg

Really funny :-)

Btw. i started to implement some code that catches every issue that can occur
when unplugging a sja1000 device:

1. Adding a new flag SJA1000_CHECK_FOR_UNPLUG to be checked via priv->flags

2. Adding the checks to sja1000_interrupt()

3. Adding the checks to sja1000_rx & sja1000_err right before netif_rx(skb)

Finally i came to the conclusion that this was a lot of stuff for a pretty
rare situation. IMO we should only fix a potential hang of the isr and ignore
the damaged data which is probably generated at plug-out.

That's why i sent the "[PATCH v2] can: sja1000 fix isr hang when hw is
unplugged under load" which does exactly fix that issue and is pretty cheap
with additional register reads.

Please consider that patch for inclusion.

Tnx & regards,
Oliver

