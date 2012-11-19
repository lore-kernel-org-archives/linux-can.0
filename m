From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Mon, 19 Nov 2012 17:31:34 +0100
Message-ID: <50AA5EE6.6060105@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38949 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab2KSQbi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Nov 2012 11:31:38 -0500
In-Reply-To: <loom.20121119T171647-35@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/19/2012 05:20 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>>
>> On 11/19/2012 04:10 PM, Michael Pellegrini wrote:
>>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>>
>>>>
>>>> On 11/15/2012 10:34 PM, Michael Pellegrini wrote:
>>>>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>>>>
>>>>>> I need to check first if this driver can be supported with little effort.
>>>>>
>>>>> Thank you for your consideration.
>>>>
>>>> For simple out-of-tree build I have now extracted the most recent
>>>> version of c_can and c_can_pci driver files, backported it to v3.2 and
>>>> added the PCH related code.
>>>>
>>>> You should be able to build these drivers on your system as shown below:
>>>>
>>>>   $ tar xf c-can-pci-v1.tar.bz2
>>>>   $ cd c-can-pci-v1
>>>>   $ CONFIG_CAN_C_CAN_PCI=m \
>>>>     make -C /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules
>>>>
>>>> This requires that you have the kernel header, gcc and fiends installed
>>>> on your system.
>>>>
>>>> Then you can load the modules as shown below, after unloading the
>>>> original C_CAN modules:
>>>>
>>>>   $ sudo modprobe can_dev
>>>>   $ rmmod c_can
>>>>   $ rmmod c_can_pci
>>>>   $ sudo insmod c_can.ko
>>>>   $ sudo insmod c_can_pci.ko
>>>>
>>>> Hope it works as expected. 
>>>
>>> I got the modules built, however loading them results in a non-functional 
> CAN 
>>> interface.  can0 no longer shows up in "ifconfig" or "ip".  Upon loading the 
>>> modules, dmesg prints the following:
>>>
>>> [ 2786.244341] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> 
> IRQ 
>>> 18
>>> [ 2786.244381] c_can_pci 0000:02:0c.3: setting latency timer to 64
>>> [ 2786.244497] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
>>> [ 2786.244523] c_can_pci 0000:02:0c.3: device has no PCI memory resources, 
>>> failing adapter
>>> [ 2786.244586] c_can_pci 0000:02:0c.3: PCI INT C disabled
>>> [ 2786.244611] c_can_pci: probe of 0000:02:0c.3 failed with error -12
>>
>> "-ENOMEM", ah, the PCH uses PCI Bar 1 (instead of 0). I missed that.
>> Could you please replace:
>>
>> 	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
>>
>> with
>>
>> 	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 0));
>>
>> in c_can_pci and retry.
>>
>> Wolfgang.
> 
> I made the change, the module crashes on load now.  Dmesg output is:

Grrr, sorry, it should be :

	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 1));

Wolfgang.

