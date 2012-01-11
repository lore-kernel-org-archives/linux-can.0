From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Softing Firmware on gitorious
Date: Wed, 11 Jan 2012 18:37:00 +0100
Message-ID: <4F0DC8BC.4040704@hartkopp.net>
References: <4F0DB66F.50509@hartkopp.net> <4F0DBF90.5050906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17040 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847Ab2AKRhM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 12:37:12 -0500
In-Reply-To: <4F0DBF90.5050906@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11.01.2012 17:57, Marc Kleine-Budde wrote:

> On 01/11/2012 05:18 PM, Oliver Hartkopp wrote:
>> Hello Kurt,
>>
>> i just uploaded the Softing firmware from BerliOS to our new 
>>
>> https://gitorious.org/linux-can/can-misc
>>
>> git repository.
>>
>> See at 
>>
>> https://gitorious.org/linux-can/can-misc/blobs/master/firmware/softing-fw-4.6-binaries.tar.gz
>>
>> Currently the only reference is in the Linux Kernel in the Softing Kconfig:
>>
>> config CAN_SOFTING_CS
>>         tristate "Softing Gmbh CAN pcmcia cards"
>>         depends on PCMCIA
>>         depends on CAN_SOFTING
>>         ---help---
>>           Support for PCMCIA cards from Softing Gmbh & some cards
>>           from Vector Gmbh.
>>           You need firmware for these, which you can get at
>>           http://developer.berlios.de/projects/socketcan/
>>           This version of the driver is written against
>>           firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
>>           In order to use the card as CAN device, you need the Softing generic
>>           support too.
>>
>>
>> The question is now:
>>
>> 1. change the link in the Kconfig
>> 2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
>> 3. 1 & 2
> 
> 3.
> 
> It would be nice to have a license statement on that files. As these are
> in binary form, the driver would be removed from the debian kernel.
> What's the official source of that firmware? Do we have a contact to
> softing?
> 


Yes. See here:

https://lists.berlios.de/pipermail/socketcan-core/2008-June/001613.html

I'll check the mentioned driver packages for license information which i don't
have on my current machine here.

Regards,
Oliver
