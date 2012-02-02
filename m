From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Fri, 03 Feb 2012 00:06:33 +0100
Message-ID: <4F2B16F9.8020903@hartkopp.net>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com> <4F2ACFE9.3080602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:26533 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652Ab2BBXGg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2012 18:06:36 -0500
In-Reply-To: <4F2ACFE9.3080602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 02.02.2012 19:03, Oliver Hartkopp wrote:

> Hello Stephane et.al.
> 
> On 02.02.2012 14:19, Stephane Grosjean wrote:
> 
>>  
>>  config CAN_PEAK_PCI
>> -	tristate "PEAK PCAN PCI/PCIe Cards"
>> +	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>>  	depends on PCI
>>  	---help---
>> -	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
>> -	  from PEAK Systems (http://www.peak-system.com).
>> +	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
>> +	  (1, 2, 3 or 4 channels) from PEAK-System Technik
>> +	  (http://www.peak-system.com).
>> +
>> +	  The I2C bit-banging algorithm should be selected to enable
>> +	  correct LEDs management on the PCAN-ExpressCard (PCIeC) card.
> 
> 
> The problem is that the PCAN-ExpressCards without galvanic isolation
> (IPEH-003000, IPEH-003001) are not working at all when the I2C stuff is not
> initialized.
> 
> It's not only the LED handling.
> 
> What about this:
> 
>  config CAN_PEAK_PCI
> 	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
> 	depends on PCI
> 	---help---
> 	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> 	  from PEAK Systems (http://www.peak-system.com).
> 	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
> 	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> 	  (http://www.peak-system.com).
> 
> 	  The I2C bit-banging algorithm (I2C ALGOBIT) needs to be selected to
> 	  support PCAN-ExpressCard (PCIeC) cards.
> 
>  config CAN_PEAK_PCIEC
> 	tristate "PEAK PCAN-Express Cards"
> 	depends on CAN_PEAK_PCI && CONFIG_I2C_ALGOBIT


... sorry : of course without CONFIG_

just

  config CAN_PEAK_PCIEC
 	bool "PEAK PCAN-Express Cards"
 	depends on CAN_PEAK_PCI && I2C_ALGOBIT
 	default y


> 	---help---

> 	  (bla bla)
> 
> (..)
> 
> 
>>  
>>  MODULE_DEVICE_TABLE(pci, peak_pci_tbl);
>>  
>> +#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
> 
> 
> #ifdef CONFIG_CAN_PEAK_PCIEC
> 
> (..)
> 


Alternatively you may just select I2C and I2C_ALGOBIT as it is done by other
drivers like this:

http://lxr.linux.no/#linux+v3.2.2/drivers/net/ethernet/sfc/Kconfig#L7

config CAN_PEAK_PCI
	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
	depends on PCI
	select I2C
	select I2C_ALGOBIT
	---help---
	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
	  (1, 2, 3 or 4 channels) from PEAK-System Technik
	  (http://www.peak-system.com).

... which would also make the #ifdef stuff obsolete.

Regards,
Oliver
