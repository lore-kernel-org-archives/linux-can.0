From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 15:11:29 +0100
Message-ID: <4F0D9891.6070901@peak-system.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com> <4F0C53C6.1020704@hartkopp.net>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-2d.bbox.fr ([194.158.122.57]:37054 "EHLO mail-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954Ab2AKOLd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 09:11:33 -0500
In-Reply-To: <4F0C53C6.1020704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>



Le 10/01/2012 16:05, Oliver Hartkopp a =E9crit :
> On 10.01.2012 14:41, Wolfgang Grandegger wrote:
>
>> Nice, I have such a pcmcia card...
>
> Yes. Me too :-)

Happy to please you :-))

>
> +config CAN_PEAK_PCMCIA
> +	tristate "PEAK PCAN PC-CARD Card"
>
> tristate "PEAK PCAN PC-Card (PCMCIA)"
>
> ??

Please confirm: you'd like me to add the "(PCMCIA)" string at the end o=
f=20
the menu text, wouldn't you?

> Should we probably put all PCMCIA cards into a separate
>
> linux/drivers/net/can/sja1000/pcmcia
>
> directory - like we have it for the USB devices?

If my Humble Opinion may help you: not sure this will be lots of other=20
pcmcia (can) adapters in the future...

>>> +	depends on PCMCIA
>>> +	---help---
>>> +	  This driver is for the PCAN PC-CARD PCMCIA card with 1 or 2 cha=
nnels
>>> +	  from PEAK Systems (http://www.peak-system.com).
>>> +
>>>   config CAN_PEAK_PCI
>>>   	tristate "PEAK PCAN PCI/PCIe Cards"
>>>   	depends on PCI
>>> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja=
1000/Makefile
>>> index 0604f24..b3d05cb 100644
>>> --- a/drivers/net/can/sja1000/Makefile
>>> +++ b/drivers/net/can/sja1000/Makefile
>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) +=3D sja1000_=
of_platform.o
>>>   obj-$(CONFIG_CAN_EMS_PCMCIA) +=3D ems_pcmcia.o
>>>   obj-$(CONFIG_CAN_EMS_PCI) +=3D ems_pci.o
>>>   obj-$(CONFIG_CAN_KVASER_PCI) +=3D kvaser_pci.o
>>> +obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o
>
> This should be the module/driver name too.
>>> +
>>> +/* PEAK-System PCMCIA driver name */
>>> +#define DRV_NAME "peak_pccard"
>> I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard" =
for
>> the same hardware confusing. Please use just one name and prefix.
>
> Yep - peak_pcmcia

We just finished to talk about that and, as far as the PCAN-PC Card is =
a=20
PC-CARD (16bit), we'd like to use the "peak_pccard" text for the=20
module/module file/source file names instead of "peak_pcmcia".
Related question: I suppose I'll have to change the=20
"CONFIG_CAN_PEAK_PCMCIA" into "CONFIG_CAN_PEAK_PCCARD" too.
Please confirm.

> +
> +#define DRV_CHAN_MAX 2
> +
> +#define DRV_CAN_CLOCK (16000000 / 2)
>> Hm, the prefix DRV_ here and below does not really make sense. But w=
ell,
>> it's a minor issue.
>
> ack. Remove DRV_ or rename it so someting like to PCC_

Ok, changed to "PCC_" prefix.

> No more nitpicks in additions to Wolfgangs remarks.

Just one last question: FYI, I built the peak_pcmcia.c starting from=20
peak_pci.c, so I suppose that the DRV_ prefix should be changed into=20
that file too.

> Tnx&  best regards,
> Oliver

Many thanks for all!

Best regards,

St=E9phane

