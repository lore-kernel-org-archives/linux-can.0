From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 16:11:28 +0100
Message-ID: <4F0DA6A0.8030602@grandegger.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com> <4F0C53C6.1020704@hartkopp.net> <4F0D9891.6070901@peak-system.com> <4F0DA409.4080507@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53182 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab2AKPLa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 10:11:30 -0500
In-Reply-To: <4F0DA409.4080507@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: s.grosjean@peak-system.com, linux-can Mailing List <linux-can@vger.kernel.org>

On 01/11/2012 04:00 PM, Oliver Hartkopp wrote:
> On 11.01.2012 15:11, Grosjean Stephane wrote:
> 
>>> +config CAN_PEAK_PCMCIA +    tristate "PEAK PCAN PC-CARD Card"
>>>
>>> tristate "PEAK PCAN PC-Card (PCMCIA)"
>>>
>>> ??
>>
>> Please confirm: you'd like me to add the "(PCMCIA)" string at the end of
>> the menu text, wouldn't you?
> 
> 
> 
> I read some more Kconfigs to check the current handling in other drivers.
> 
> I think
> 
> 	tristate "PEAK PCAN PC-Card"
> 
> is better - and reflects the PEAK adapter name (note the upper/lower case!).
> Although the Kconfig entry is only visible when PCMCIA is enabled.
> 
>>
>>> Should we probably put all PCMCIA cards into a separate
>>>
>>> linux/drivers/net/can/sja1000/pcmcia
>>>
>>> directory - like we have it for the USB devices?
>>
>> If my Humble Opinion may help you: not sure this will be lots of other
>> pcmcia (can) adapters in the future...
> 
> 
> ok. Forget it :-)
> 
>>>>> +    depends on PCMCIA +    ---help--- +      This driver is for the
>>>>> PCAN PC-CARD PCMCIA card with 1 or 2 channels +      from PEAK
>>>>> Systems (http://www.peak-system.com). +
> 
> 
> (..)
> 
>>>>> +obj-$(CONFIG_CAN_PEAK_PCMCIA) += peak_pcmcia.o
>>>
>>> This should be the module/driver name too.
>>>>> + +/* PEAK-System PCMCIA driver name */ +#define DRV_NAME
>>>>> "peak_pccard"
>>>> I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard"
>>>> for the same hardware confusing. Please use just one name and prefix.
>>>
>>> Yep - peak_pcmcia
>>
>> We just finished to talk about that and, as far as the PCAN-PC Card is a 
>> PC-CARD (16bit), we'd like to use the "peak_pccard" text for the
>> module/module file/source file names instead of "peak_pcmcia". Related
>> question: I suppose I'll have to change the "CONFIG_CAN_PEAK_PCMCIA" into
>> "CONFIG_CAN_PEAK_PCCARD" too. Please confirm.
> 
> 
> Hm. Not that good IMO ...
> 
> If you look into the Kernel config options there's a difference between PCCARD
> and PCMCIA:
> 
> linux/drivers/pcmcia/Kconfig says
> 
> ---8<--- snip
> 
> if PCCARD
> 
> config PCMCIA
>         tristate "16-bit PCMCIA support"
>         select CRC32
>         default y
>         ---help---
>            This option enables support for 16-bit PCMCIA cards. Most older
>            PC-cards are such 16-bit PCMCIA cards, so unless you know you're
>            only using 32-bit CardBus cards, say Y or M here.
> 
>            To use 16-bit PCMCIA cards, you will need supporting software in
>            most cases. (see the file <file:Documentation/Changes> for
>            location and details).
> 
>            To compile this driver as modules, choose M here: the
>            module will be called pcmcia.
> 
>            If unsure, say Y.
> 
> ---8<--- snip

> So your hardware is not a 32-bit Cardbus but a 16-bit PCMCIA card.
> 
> Putting the "PCAN-PC card" into the Kconfig description is fine but the driver
> source and kernel module should reflect the (16 bit) pcmcia driver state.
> 
> You may add to your Kconfig entry:
> 
>            To compile this driver as module, choose M here: the
>            module will be called peak_pcmcia.

D'accord!

Wolfgang.



