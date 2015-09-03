From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ
 offloading
Date: Thu, 3 Sep 2015 08:32:08 +0200
Message-ID: <20150903083208.29333e01@archvile>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
	<55E78D42.1060109@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4540 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbbICGxa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 02:53:30 -0400
In-Reply-To: <55E78D42.1060109@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de


Dear Tom,

On Thu, 3 Sep 2015 09:58:58 +1000
Tom Evans <tom_usenet@optusnet.com.au> wrote:

> On 01/09/15 20:31, Marc Kleine-Budde wrote:
> > Hello,
> >
> > this series adds a software FIFO implementation and switches
>  > the flecan and at91 driver to it. It's intended for CAN cores
>  > with a higher number of mailboxes.
> 
> It is a bit difficult to understand the changed by looking at 20 patches, so 
> I'm assuming this is the change where what the i.MX6 manuals calls the 
> "Reception Queue" mode is enabled.
> 
> I see "[PATCH 1/8]" renaming "FLEXCAN_MCR_BCC" to "FLEXCAN_MCR_IRMQ" and 
> "[PATCH 2/8]" adding it to the MCR setting.
> 
> Use of the "Reception Queue" is documented in the i.MX6DQ manual in section 
> "26.6.5 Matching Process" as:
> 
>      By programming more than one MB with the same ID, received
>      messages will be queued into the MBs. ARM can examine the
>      Time Stamp field of the MBs to determine the order in which
>      the messages arrived.
> 
> Is the new code sorting the messages by using the timestamp, or have you
> found another way to guarantee reception order?

Almost. Generic code in can/dev.c cannot know about special features like
timestamps that some peripherals may provide. There is another way to
guarantee the reception order which is more generic, and is inspired by how
the at91can driver did things before this patch. It basically works like this:

The MB area is divided into two halves. For simplicity, we will assume that
your can controller (like flexcan) starts filling MB's from the lowest free MB
upwards. This can be the other way around for other controllers though.

In the RX interrupt we simply read out all MB's from the beginning that have
new messages (we keep track of where we were last time). In an atomic
operation, the MB's that have been served are now disabled. Once we reach the
second half of our MB space, all disabled MB's from the first half are enabled
again. The next time we hit the RX interrupt we first check if there are more
messages in the second half and handle those first and then start over again
from the bottom.

If there are pending MB's (with messages to be read) in the first MB and also
in the second half, we know there is an overflow. We still have all messages
but we cannot guarantee the ordering anymore. Therefor the lower half needs to
be big enough. Fortunately the flexcan controller has quite a big MB area
compared to its hardware FIFO, which is much smaller, so overall the
reliability of the driver is greatly improved. Not to mention the fact that
MB's are now also cleared in the hard-IRQ, which further reduces latency.

Best regards,

-- 
David Jander
Protonic Holland.
