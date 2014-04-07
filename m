From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Mon, 07 Apr 2014 12:24:09 +0200
Message-ID: <53427CC9.3090508@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <534170AD.50506@grandegger.com> <534261D0.8060802@denx.de> <5342713B.4000605@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35001 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbaDGKYO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 06:24:14 -0400
In-Reply-To: <5342713B.4000605@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>Oliver Hartkopp <socketcan@hartkopp.net>

Hi Wolfgang,

On 07/04/2014 11:34, Wolfgang Grandegger wrote:

>>>
>>> Any chance to improve on that? At least some kind of error reporting
>>> would be nice otherwise the app does not realize any problems. Or how
>>> does your app handle error cases.
>>
>> About IFF_ECHO: in my understanding, by enabling IFF_ECHO the driver
>> should sent messages back to the upper layer as fast as these messages
>> are put on the bus. As I see in most drivers, can_put_echo() is called
>> directly into the ISR for most drivers.
> 
> Yes, actually when TX is done.
> 
> http://lxr.linux.no/#linux+v2.6.37/Documentation/networking/can.txt#L176

Exactly, that means when the microcontroller has put the messages on the
bus.

>> This driver implements a sort of "remote CAN". I do not know when
>> messages are really put on the bus, because this is done by the
>> microcontroller and not by the Main Controller. There is always a
>> latency due to the fact that I can only enqueue messages on the SPI Bus
>> using the SPI framework, letting the microcontroller doing the rest.
>> Because I do not know when messages are really sent, I thought it makes
>> little sense to implement echo_skbs. I did it during the development
>> (you have found tracks of it), but I dropped later. IMHO this driver
>> should not turn on IFF_ECHO.
> 
> To get that working the firmware must send some notification when TX is
> done... which will be delayed, of course. It's still regarded to be
> better than the loopback done by the protocol layer anyway. The GS_USB
> driver does it for example. But I understand your concerns. Also the TX
> done notification requires resources and bandwidth especially when the
> firmware must handle 5 CAN buses concurrently.  It would reduce the TX
> rate for sure.

This is the point. The protocol was striclty chosen to limit the
overhead between the SOC and the microcontroller. Last but not least,
there are constraints on the maximum SPI frequency that the
microcontroller can support. In my project, even if the i.MX35 can work
flawlessly with higher frequencies, the selected Freescale's
microcontroller (HCS12) is not able to run at frequency higher as 4 Mhz
without missing bytes.
The current protocol takes care of many aspect about performance, and I
think it is a sort of good trade-off between performance and reliability
(long story, maybe OT, but needed to tell you because I thought in the
past to some of ACKs, too).

Additionally, the communication runs on a local bus (SPI), and there is
nothing but hardware broken that can damage the data transfers between
the two microprocessors (apart of Software bugs, of course). A
full-blown protocol with acknowledgement is overkilling here: more
important is to let that the firmware on the CAN controller remains
simple enough to be implemented without OS, as usual in many cases.

> BTW: does the work-queue handling limit the maximum TX rate? If yes,
> threaded interrupts might be the better solution.

It is not: I found that the kernel thread is a good solution.

> 
>> Agree that it should be nice to have some error reporting from the
>> microcontroller. However, it seeems quite difficult for the firmware
>> developers to get it. There is currently no error reporting to the main
>> controller, and if I do something in this direction, it remains untested
>> because I cannot get the related firmware. I will really prefer to let
>> the driver in, even if this feature is not implemented, and add it later
>> when there is a use case for it.
> 
> OK, thinking more about it, a simple state handling is more important
> than error reporting and it should be rather simple to implement in
> firmware. It also does not require a lot of resources.

Can you tell me some more about it ? I have to propagate this to the fw
developers. Do you mean to report bus-off condition ?

> 
>>>> +/* Default Values */
>>>> +static struct can_bittiming_const spi_can_bittiming_const = {
>>>> +	.name = DRV_NAME,
>>>> +	.tseg1_min = 4,
>>>> +	.tseg1_max = 16,
>>>> +	.tseg2_min = 2,
>>>> +	.tseg2_max = 8,
>>>> +	.sjw_max = 4,
>>>> +	.brp_min = 1,
>>>> +	.brp_max = 64,
>>>> +	.brp_inc = 1,
>>>> +};
>>>
>>> Hm, this is specific to the hardware and should not be set globally. Do
>>> you need/use it at all. Typically CAN handled by firmware does use
>>> rather fixed bit timing parameters. Just the bit-rate can usually be
>>> specified.
>>
>> Changed in V3, but with the goal in V4 to query the microcontroller at
>> the start for the timing.
> 
> There is no need for that. Just the bit-rate should be reported properly.

I admit that in my project only bitrate is significant, exactly as you
said. I send already the whole structure, but it is currently ignored by
the firmware with the exception of bitrate. Oliver means that passing
the whole structure can significantly simplify the microcontroller's
firmware, in case values must be computed and on microcontrollers where
they are significant.


>>>
>>> You probabley may want to limit the number of TX messages to be queued.
>>> Otherwise the system may even run out of memory... if I understand the
>>> code correctly
>>
>> You understand right. In my tests, I observed the evolution of
>> messages_in_queue to be sure that it does not increase indefinetely
>> under heavier bus load, without setting a limit. Agree we need a higher
>> limit, I will do it.
> 
> Should be rather simple to implement.

I will do it.

> 
>>>> +static void spi_can_process_single_frame(struct spi_can_data *spi_data,
>>>> +	u32 index)
>>>> +{
>>>> +	struct list_head *pos;
>>>> +	struct msg_queue_rx *msg;
>>>> +	u32 found = 0, freed;
>>>
>>> Why is "int" not just fine.
>>
>> For what ? Both are used as boolean, unsigned is right.
> 
> Yes, but there is no need for "u32". "unsigned int" should just be fine.

Ah ok, got it !

> I use the u32 and friends only when the size is fixed, e.g. due to
> hardware requirements. In all other cases I use "[unsigned] int" or
> "long". But maybe that's also debatable.

I have no arguments for implementing differently as you propose ;-)

>>>> +	ret = gpio_request(data_gpio, "spican-irq");
>>>> +	if (ret) {
>>>> +		dev_err(&spi->dev,
>>>> +			"gpio %d cannot be acquired\n",
>>>> +			data_gpio);
>>>> +		return -ENODEV;
>>>
>>> Please use goto for cleanup...
>>
>> I can do it. Anyway, at this level in probe I have not yet reserved any
>> resource, and returning with an error is not wrong. I have nothing to
>> free in the cleanup at this point.
> 
> You are right. I thought free_irq() or free_gpio() is missing. Maybe
> that was some lines later.

Regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
