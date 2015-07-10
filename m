From: Torsten Lang <torsten.lang@uweschneider.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Fri, 10 Jul 2015 11:17:54 +0200
Message-ID: <559F8DC2.2050002@uweschneider.de>
References: <559D35CA.2050402@uweschneider.de> <559E25FD.6030904@optusnet.com.au> <559E437E.308@uweschneider.de> <559E9509.1080406@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from groat.dascon.de ([195.225.198.185]:54998 "EHLO groat.dascon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339AbbGJJTG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 10 Jul 2015 05:19:06 -0400
In-Reply-To: <559E9509.1080406@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Tom,
it would be nice if you could mail me the patches you applied to the flexcan driver and kernel interrupt handling by mail so that I could try out if this solves the problems I still had with the "NO-NAPI" version I made of the 3.16 flexcan driver. I already integrated several patches I found in the net or received by mail.

Torsten

Am 09.07.2015 um 09:42 schrieb Tom Evans:
> On 09/07/15 00:38, Torsten Lang wrote:
>> It is based on the rework done by David Jander which disables
> > the only six messages deep hardware FIFO of the FlexCAN core
> > and instead uses all available mailboxes for reception.
>
> > #define FLEXCAN_MB_QUEUE_SIZE        62
>
> The FlexCAN Driver is not specific to the i.MX. It is used in other FreeScale parts. The early parts (ColdFire) have 16 buffers, didn't have "Message Queueing" or the FIFO, so aren't supported by Linux at all. The one in the
> MCF5441x had the FIFO, Message Queueing, but only 16 Messages. I don't know which ones are in the PPC chips. You may need to make the queue size settable in the Device Tree.
>
> Two years back I had FlexCAN overrunning. I found the problem to be that the driver reads the messages during NAPI, while the matching Ethernet driver read them during interrupts, and there was unnecessary kernel debugging on.
>
> I rewrote it to receive all messages during interrupts and haven't had any problems since. Is it "normal" to have interrupts locked out for more than 300us (six 50us CAN messages at 1MHz)? Shouldn't that be something that should be fixed? Or is having interrupts locked out for 3200us (64 message buffers) the new "normal"? 
Yes, I've also done such a rewrite for the kernel 3.16 supported by our board manufacturer. But still had problems with overruns. So I will check for any leftover debug settings etc. when I have some time again.

I've done some more tests with the patch I mailed under very heavy load (with small DLC) - it seems that we really have massive delays until NAPI polling starts, so even with my patch I can provoke message loss. What seems to work flawlessly is the sorting of the messages, so I think for the final solution I need to unload the mailboxes directly in the interrupt into an internal FIFO where the messages are sorted in by their timestamps.

But if leaving the RX interrupts active synchronization must be done very carefully as to my understanding NAPI was not meant to be done with active interrupts (that can trigger the NAPI polling again). You can easily create race conditions when the poll function is interrupted with a quota below the limit and between the unloading/polling code and the decision to deactivate the polling - the result would be that the interrupt handler would unload the mailboxes and tries to trigger NAPI (wich would be a no-op as it is still active) while after return the NAPI poll would turn off the polling without reading the messages left in the internal FIFO. This is where IMHO the code I've seen that unloads the hardware mailboxes into a buffer from the interrupt and clearing the buffer during NAPI pol
 l is wrong.

Am 09.07.2015 um 17:36 schrieb Tom Evans:
> On 9/07/2015 7:48 PM, Torsten Lang wrote:
>> Am 09.07.2015 um 09:42 schrieb Tom Evans:
>>> On 09/07/15 00:38, Torsten Lang wrote:
>>>> It is based on the rework done by David Jander which disables
>>>> the only six messages deep hardware FIFO of the FlexCAN core
>>>> and instead uses all available mailboxes for reception.
>
> That's such a big change to the driver (and given Holger's comments) I would suggest submitting it as a separate driver - "flexcan2.c", "flexcan-ng.c" or some such. Leave the old one alone, or fix it with Holger's unload-during-interrupts version or equivalent.
Either this or the driver would have to support FIFO mode (with the risk of data loss) and mailbox based queue depending on the available features.
>
>>> I'd be interested in reasons why the above isn't a
> >> good solution to this problem.
>>
>> I did tests with reading out the mailboxes directly in the interrupt
> > handler but still had problems.
>
> Time to run FTRACE and see what's broken or set wrong. Holger seems to have been hit with a broken SD driver. I found our kernel supplier had left all the semaphore/mutex/slub debugging on and that was making the kernel about 5 times slower than it should have been. Easily fixed once found.
>
> > From what I found during my search in the net the interrupt
> > handling implementation in Linux for the Freescale range of
> > SoCs seems to suck because it does not configure any interrupt
> > priorization and the interrupt handler "prefers" to handle
> > interrupts just by the bit order in the interrupt controller
> > could lead to very high latencies in case of FlexCAN interrupts.
>
> Yes, I fixed that too. A simple mod that created a TZIC version of "avic_irq_set_priority()", and calls to that from the platform setup. But I really miss having SIX different levels (that can happily interrupt each other) in M68k/ColdFire.
>
>> On which i.MX did you test your change with success?
>
> i.MX53.
>
> Holger has said:
> > The thing about the prioritization is true .. but it's not the
> > reason. Because even when you give the IRQs for the FlexCAN
> > the highest priority (I have a patch for this), then this
> > will only trigger if two interrupts arrive at the same
> > time. This is almost never.
>
> I don't think so. It only requires one interrupt to arrive when the previous one is still running. If the previous one is the FEC (Ethernet) AND I'm flood-pinging the thing hard AND the 3.4 FEC driver doesn't use NAPI then the CPU is spending a huge amount of time in the FEC ISR, followed by another run in the FEC ISR, and again; not letting CAN run. Elevating CAN't priority does help in this case.
>
> When you're playing whack-a-mole you have to whack all the moles...
>
> Tom
>

