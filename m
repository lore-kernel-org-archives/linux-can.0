From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ODB-II Interfaces and Linux CAN?
Date: Fri, 27 Apr 2012 19:40:30 +0200
Message-ID: <4F9ADA0E.7050408@hartkopp.net>
References: <jndptc$9c5$1@ultimate100.geggus.net> <4F9A6DEA.5050900@pengutronix.de> <jne15j$bbr$1@ultimate100.geggus.net> <4F9A9875.50904@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:40271 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760583Ab2D0Rkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 13:40:32 -0400
In-Reply-To: <4F9A9875.50904@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 27.04.2012 15:00, Marc Kleine-Budde wrote:

> On 04/27/2012 01:50 PM, Sven Geggus wrote:
>> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>>> The webpage talks about a "327 Chip" when searching for it, I find:
>>> http://www.blafusel.de/obd/obd2elm327.html
>>> http://www.elmelectronics.com/DSheets/ELM327DS.pdf
>>
>> Jepp this includes a description of the serial protocol.
> 


Yes. It looks like that not only CAN diagnosis and transport protocols like
j1939 and iso-tp are supported to transfer their PDUs but also it is possible
to process bare CAN frames.

Implementing e.g. the iso-tp protocol inside the ELM327 chip hides the timing
requirements from the diagnosis application on the PC side. So the PC
application can be pretty simple - only processing PDUs without knowing all
the transport protocol details.

>>> This chip converts ODB (and CAN seems to be part of ODB) to serial. The
>>> question is how the 327 in the autodia-e327 is converted to USB. They
>>> probably use a standard USB-Serial converter chip. 
>>
>> They almost certaily do.
>>
>>> There is support for serial attached CAN adapters in mainline (IIRC), but
>>> I think it talks a different protocol.
>>
>> You are talking about slcan.c right?
> 
> Yes.
> 
>> Probably I should just get me one of these cheap Interfaces.


Good idea. Supporting all devices on earth is Greg K-Hs mission. So why not
bringing the ELM327 to life for SocketCAN? :-)

> These serial CAN converters are probably quite slow, I haven't used any.
> Maybe Oliver can comment on them.


Indeed there are many of them out there - as you can see in the Kconfig entry:

http://lxr.linux.no/#linux+v3.3.3/drivers/net/can/Kconfig#L21

The ASCII protocol is pretty simple and there's no kind of feedback or error
reporting - it's not my favourite CAN hardware ...

There are only incoming and outgoing ASCII streams which are converted to
struct can_frames in the slcan.c driver.

The slcan encapsulation format is described here:

http://lxr.linux.no/#linux+v3.3.3/drivers/net/can/slcan.c#L100

Before the simple stream conversion in slcan.c can take place the SLCAN
adapter needs to be initialized, and the bitrate needs to be set.

https://gitorious.org/linux-can/can-misc/blobs/master/slcan/SLCAN-API.pdf

This is done by e.g. slcan_attach tool.

Don't know how to setup the ELM327 to bring it into this mode - but if you get
one you may keep me informed.

Regards,
Oliver
