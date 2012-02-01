From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI boards
Date: Wed, 01 Feb 2012 13:29:41 +0100
Message-ID: <4F293035.2060201@peak-system.com>
References: <1328094132-20738-1-git-send-email-s.grosjean@peak-system.com>
 <4F2929CD.90604@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:56098 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268Ab2BAM3t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 07:29:49 -0500
In-Reply-To: <4F2929CD.90604@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 01/02/2012 13:02, Wolfgang Grandegger a =E9crit :
> On 02/01/2012 12:02 PM, Stephane Grosjean wrote:
>> This patch adds the support for the following 3x sja1000 based PCI b=
oards
>> from PEAK-System Technik (www.peak-system.com):
>>
>> PCAN-PCI Express (1 or 2 channels)
>> PCAN-ExpressCard (1 or 2 channels)
>> PCAN-miniPCI (1 or 2 channels)
>>
>> This version also updates Kconfig.
>>
>> Signed-off-by: Stephane Grosjean<s.grosjean@peak-system.com>
>> ---
>>   drivers/net/can/sja1000/Kconfig    |    7 +-
>>   drivers/net/can/sja1000/peak_pci.c |  510 ++++++++++++++++++++++++=
+++++++++--
>>   2 files changed, 484 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja10=
00/Kconfig
>> index 36e9d59..d178e01 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -44,11 +44,12 @@ config CAN_EMS_PCI
>>   	  (http://www.ems-wuensche.de).
>>
>>   config CAN_PEAK_PCI
>> -	tristate "PEAK PCAN PCI/PCIe Cards"
>> +	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>>   	depends on PCI
> It now also depends on I2C.

Yes you're right...but if I added such a dependency, I2C would be=20
mandatory, even for the other PEAK PCI boards

I would prefer:

1 - Changing Kconfig : like that

config CAN_PEAK_PCI
         tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
         depends on PCI
         ---help---
           This driver is for the PCAN-PCI/PCIe/miniPCI cards
           (1, 2, 3 or 4 channels) from PEAK-System Technik
           (http://www.peak-system.com).

           The I2C driver must be selected to fully support the
           PCAN-ExpressCard card LEDs.

config CAN_PEAK_PCIEC
         bool "PEAK PCAN-ExpressCard Card"
         depends on CAN_PEAK_PCI && I2C
         ---help---
           Add full support of the PCAN-ExpressCard card
           (1, 2, 3 or 4 channels) from PEAK-System Technik
           (http://www.peak-system.com).


2 - adding some #ifdef CONFIG_PEAK_PCIEC/ #endif in peak_pci.c around=20
all what concerns leds management.

What is your opinion?

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
