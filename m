From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Tue, 11 Dec 2012 21:24:57 +0100
Message-ID: <50C79699.1070801@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <2331999.ZYFOYXdjyx@ws-stein> <50C1160A.20203@grandegger.com> <1647541.efLPJ8JS7c@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55032 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab2LKUZA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 15:25:00 -0500
In-Reply-To: <1647541.efLPJ8JS7c@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org

On 12/10/2012 09:21 AM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> I expect you meant me.
> 
> On Thursday 06 December 2012 23:02:50, Wolfgang Grandegger wrote:
>> Hi Michael,
>>
>> On 12/06/2012 06:05 PM, Alexander Stein wrote:
>>> Hi Michael,
>>>
>>> On Thursday 06 December 2012 15:49:03, Wolfgang Grandegger wrote:
>>>>> Details of the soak test:
>>>>>
>>>>> There are two systems involved in the test: the PCH-System and an External Node.
>>>>> The External Node transmits data at a high rate, bringing bus utilization to
>>>>> ~35%.
>>>>> The PCH-System also transmits data, in bursts of 10 messages every 5 ms.
>>>>> Combined, the two systems utilize ~90% of bus bandwidth.
>>>>> The PCH-System is constantly checking that it is receiving data from the
>>>>> External Node at the expected rate and in the expected order.
>>>
>>> So you do a lot of transmit and reception of CAN frames?
>>>
>>>> On another thread Alexander is reporting problems with the same driver
>>>> when he runs a I2C application concurrently. Are you able to stress the
>>>> system in a similar way?
>>>
>>> Could you please test with the following patch? Do you see error messages from this patch?
>>> Thanks!
>>
>> To summarize my understanding of your problem(s). As long as there are
>> no I2C transfers, everything works fine, right? The patch below does
>> report some write-readback failures but that's due to reserved read-only
>> bits. I assume t hat you also use my "RFC v2" patches for c_can.
> 
> Yes, I think so, here is the list of patches I cherry-picked or picked from the ML. The first one is the patch I posted on the ML:
> # git logone v3.0.31.. drivers/net/can/c_can
> eca55a90f1b459412fe6a06ade04168953b0cc0a c_can_pci: check writes in c_can_pci_write_reg_32bit
> b30cd6e97e33c18b302acc069d4306976640005d c_can: add spinlock to protect tx and rx objects
> 8c0da92b71d15384e2e10b42eb9fee1d7566c91a c_can_pci: add support for PCH CAN on Intel EG20T PCH
> 3baeb05d514ae29959fccf57ef1d25d4e405ea2a c_can_pci: enable PCI bus master only for MSI
> 3bfe69aa4755e55067fb3100889557fb6784f5aa c_can_pci: introduce board specific PCI bar
> ccb01456b3776d89d01f240ea4ca781139b8ca1f c_can: use different sets of interface registers for rx and tx
> 7369cf2ce4afeea3a4e9440ce057fc8ac0781bae c_can: rename callback "initram" to "init" to more general usage
> 8abbf3fafbca7bcedd7e63261918d98c2aa7b5b2 can: c_can_platform: add MODULE_DEVICE_TABLE
> cf565c2f35b6df83cc2d9b1746aa78ed95a1c564 can: c_can: Add d_can raminit support
> 1ecf42b14e6acac66340347c59b15395ebdae8d2 can: c_can: fix segfault during rmmod
> 7031adc8ad27677f9ca53f41aeecc561e2855a9e can: c_can: Adopt pinctrl support
> c461df9e2bb51973b2290d74428a9e86d8a832f4 can: c_can: Add d_can suspend resume support
> f76251a1154c2fe2d485c2bc0e6bb319f95c89ef can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
> c8eb3d0dad64123fc758518a12907293d68b64a2 can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
> 645820279b5dc4b2f6137267f779592caed225c5 can: c_can: Modify c_can device names
> 833a73a775d15141651eac682c958041ad74b6d5 net/c_can: remove conditional compilation of clk code
> f76327017fa0ee6048322a603738849fde8b0fee can: c_can_pci: fix compilation on non HAVE_CLK archs
> e8a58d604a51bf4a2b8a46999ad7615d6c93ee85 c_can_pci: generic module for C_CAN/D_CAN on PCI
> 0621d4c54a9451df25f5c26bedd64cdaafca2fbc can: c_can: precedence error in c_can_chip_config()
> e0c82e969269124ac47f75c0dd44e59f63845d02 can: c_can: Add support for Bosch D_CAN controller
> 5957e31284f50c7af4537ebfb45659c42afaa112 can: c_can: Move overlay structure to array with offset as index
> 374b3b34644553d03c4f1714c2a14d8810af1c68 can: c_can: fix race condition in c_can_open()
> a2101117c4edfd9ec6fb059094ab74e4235da2e3 can: c_can: fix an interrupt thrash issue with c_can driver
> 20db935eff7b0ff4f1842f4de1f4e7f946d313dc can: c_can: fix "BUG! echo_skb is occupied!" during transmit
> 756f86a219db885c7b5aacf70ddefe961aad118a can: c_can: remove duplicated #include

Oops, that's a rather long lisst of fixes and improvements.

> 
>> Trouble starts with concurrent I2C transfers. Then the protected
>> write-readback test fails, which I regard as abnormal hardware behavior,
>> resulting in message losses and out-of-order reception.
> 
> I cannot say if any (small) I2C transfer at all raises the problem. I run 'cangen -I 0x300 can0' on my PC connected to my test board. A I2C connected LED is triggered by heartbeat thus there is a small I2C traffic each second. I couldn't see any errors in dmesg in about 10 minutes.
> But even with that small CAN traffic (next to nothing) a 'watch sensors' (which queries several I2C sensors every 2s) caused errors in dmesg. It seems the problem isn't related to CAN bus load at all.

Yes, that's also my impression. Most likely it's a problem on the PCI
bus with caching or concurrent access. Any chance to use a more recent
version of the Linux kernel?

Wolfgang.

