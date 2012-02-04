From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Sat, 04 Feb 2012 10:39:48 +0100
Message-ID: <4F2CFCE4.4010705@hartkopp.net>
References: <1328280824-11331-1-git-send-email-s.grosjean@peak-system.com> <4F2C0534.2000305@hartkopp.net> <4F2C371B.3000702@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:17924 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2BDJkD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 4 Feb 2012 04:40:03 -0500
In-Reply-To: <4F2C371B.3000702@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 03.02.2012 20:35, Wolfgang Grandegger wrote:

> On 02/03/2012 05:03 PM, Oliver Hartkopp wrote:
>> Hallo Stephane,
>>
>> looks really nice now.
>>
>> Just a single question:
>>
>> On 03.02.2012 15:53, Stephane Grosjean wrote:
>>
>>> - the PCANExpressCard device id is finally let into the device_id table even
>>>   if it is not explicitly selected in Kconfig; however the device probing fails
>>>   and logs an explicit error message
>>
>>
>> What is the reason for that?
> 
> We discussed that. Either we use the #ifdef in the id table or we return
> "-ENODEV" in the placebo function. The later allows for a meaningful
> error message (which is still missing).


Hm ... not sure if this is always a good approach - see below.

> 
>> If we generally have the possibility to check for PCIEC, i would make it in
>> the device id table and the module description too:
>>
>>>  #include <linux/kernel.h>
>>> @@ -26,22 +23,26 @@
>>>  #include <linux/delay.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/io.h>
>>
>> #ifdef CONFIG_CAN_PEAK_PCIEC
>>
>>> +#include <linux/i2c.h>
>>> +#include <linux/i2c-algo-bit.h>
>>
>> #endif
> 
> No, please not! #ifdef's around includes should never be necessary.


ok.

>>>  #include <linux/can.h>
>>>  #include <linux/can/dev.h>
>>>  
>>>  #include "sja1000.h"
>>>  
>>>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
>>> -MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI/PCIe cards");
>>> -MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe CAN card");
>>> +MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
>> #ifdef CONFIG_CAN_PEAK_PCIEC
>>> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");
>>
>> #else
>>
>>> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe miniPCI CAN cards");
>>
>> #endif
> 
> Well, the driver is for all devices. Don't like that extra #ifdef. And
> MODULE_SUPPORTED_DEVICE() is not even implemented yet.


ok.

>>>  static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) = {
>>>  	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>>> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>>> +	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>> #ifdef CONFIG_CAN_PEAK_PCIEC
>>> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>>
>> #endif

> 

> See above.


Indeed in this case i can not agree.

IMO the  #ifdef CONFIG_CAN_PEAK_PCIEC around the pci_id_table entry is
needed. It does not make sense to *register* a PCI ID when this ID is not
served by this driver.

Other examples, where this is implemented similarly:

http://lxr.linux.no/#linux+v3.2.4/drivers/net/wireless/rt2x00/rt2800pci.c#L1113
http://lxr.linux.no/#linux+v3.2.4/drivers/net/ethernet/marvell/skge.c#L84

http://lxr.linux.no/#linux+v3.2.4/drivers/isdn/hisax/config.c#L1916
http://lxr.linux.no/#linux+v3.2.4/drivers/ata/ata_generic.c#L212
http://lxr.linux.no/#linux+v3.2.4/drivers/ide/ide-pci-generic.c#L151
http://lxr.linux.no/#linux+v3.2.4/drivers/ide/amd74xx.c#L290
(..)

Regards,
Oliver
