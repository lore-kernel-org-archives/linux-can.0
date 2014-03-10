From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Mon, 10 Mar 2014 08:43:55 +0100
Message-ID: <531D6D3B.9020900@hartkopp.net>
References: <1394294420.3356.15.camel@NREC-014563> <531CBB6F.7090803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:53152 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbaCJHoH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 03:44:07 -0400
In-Reply-To: <531CBB6F.7090803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

Hello Christopher,

On 09.03.2014 20:05, Marc Kleine-Budde wrote:
> On 03/08/2014 05:00 PM, Christopher R. Baker wrote:

> You are the first one to address this issue. \o/

I remember we discussed this issue years ago - but it was not really brought
to an end. So I really appreciate Christophers attempt :-)

>> udevadm info gives me the KERNELS=... incantation to match the pci bus
>> address, but there are no other differences in the udev listing for my
>> various CAN ports (at least for my peak_pci device)
>>
>> Digging into the semantics of ATTRS{...}, "dev_id" stood out as having
>> the intention of discriminating between physical ports

I assume dev->if_port has to be assigned to different CAN transceiver types
for a specific CAN controller then ... 

We should keep that in mind if someone comes up with that question.

>> that "share the
>> same link layer" (from netdev.h) or "share the same MAC address" (from
>> various other mailing lists).
>>
>> The following patch assigns the dev_id field to match the channel number
>> on all multi-channel cards

Ok. That looks reasonable (and therefore the patch fits excellent).

As you stated above you can identify the card via the PCI bus address too.

Do you have an idea how to proceed with USB or other devices that bring their
own identification (like a serial number / device id) ??

E.g. the Softing Card provides some serial number through sysfs:

http://lxr.free-electrons.com/source/drivers/net/can/softing/softing_main.c#L719

and e.g. the PEAK USB have a so called "device number" that is currently just
printed in kernel log:

http://lxr.free-electrons.com/source/drivers/net/can/usb/peak_usb/pcan_usb_core.c#L799

Especially to assign USB devices that can be attached in a wild manner each
time a good idea would be needed for udev to identify the adapter.

Do you also have an idea for that? E.g. use the HW MAC address field (we do
not need for CAN) for this kind of "serial number / device id" ??

Regards,
Oliver

