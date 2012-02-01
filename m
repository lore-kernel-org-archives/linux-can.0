From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 16:34:14 +0100
Message-ID: <4F295B76.8070600@grandegger.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37881 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab2BAPeZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 10:34:25 -0500
In-Reply-To: <4F295865.2040304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 04:21 PM, Marc Kleine-Budde wrote:
> On 02/01/2012 03:57 PM, Stephane Grosjean wrote:
>> This patch adds the support for the following 3x sja1000 based PCI cards
>> from PEAK-System Technik (www.peak-system.com):
>>
>> PCAN-PCI Express (1 or 2 channels)
>> PCAN-ExpressCard (1 or 2 channels)
>> PCAN-miniPCI (1 or 2 channels)
>>
>> LEDs managemement on the PCAN-ExpressCard depends on I2C bit-banging kernel
>> configuration option.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>  drivers/net/can/sja1000/Kconfig    |   10 +-
>>  drivers/net/can/sja1000/peak_pci.c |  534 ++++++++++++++++++++++++++++++++++--
>>  2 files changed, 512 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
>> index 36e9d59..724cf83 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -44,11 +44,15 @@ config CAN_EMS_PCI
>>  	  (http://www.ems-wuensche.de).
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
>>  
>>  config CAN_KVASER_PCI
>>  	tristate "Kvaser PCIcanx and Kvaser PCIcan PCI Cards"
>> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
>> index 2147959..1577bfb 100644
>> --- a/drivers/net/can/sja1000/peak_pci.c
>> +++ b/drivers/net/can/sja1000/peak_pci.c
>> @@ -1,9 +1,10 @@
>>  /*
> nitpick about the copyright:
> 
> you should add your copyright...
> 
>>   * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
> 
> ....here ^^^ ....
> 
>>   *
>> - * Derived from the PCAN project file driver/src/pcan_pci.c:
>> + * Derived from the PCAN project files driver/src/pcan_pci.c:
>>   *
>>   * Copyright (C) 2001-2006  PEAK System-Technik GmbH
>> + * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
> 
> and leave these lines as they are.
> 
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the version 2 of the GNU General Public License
>> @@ -13,12 +14,7 @@
>>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>   * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software Foundation,
>> - * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>>   */
>> -
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/interrupt.h>
>> @@ -26,46 +22,128 @@
>>  #include <linux/delay.h>
>>  #include <linux/pci.h>
>>  #include <linux/io.h>
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-algo-bit.h>
>>  #include <linux/can.h>
>>  #include <linux/can/dev.h>
>> -
>>  #include "sja1000.h"
>>  
>>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
>> -MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI/PCIe cards");
>> -MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe CAN card");
>> +MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
>> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");
>>  MODULE_LICENSE("GPL v2");
>>  
>> -#define DRV_NAME  "peak_pci"
>> -
>> -struct peak_pci_chan {
>> -	void __iomem *cfg_base;		/* Common for all channels */
>> -	struct net_device *prev_dev;	/* Chain of network devices */
>> -	u16 icr_mask;			/* Interrupt mask for fast ack */
>> -};
>> +#define PEAK_PCI_DRV_NAME	"peak_pci"
>> +#define PEAK_PCI_CHAN_MAX	4
>>  
>>  #define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
>>  
>>  #define PEAK_PCI_CDR		(CDR_CBP | CDR_CLKOUT_MASK)
>>  #define PEAK_PCI_OCR		OCR_TX0_PUSHPULL
>>  
>> -/*
>> - * Important PITA registers
>> - */
>> +/* PITA registers */
>>  #define PITA_ICR		0x00	/* Interrupt control register */
>>  #define PITA_GPIOICR		0x18	/* GPIO interface control register */
>>  #define PITA_MISC		0x1C	/* Miscellaneous register */
>>  
>> +/* PCIeC leds management needs I2C algobit */
>> +#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
>> +#define PEAK_CONFIG_PCIEC_LEDS
>> +#endif
> 
> ifdefs in the .c file are not welcome in general. What about something
> like this:
> 
> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
> #define peak_pci_support_pcie()	(1)
> #else
> #define peak_pci_support_pcie()	(0)
> #endif
> 
> In the probe function you can write:
> 
> probe() {
> 	...
> 
> 	if (peak_pci_support_pcie() &&
> 	    pdev->device == PEAK_PCIEC_DEVICE_ID) {
> 		...
> 	}
> }
> 
> There should be no ifdefs left in the code. One question remains, is the
> i2c core clever enough to define no-ops if the i2c subsystem is switched
> off?

Yes, far too much #ifdef's. Wrapping peak_pciec_init() and
peak_pciec_remove() properly would already work.

I also find the name peak_pciec_init() misleading. I think
s/peak_pciec/peak_pciec_led/ would be more appropriate.

Also what do you think about defining a separate Kconfig entry
"PEAK_PCIEC_LED" similar to what Stefane already had and select it by
default (default=y)?

Wolfgang.

