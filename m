From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Wed, 05 Dec 2012 15:46:48 +0100
Message-ID: <4250988.UdN8LQq6de@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein> <50BF4326.4040507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:36850 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997Ab2LEOqw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 09:46:52 -0500
In-Reply-To: <50BF4326.4040507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang,

On Wednesday 05 December 2012 13:50:46, Wolfgang Grandegger wrote:
> Hi Alexander,
> 
> thanks for testing!. Maybe we deal with more than one problem.
> 
> On 12/05/2012 01:09 PM, Alexander Stein wrote:
> > Hello Wolfgang and others,
> > 
> > On Thursday 29 November 2012 15:39:40, Wolfgang Grandegger wrote:
> >> here is v2 of my patches for the C_CAN drivers.
> >>
> >> For Michael I have prepared out-of-tree driver sources allowing to
> >> easily build the drivers also for older 3.x kernel versions. More
> >> tester are welcome.
> >>
> >> Changes since v1:
> >>
> >> - use init callback after renaming it from initram
> >> - use different sets of interface registers for rx and tx (like PCH_CAN)
> >> - use spin_[un]lock_bh to protect the tx objects
> >>
> >> Wolfgang Grandegger (7):
> >>   pch_can: add spinlocks to protect tx objects
> >>   c_can: rename callback "initram" to "init" to more general usage
> >>   c_can: use different sets of interface registers for rx and tx
> >>   c_can_pci: introduce board specific PCI bar
> >>   c_can_pci: enable PCI bus master only for MSI
> >>   c_can_pci: add support for PCH CAN on Intel EG20T PCH
> >>   c_can: add spinlock to protect tx and  objects
> >>
> >>  drivers/net/can/c_can/c_can.c          |   66 
> > +++++++++++++++++++++-----------
> >>  drivers/net/can/c_can/c_can.h          |    3 +-
> >>  drivers/net/can/c_can/c_can_pci.c      |   56 
+++++++++++++++++++++++++--
> >>  drivers/net/can/c_can/c_can_platform.c |    2 +-
> >>  drivers/net/can/pch_can.c              |    9 +++++
> >>  5 files changed, 108 insertions(+), 28 deletions(-)
> > 
> > I backported the c_can patches incl. your patchset to v3.0.31 and tested 
this 
> > driver on our own custom atom board using the eg20t pch. CAN in general 
works, 
> 
> The out-of-tree archive may have worked for you as well.
> 
> A few general questions to understand your hardware and setup:
> 
> - Is this a multi-processor system (SMP)? If not, you may not run into
>   tx-not-working-any-more problem. Have you ever realized it?

This is a Intel E660 single core CPU with HT, so it is a SMP system. I'm 
currently not aware that tx is not working anymore.

> - Did you see the problems below with the old PCH_CAN driver as well.
> 
> - Do the problems show up with the still existing PCH_CAN driver
>   (including the "pch_can: add spinlocks to protect tx objects" patch)?

With the current version of pch_can from Linuxs' tree and the named patch I 
get at least some messaged twice.

> > but if I run my heavy CAN load testcase I get errors sometimes.
> > This test works as follows: I send a CAN message to 2 other CAN nodes 
> > configuring some timings (like burst length or time between each can 
frame) 
> > and they send 250000 messages each containing a counter. This way I can 
detect 
> > any missing or switched message with a high bus load.
> > If I use the described software state alone it works, but if I run 'watch 
> > sensors' in a different ssh session, CAN start to misbehave like missing 
CAN 
> > frames or switched order. It seems that I2C usage on the PCH influences 
the 
> > CAN part also:
> 
> - When your app sends/writes messages, does it check for errno==ENOBUFS?

My test application sends only 1 message each test run to start the other 
nodes. It checks ENOBUFS and returns an error in that case. Though I've never 
seen that.

> - The messages look still ok (not currupted, I mean)?

The received frames all look good (despite wrong counter sometimes due to 
wrong order or lost frames).

> > Even worse, if I use the following patch to check if PCI writes were 
> > successfully, I notices that some writes (or the consecutive read) don't 
> > succeed. And I also get lots of I2C timeouts waiting for a xfer complete.
> 
> Be careful, there might be some registers changing their values after
> writing. Can you show the value read after writing and the register
> offset? The influence on the I2C bus looks more like an overload or
> hardware problem. What is your CAN interrupt rate?

I get about 33 interrupts per second on i2c. On a successful run I get 366886 
interrupts for 500000 messages with the c_can driver.

Here are some failed writes to the CAN controller.
[   50.445695] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x4 failed. 
got: 0x10
[   51.043027] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
got: 0x0
[... repeats several times]
[   64.046031] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
got: 0x0
[   64.458286] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 failed. 
got: 0xb8
[   64.811025] c_can_pci 0000:02:0c.3: can0: write 0xe to offset 0x0 failed. 
got: 0x0
and the last one is repeated all the time.

Some times I also get the 16 of the following message:
c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. got: 0x2000

> Do you see this problem with the old PCH_CAN driver as well?

With pch_can I get about 254000 interrupts for about 283000 frames.

[ 2422.198378] regs base: f8f5a000
[ 2449.197911] pch_can_bit_clear: clear bit failed: addr: f8f5a038, reg1: 
0x1404, reg2: 0x8, mask 0xa000
[ 2458.302028] pch_can_bit_set: set bit failed: addr: f8f5a000, reg1: 0x80, 
reg2: 0x80, mask 0xe

On the second line you can see that the register isn't written at all (or the 
read failed for some reason).

> > Does anybody have an idea what's going wrong here? Is somebody able to see 
the 
> > same problems on their hardware?
> 
> At least you are the first one reporting this problem.
> 
> > Wolfgang: Compared to your v8 c_can drivers for Michael, I'm just missing 
the 
> > const bitrate table and don't use pci_register_driver, as I have cherry-
picked 
> > the module_pci_driver patches.
> 
> What do you mean with "missing the const bitrate table"?

I do not have cherry-picked commit 194b9a4cb91713ddb60c9f98f7212f6d8cb8e05f.

Best regards,
Alexander

