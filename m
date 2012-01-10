From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Tue, 10 Jan 2012 16:05:42 +0100
Message-ID: <4F0C53C6.1020704@hartkopp.net>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:43509 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab2AJPGA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 10:06:00 -0500
In-Reply-To: <4F0C4020.8010304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

On 10.01.2012 14:41, Wolfgang Grandegger wrote:

> Hi Stephane,
> 
> please send a patch using a proper subject line and commit message. Also
> add a CC to the pcmcia linux mailing list. Thanks.
> 
> On 01/09/2012 03:51 PM, Stephane Grosjean wrote:
>> Hi,
>>
>> Please find below a new patch which goal is to include the support of the
>> PEAK-System PCMCIA board PCAN-PC Card. This board is SJA1000 based and is 
>> available as a single or dual CAN channel version.
> 
> Nice, I have such a pcmcia card...


Yes. Me too :-)

> 
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
>> index 36e9d59..3c1e474 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -43,6 +43,13 @@ config CAN_EMS_PCI
>>  	  CPC-PCIe and CPC-104P cards from EMS Dr. Thomas Wuensche
>>  	  (http://www.ems-wuensche.de).
>>  
>> +config CAN_PEAK_PCMCIA
>> +	tristate "PEAK PCAN PC-CARD Card"


tristate "PEAK PCAN PC-Card (PCMCIA)"

??

Should we probably put all PCMCIA cards into a separate

linux/drivers/net/can/sja1000/pcmcia

directory - like we have it for the USB devices?

>> +	depends on PCMCIA
>> +	---help---
>> +	  This driver is for the PCAN PC-CARD PCMCIA card with 1 or 2 channels
>> +	  from PEAK Systems (http://www.peak-system.com).
>> +
>>  config CAN_PEAK_PCI
>>  	tristate "PEAK PCAN PCI/PCIe Cards"
>>  	depends on PCI
>> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000/Makefile
>> index 0604f24..b3d05cb 100644
>> --- a/drivers/net/can/sja1000/Makefile
>> +++ b/drivers/net/can/sja1000/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) += sja1000_of_platform.o
>>  obj-$(CONFIG_CAN_EMS_PCMCIA) += ems_pcmcia.o
>>  obj-$(CONFIG_CAN_EMS_PCI) += ems_pci.o
>>  obj-$(CONFIG_CAN_KVASER_PCI) += kvaser_pci.o
>> +obj-$(CONFIG_CAN_PEAK_PCMCIA) += peak_pcmcia.o


This should be the module/driver name too.

>>  obj-$(CONFIG_CAN_PEAK_PCI) += peak_pci.o
>>  obj-$(CONFIG_CAN_PLX_PCI) += plx_pci.o
>>  obj-$(CONFIG_CAN_TSCAN1) += tscan1.o
>> diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
>> new file mode 100644
>> index 0000000..e409a8b
>> --- /dev/null
>> +++ b/drivers/net/can/sja1000/peak_pcmcia.c
>> @@ -0,0 +1,707 @@
>> +/*
>> + * CAN driver for PEAK-System PCAN-PCARD


PCAN-PC Card

as written on the PEAK website

>> + * Derived from the PCAN project file driver/src/pcan_pccard.c
>> + *
>> + * Copyright (C) 2006-2009 PEAK System-Technik GmbH
>> + * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the version 2 of the GNU General Public License
>> + * as published by the Free Software Foundation
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software Foundation,
>> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>> + */

Remove address info.

>> +
>> +/* PEAK-System PCMCIA driver name */
>> +#define DRV_NAME "peak_pccard"
> 
> I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard" for
> the same hardware confusing. Please use just one name and prefix.


Yep - peak_pcmcia

> 
>> +
>> +/* PEAK-System PCMCIA driver version */
>> +#define DRV_VERSION_MAJOR	0
>> +#define DRV_VERSION_MINOR	2
>> +#define DRV_VERSION_SUBMINOR	0
>> +
>> +#define DRV_VERSION_STRING __stringify(DRV_VERSION_MAJOR)"."\
>> +	__stringify(DRV_VERSION_MINOR)"."\
>> +	__stringify(DRV_VERSION_SUBMINOR)
> 
> As for the USB driver, I would remove this redundant versioning stuff.
> Also version 0.2.0 does not really sound like like a stable piece of
> software.


Dave Miller stated that driver versions are obsolete in Mainline.

>

>> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
>> +MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");
>> +MODULE_VERSION(DRV_VERSION_STRING);
>> +
>> +#define DRV_CHAN_MAX 2
>> +
>> +#define DRV_CAN_CLOCK (16000000 / 2)
> 
> Hm, the prefix DRV_ here and below does not really make sense. But well,
> it's a minor issue.


ack. Remove DRV_ or rename it so someting like to PCC_

No more nitpicks in additions to Wolfgangs remarks.

Tnx & best regards,
Oliver
