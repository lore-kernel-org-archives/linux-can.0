From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Thu, 11 Oct 2012 14:08:48 +0200
Message-ID: <5076B6D0.5020808@gaisler.com>
References: <1349188730-11434-1-git-send-email-andreas@gaisler.com> <506D5AA4.5080704@pengutronix.de> <5076999F.6070302@pengutronix.de> <5076AC0C.6090306@gaisler.com> <5076AD65.6080909@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:29897 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750924Ab2JKMI4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 08:08:56 -0400
In-Reply-To: <5076AD65.6080909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 2012-10-11 13:28, Marc Kleine-Budde wrote:
> On 10/11/2012 01:22 PM, Andreas Larsson wrote:
>> On 2012-10-11 12:04, Marc Kleine-Budde wrote:
>>> On 10/04/2012 11:45 AM, Marc Kleine-Budde wrote:
>>>> Hello,
>>>>
>>>> On 10/02/2012 04:38 PM, Andreas Larsson wrote:
>>>>> This driver supports GRCAN and CRHCAN CAN controllers available in
>>>>> the GRLIB
>>>>> VHDL IP core library.
>>>>>
>>>>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>>>>> ---
>>>>>    drivers/net/can/Kconfig  |    6 +
>>>>>    drivers/net/can/Makefile |    1 +
>>>>>    drivers/net/can/grcan.c  | 1283
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    drivers/net/can/grcan.h  |  273 ++++++++++
>>>>>    4 files changed, 1563 insertions(+), 0 deletions(-)
>>>>>    create mode 100644 drivers/net/can/grcan.c
>>>>>    create mode 100644 drivers/net/can/grcan.h
>>>>
>>>> Some general remarks while scrolling though the driver:
>>>> - please provide a device tree binding documentation
>>>>     Documentation/devicetree/bindings/net/can/grcan.txt
>>>>     and add devicetree-discuss@lists.ozlabs.org on Cc
>>>> - please provide a documentation for the sysfs entries:
>>>>     Documentation/ABI/testing/sys-XXX-grcan.txt
>>>> - please implement a NAPI
>>>> - please include the .h file into the C code,
>>>>     as the C code is the one and only user of the .h file
>>>> - please give every macro a GRCAN_ prefix
>>>
>>> Your driver should work on little as well as on big endian systems. You
>>> need probably two implementations of the grcan_{read,write}_reg
>>> functions, you can take the flexcan driver [1] as an example.
>>
>> Adding that is easy of course, but that gives the impression of support
>> for little endian systems. If the core would be instantiated in a little
>> endian fashion in a little endian environment, the DMA accessing parts
>> of the hardware would still not work in a little endian system without
>> modifications to the hardware design.
>
> Can you add this to the Kconfig help text.
>
>>  From the driver point of view either way works for me, but I am not sure
>> what is best.
>
> In this case you should limit the driver to big endian systems via kconfig.

That would of course be nice. One problem with that is that there seems 
to be no Kconfig configuration option to depend on to match big endian 
systems in general.

One solution is to depend on SPARC (the standard environment of the 
core) and having anyone instantiating the core outside of a sparc 
environment patch his or her kernel.

Another solution is of course to do the ifdef on endianness solution 
like in flexcan and have a note in Kconfig text about the hardware not 
being compatible with little endian in an unchanged fashion.

I am not comfortable to try to come up with some hairy dependency that 
tries to catch all kinds of architectures that might or might not be 
configured big endian at compile time.

Cheers,
Andreas

