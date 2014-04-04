From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 4 Apr 2014 21:51:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404042129000.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EEEC8.3090905@hartkopp.net> <alpine.DEB.2.02.1404042055020.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43108 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbaDDTvD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 15:51:03 -0400
In-Reply-To: <alpine.DEB.2.02.1404042055020.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 4 Apr 2014, Thomas Gleixner wrote:
> On Fri, 4 Apr 2014, Oliver Hartkopp wrote:
> > +config CAN_C_CAN_STRICT_FRAME_ORDERING
> > +	bool "Force a strict RX CAN frame order (may cause frame loss)"
> > +	---help---
> > +	  The RX split buffer prevents packet reordering but can cause packet
> > +	  loss. Only enable this option when you accept to lose CAN frames
> > +	  in favor of getting the received CAN frames in the correct order.
> > +

Thought about it some more.

Fact is that the reordering is extremly hard to trigger.

So now the question is how many real world scenarios are prone to
reordering issues?

I can't answer that question, but you might be able to shed some light
on it.

Sure sniffers might show different ordering, but are you running two
sniffers on the same bus, except when you are debugging a completely
insane problem related to ordering issues?

How many of the real world protocols do really care about ordering? I
know there are some streaming protocols, but they have a crc or some
other mechanism to deal with lost/reordered frames. If there is a
streaming protocol which does not have that, should we really care?

The common case were a gazillion of nodes sends data at the same time
to different identifiers does probably not care about reordering at
all because there is no guarantee that node A is always sending its
answer to the sync frame to id X before node B sends to id Y.

Thoughts?

Thanks,

	tglx





