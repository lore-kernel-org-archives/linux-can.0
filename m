From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Wed, 05 Dec 2012 18:35:25 +0100
Message-ID: <50BF85DD.6090809@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein> <50BF4326.4040507@grandegger.com> <4250988.UdN8LQq6de@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51481 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2LERf2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 12:35:28 -0500
In-Reply-To: <4250988.UdN8LQq6de@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/05/2012 03:46 PM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> On Wednesday 05 December 2012 13:50:46, Wolfgang Grandegger wrote:
>> Hi Alexander,
>>
>> thanks for testing!. Maybe we deal with more than one problem.
>>
...
>> A few general questions to understand your hardware and setup:
>>
>> - Is this a multi-processor system (SMP)? If not, you may not run into
>>   tx-not-working-any-more problem. Have you ever realized it?
> 
> This is a Intel E660 single core CPU with HT, so it is a SMP system. I'm 
> currently not aware that tx is not working anymore.

OK, your send rate is very low and therefore it's unlikely that you hit
that problem.

>> - Did you see the problems below with the old PCH_CAN driver as well.
>>
>> - Do the problems show up with the still existing PCH_CAN driver
>>   (including the "pch_can: add spinlocks to protect tx objects" patch)?
> 
> With the current version of pch_can from Linuxs' tree and the named patch I 
> get at least some messaged twice.

OK, sounds better but also not good.

>>> but if I run my heavy CAN load testcase I get errors sometimes.
>>> This test works as follows: I send a CAN message to 2 other CAN nodes 
>>> configuring some timings (like burst length or time between each can 
> frame) 
>>> and they send 250000 messages each containing a counter. This way I can 
> detect 
>>> any missing or switched message with a high bus load.
>>> If I use the described software state alone it works, but if I run 'watch 
>>> sensors' in a different ssh session, CAN start to misbehave like missing 
> CAN 
>>> frames or switched order. It seems that I2C usage on the PCH influences 
> the 
>>> CAN part also:
>>
>> - When your app sends/writes messages, does it check for errno==ENOBUFS?
> 
> My test application sends only 1 message each test run to start the other 
> nodes. It checks ENOBUFS and returns an error in that case. Though I've never 
> seen that.

OK, your TX rate it low.

> 
>> - The messages look still ok (not currupted, I mean)?
> 
> The received frames all look good (despite wrong counter sometimes due to 
> wrong order or lost frames).
> 
>>> Even worse, if I use the following patch to check if PCI writes were 
>>> successfully, I notices that some writes (or the consecutive read) don't 
>>> succeed. And I also get lots of I2C timeouts waiting for a xfer complete.
>>
>> Be careful, there might be some registers changing their values after
>> writing. Can you show the value read after writing and the register
>> offset? The influence on the I2C bus looks more like an overload or
>> hardware problem. What is your CAN interrupt rate?
> 
> I get about 33 interrupts per second on i2c. On a successful run I get 366886 
> interrupts for 500000 messages with the c_can driver.

In what time? Is the CAN bus highly loaded.

> Here are some failed writes to the CAN controller.
> [   50.445695] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x4 failed. 
> got: 0x10
> [   51.043027] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
> got: 0x0
> [... repeats several times]
> [   64.046031] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
> got: 0x0
> [   64.458286] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. 
> got: 0xb8
> [   64.811025] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
> got: 0x0
> and the last one is repeated all the time.

That's wired! Writing 0xe to offset 0x0 does re-enable the interrupts at
the end of poll-rx. Disabling the interrupts in the isr does not show
that symptoms. Strange.

> Some times I also get the 16 of the following message:
> c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. got: 0x2000


>> Do you see this problem with the old PCH_CAN driver as well?
> 
> With pch_can I get about 254000 interrupts for about 283000 frames.
> 
> [ 2422.198378] regs base: f8f5a000
> [ 2449.197911] pch_can_bit_clear: clear bit failed: addr: f8f5a038, reg1: 
> 0x1404, reg2: 0x8, mask 0xa000
> [ 2458.302028] pch_can_bit_set: set bit failed: addr: f8f5a000, reg1: 0x80, 
> reg2: 0x80, mask 0xe

That's the same thing as with the c_can driver when the interrupts gets
re-enabled.

> On the second line you can see that the register isn't written at all (or the 
> read failed for some reason).

I assume the latter. Could you please retry reading the register until
the correct value shows up. With some timeout, of course.

I checked the PCH ethernet driver and did not find anythings special
accessing registers. Maybe Tomoya has an idea or could tell use somebody
at OKI/LAPIS Semiconductor who could help. Tomoya?

Wolfgang.

