From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 09 Jul 2015 17:42:53 +1000
Message-ID: <559E25FD.6030904@optusnet.com.au>
References: <559D35CA.2050402@uweschneider.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:55659 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750728AbbGIHm4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 03:42:56 -0400
In-Reply-To: <559D35CA.2050402@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

On 09/07/15 00:38, Torsten Lang wrote:
> It is based on the rework done by David Jander which disables
 > the only six messages deep hardware FIFO of the FlexCAN core
 > and instead uses all available mailboxes for reception.

 > #define FLEXCAN_MB_QUEUE_SIZE		62

The FlexCAN Driver is not specific to the i.MX. It is used in other FreeScale 
parts. The early parts (ColdFire) have 16 buffers, didn't have "Message 
Queueing" or the FIFO, so aren't supported by Linux at all. The one in the
MCF5441x had the FIFO, Message Queueing, but only 16 Messages. I don't know 
which ones are in the PPC chips. You may need to make the queue size settable 
in the Device Tree.

Two years back I had FlexCAN overrunning. I found the problem to be that the 
driver reads the messages during NAPI, while the matching Ethernet driver read 
them during interrupts, and there was unnecessary kernel debugging on.

I rewrote it to receive all messages during interrupts and haven't had any 
problems since. Is it "normal" to have interrupts locked out for more than 
300us (six 50us CAN messages at 1MHz)? Shouldn't that be something that should 
be fixed? Or is having interrupts locked out for 3200us (64 message buffers) 
the new "normal"?

I'd be interested in reasons why the above isn't a good solution to this problem.

 > The mailboxes now are serviced as recommended by Freescale's i.MX6
 > user's manual,

Which recommends sorting the messages by 16-bit hardware timestamps.

 > and the servicing as such has been moved completely
 > over to the NAPI poll function.

Are you sure NAPI won't get delayed by more than 3.2ms? It should have a worse 
latency than the raw interrupts. Which is the "worst" and more/less likely, a 
300us Interrupt latency or a 3200us NAPI latency (800us on 16-buffer models)?

> P. S.The main remaining problem is that my application no longer
 > receives the CAN messages correctly with kernel 4.1 ... it only receives
 > single messages about every 30..60s ... As soon as I start a candump in
 > parallel my application also receives the test messages. I currently
 > have no explanation for this behaviour.

I think I remember a recent post noting that problem, but searching the list 
on gmane doesn't find it for me. I hope someone else remembers and posts the 
patch that caused this problem and the one that fixed it. It might have had 
something to do with candump having filter-setting added.

Tom

