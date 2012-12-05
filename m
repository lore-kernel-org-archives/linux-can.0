From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Wed, 05 Dec 2012 13:50:46 +0100
Message-ID: <50BF4326.4040507@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:52123 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2LEMut (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 07:50:49 -0500
In-Reply-To: <2955657.EIGT0HjrVV@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hi Alexander,

thanks for testing!. Maybe we deal with more than one problem.

On 12/05/2012 01:09 PM, Alexander Stein wrote:
> Hello Wolfgang and others,
> 
> On Thursday 29 November 2012 15:39:40, Wolfgang Grandegger wrote:
>> here is v2 of my patches for the C_CAN drivers.
>>
>> For Michael I have prepared out-of-tree driver sources allowing to
>> easily build the drivers also for older 3.x kernel versions. More
>> tester are welcome.
>>
>> Changes since v1:
>>
>> - use init callback after renaming it from initram
>> - use different sets of interface registers for rx and tx (like PCH_CAN)
>> - use spin_[un]lock_bh to protect the tx objects
>>
>> Wolfgang Grandegger (7):
>>   pch_can: add spinlocks to protect tx objects
>>   c_can: rename callback "initram" to "init" to more general usage
>>   c_can: use different sets of interface registers for rx and tx
>>   c_can_pci: introduce board specific PCI bar
>>   c_can_pci: enable PCI bus master only for MSI
>>   c_can_pci: add support for PCH CAN on Intel EG20T PCH
>>   c_can: add spinlock to protect tx and  objects
>>
>>  drivers/net/can/c_can/c_can.c          |   66 
> +++++++++++++++++++++-----------
>>  drivers/net/can/c_can/c_can.h          |    3 +-
>>  drivers/net/can/c_can/c_can_pci.c      |   56 +++++++++++++++++++++++++--
>>  drivers/net/can/c_can/c_can_platform.c |    2 +-
>>  drivers/net/can/pch_can.c              |    9 +++++
>>  5 files changed, 108 insertions(+), 28 deletions(-)
> 
> I backported the c_can patches incl. your patchset to v3.0.31 and tested this 
> driver on our own custom atom board using the eg20t pch. CAN in general works, 

The out-of-tree archive may have worked for you as well.

A few general questions to understand your hardware and setup:

- Is this a multi-processor system (SMP)? If not, you may not run into
  tx-not-working-any-more problem. Have you ever realized it?

- Did you see the problems below with the old PCH_CAN driver as well.

- Do the problems show up with the still existing PCH_CAN driver
  (including the "pch_can: add spinlocks to protect tx objects" patch)?

> but if I run my heavy CAN load testcase I get errors sometimes.
> This test works as follows: I send a CAN message to 2 other CAN nodes 
> configuring some timings (like burst length or time between each can frame) 
> and they send 250000 messages each containing a counter. This way I can detect 
> any missing or switched message with a high bus load.
> If I use the described software state alone it works, but if I run 'watch 
> sensors' in a different ssh session, CAN start to misbehave like missing CAN 
> frames or switched order. It seems that I2C usage on the PCH influences the 
> CAN part also:

- When your app sends/writes messages, does it check for errno==ENOBUFS?

- The messages look still ok (not currupted, I mean)?

> Even worse, if I use the following patch to check if PCI writes were 
> successfully, I notices that some writes (or the consecutive read) don't 
> succeed. And I also get lots of I2C timeouts waiting for a xfer complete.

Be careful, there might be some registers changing their values after
writing. Can you show the value read after writing and the register
offset? The influence on the I2C bus looks more like an overload or
hardware problem. What is your CAN interrupt rate?
Do you see this problem with the old PCH_CAN driver as well?

> Does anybody have an idea what's going wrong here? Is somebody able to see the 
> same problems on their hardware?

At least you are the first one reporting this problem.

> Wolfgang: Compared to your v8 c_can drivers for Michael, I'm just missing the 
> const bitrate table and don't use pci_register_driver, as I have cherry-picked 
> the module_pci_driver patches.

What do you mean with "missing the const bitrate table"?

Wolfgang.

