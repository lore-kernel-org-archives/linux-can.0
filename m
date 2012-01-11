From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 15:43:01 +0100
Message-ID: <4F0D9FF5.5010208@grandegger.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com> <4F0C53C6.1020704@hartkopp.net> <4F0D9891.6070901@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:52576 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2AKOnF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 09:43:05 -0500
In-Reply-To: <4F0D9891.6070901@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 01/11/2012 03:11 PM, Grosjean Stephane wrote:
>=20
>=20
> Le 10/01/2012 16:05, Oliver Hartkopp a =E9crit :
>> On 10.01.2012 14:41, Wolfgang Grandegger wrote:
>>
>>> Nice, I have such a pcmcia card...
>>
>> Yes. Me too :-)
>=20
> Happy to please you :-))
>=20
>>
>> +config CAN_PEAK_PCMCIA
>> +    tristate "PEAK PCAN PC-CARD Card"
>>
>> tristate "PEAK PCAN PC-Card (PCMCIA)"
>>
>> ??
>=20
> Please confirm: you'd like me to add the "(PCMCIA)" string at the end=
 of
> the menu text, wouldn't you?

I think "PEAK PCAN PC-Card" is already pretty clear.

>> Should we probably put all PCMCIA cards into a separate
>>
>> linux/drivers/net/can/sja1000/pcmcia
>>
>> directory - like we have it for the USB devices?
>=20
> If my Humble Opinion may help you: not sure this will be lots of othe=
r
> pcmcia (can) adapters in the future...

I agree. Let's wait and see.


>>>> +    depends on PCMCIA
>>>> +    ---help---
>>>> +      This driver is for the PCAN PC-CARD PCMCIA card with 1 or 2
>>>> channels
>>>> +      from PEAK Systems (http://www.peak-system.com).
>>>> +
>>>>   config CAN_PEAK_PCI
>>>>       tristate "PEAK PCAN PCI/PCIe Cards"
>>>>       depends on PCI
>>>> diff --git a/drivers/net/can/sja1000/Makefile
>>>> b/drivers/net/can/sja1000/Makefile
>>>> index 0604f24..b3d05cb 100644
>>>> --- a/drivers/net/can/sja1000/Makefile
>>>> +++ b/drivers/net/can/sja1000/Makefile
>>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) +=3D
>>>> sja1000_of_platform.o
>>>>   obj-$(CONFIG_CAN_EMS_PCMCIA) +=3D ems_pcmcia.o
>>>>   obj-$(CONFIG_CAN_EMS_PCI) +=3D ems_pci.o
>>>>   obj-$(CONFIG_CAN_KVASER_PCI) +=3D kvaser_pci.o
>>>> +obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o
>>
>> This should be the module/driver name too.
>>>> +
>>>> +/* PEAK-System PCMCIA driver name */
>>>> +#define DRV_NAME "peak_pccard"
>>> I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard"=
 for
>>> the same hardware confusing. Please use just one name and prefix.
>>
>> Yep - peak_pcmcia
>=20
> We just finished to talk about that and, as far as the PCAN-PC Card i=
s a
> PC-CARD (16bit), we'd like to use the "peak_pccard" text for the
> module/module file/source file names instead of "peak_pcmcia".
> Related question: I suppose I'll have to change the
> "CONFIG_CAN_PEAK_PCMCIA" into "CONFIG_CAN_PEAK_PCCARD" too.
> Please confirm.

Yes, #defines, file names and prefixes should be consistently used.

>> +
>> +#define DRV_CHAN_MAX 2
>> +
>> +#define DRV_CAN_CLOCK (16000000 / 2)
>>> Hm, the prefix DRV_ here and below does not really make sense. But =
well,
>>> it's a minor issue.
>>
>> ack. Remove DRV_ or rename it so someting like to PCC_
>=20
> Ok, changed to "PCC_" prefix.
>=20
>> No more nitpicks in additions to Wolfgangs remarks.
>=20
> Just one last question: FYI, I built the peak_pcmcia.c starting from
> peak_pci.c, so I suppose that the DRV_ prefix should be changed into
> that file too.

Well, it's me who pushed that driver to mainline ;-). Anyway, the prefi=
x
is bad but not worth to prepare or reject a patch.

Wolfgang.

