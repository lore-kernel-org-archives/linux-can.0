From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Mon, 10 Mar 2014 13:15:01 +0100
Message-ID: <531DACC5.8090804@hartkopp.net>
References: <1394294420.3356.15.camel@NREC-014563> <531CBB6F.7090803@pengutronix.de> <531D6D3B.9020900@hartkopp.net> <20140310104650.GA456@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:44229 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaCJMPJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 08:15:09 -0400
In-Reply-To: <20140310104650.GA456@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

Hey Kurt!

On 10.03.2014 11:46, Kurt Van Dijck wrote:

>> Do you have an idea how to proceed with USB or other devices that bring their
>> own identification (like a serial number / device id) ??
>>
>> E.g. the Softing Card provides some serial number through sysfs:
>>
>> http://lxr.free-electrons.com/source/drivers/net/can/softing/softing_main.c#L719
> 
> I still think this is the correct way.

Yes. You are right.

> udev identifies the device based on anyting device related (serial number, driver, ...)
> and identifies the channel of the device based on the netdev (now through dev_id).
> The netdev links to the device, so there is be no problem with identification.

Looking into your code IMO a similar thing has to be done for the other CAN
interfaces providing HW/SW versions and unique IDs like e.g. a serial number.

E.g. the PEAK USB adapters or the USB8DEV adapter, etc.

It already looks pretty good for a general usage.

Do you know what your attributes "frequency" and "tx_pending" have been used
for in the softing driver? Are they still needed?

> Putting somehing else into the MAC address field is not right.

Ack. It was just a suggestion. But after looking into your sysfs code you
convinced me :-)

> What problem do you try to solve here?

Just to have a unique ID to identify CAN USB adapters to set them to the right
bitrate and netdevice name via udev when they are attached.

Best regards,
Oliver

