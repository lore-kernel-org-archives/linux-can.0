From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Fri, 10 Jul 2015 01:36:41 +1000
Message-ID: <559E9509.1080406@optusnet.com.au>
References: <559D35CA.2050402@uweschneider.de> <559E25FD.6030904@optusnet.com.au> <559E437E.308@uweschneider.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36737 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751818AbbGIPgs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 11:36:48 -0400
In-Reply-To: <559E437E.308@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

On 9/07/2015 7:48 PM, Torsten Lang wrote:
> Am 09.07.2015 um 09:42 schrieb Tom Evans:
>> On 09/07/15 00:38, Torsten Lang wrote:
>>> It is based on the rework done by David Jander which disables
>>> the only six messages deep hardware FIFO of the FlexCAN core
>>> and instead uses all available mailboxes for reception.

That's such a big change to the driver (and given Holger's comments) I 
would suggest submitting it as a separate driver - "flexcan2.c", 
"flexcan-ng.c" or some such. Leave the old one alone, or fix it with 
Holger's unload-during-interrupts version or equivalent.

>> I'd be interested in reasons why the above isn't a
 >> good solution to this problem.
>
> I did tests with reading out the mailboxes directly in the interrupt
 > handler but still had problems.

Time to run FTRACE and see what's broken or set wrong. Holger seems to 
have been hit with a broken SD driver. I found our kernel supplier had 
left all the semaphore/mutex/slub debugging on and that was making the 
kernel about 5 times slower than it should have been. Easily fixed once 
found.

 > From what I found during my search in the net the interrupt
 > handling implementation in Linux for the Freescale range of
 > SoCs seems to suck because it does not configure any interrupt
 > priorization and the interrupt handler "prefers" to handle
 > interrupts just by the bit order in the interrupt controller
 > could lead to very high latencies in case of FlexCAN interrupts.

Yes, I fixed that too. A simple mod that created a TZIC version of 
"avic_irq_set_priority()", and calls to that from the platform setup. 
But I really miss having SIX different levels (that can happily 
interrupt each other) in M68k/ColdFire.

> On which i.MX did you test your change with success?

i.MX53.

Holger has said:
 > The thing about the prioritization is true .. but it's not the
 > reason. Because even when you give the IRQs for the FlexCAN
 > the highest priority (I have a patch for this), then this
 > will only trigger if two interrupts arrive at the same
 > time. This is almost never.

I don't think so. It only requires one interrupt to arrive when the 
previous one is still running. If the previous one is the FEC (Ethernet) 
AND I'm flood-pinging the thing hard AND the 3.4 FEC driver doesn't use 
NAPI then the CPU is spending a huge amount of time in the FEC ISR, 
followed by another run in the FEC ISR, and again; not letting CAN run. 
Elevating CAN't priority does help in this case.

When you're playing whack-a-mole you have to whack all the moles...

Tom

