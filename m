From: Gediminas Simanskis <gediminas@rusoku.com>
Subject: Re: usb_8dev - WARN_ON(in_irq())
Date: Tue, 4 Feb 2020 21:54:57 +0200
Message-ID: <03fe333a-7a7b-e9b6-fd9e-3d433c2f3cb3@rusoku.com>
References: <87h8245gyv.fsf@steelpick.2x.cz>
 <7429cd37-f4dd-247c-7fa3-259801f20944@rusoku.com>
 <8aaec717-0ff7-922b-6969-482363d2790b@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelija.serveriai.lt ([194.135.87.135]:33485 "EHLO
        lelija.serveriai.lt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDUPq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 15:15:46 -0500
In-Reply-To: <8aaec717-0ff7-922b-6969-482363d2790b@hartkopp.net>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Michal Sojka <michal.sojka@cvut.cz>, linux-can@vger.kernel.org
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Oliver,

I remember that in some conditions usb2can began to flood with messages 
like this (CANAL_STATUSMSG_xx).
In normal state these messages should be disabled via init string.

I don't have acces to Korlan firmware.

Regards,
Gediminas

On 2020-02-04 19:52, Oliver Hartkopp wrote:
> Hello Gediminas,
>
> I took a look into the old firmware of the former USB_8DEV adapter 
> with the white housing which had a CANAL_STATUSMSG_BUSLIGHT (== 0x02) 
> return value:
>
> https://github.com/krumboeck/usb2can_firmware/blob/master/main.c#L227
>
> Is this the right place to search for the value that is checked in the 
> kernel here:
> https://elixir.bootlin.com/linux/v5.5.1/source/drivers/net/can/usb/usb_8dev.c#L581 
>
>
> ??
>
> can0: Tx URB aborted (-2)
>
> At least the status is *only* printed in 
> usb_8dev_write_bulk_callback() and the echo skb handling is still 
> performed as there was a zero status (== ok?!?).
>
> Do you have an idea how to proceed with the driver in the case the 
> user has the newer
> https://www.8devices.com/products/usb2can_korlan
> device?
>
> Best regards,
> Oliver
>
> On 13/12/2019 18.20, Gediminas Simanskis wrote:
>> Seems like to USB2CAN buffer overflow and firmware crashing.
>>
>> Gediminas
>>
>> On 2019-12-13 18:27, Michal Sojka wrote:
>>> On Fri, Dec 13 2019, Michal Sojka wrote:
>>>> Hi Oliver,
>>>>
>>>> On Fri, Dec 13 2019, Oliver Hartkopp wrote:
>>>>> Did you do anything weird (e.g. pulling the USB plug on the run) 
>>>>> to get
>>>>> this problem?
>>>> No, I just connected it to an ECU and started sending messages on the
>>>> bus. The behaviour was like if the messages were not acknowledged, 
>>>> i.e.,
>>>> initially, candump on my laptop showed the messages sent, but after 
>>>> some
>>>> time (perhaps after TX buffers were full), candump stopped. I was also
>>>> not able to see any messages sent by the ECU (both before and after I
>>>> sent my messages).
>>>>
>>>> When I used the same ECU and all the wiring with peak_usb, 
>>>> communication
>>>> with the ECU was without any problems.
>>> I did more investigation - I was able to fix the problem by adding a
>>> terminator resistor to the bus.
>>>
>>> However, the problem can be easily reproduced by the following sequence
>>> of commands, when the USB2CAN is not connected to any bus:
>>>
>>>      ip link set can0 up txqueuelen 1000 type can bitrate 500000
>>>      candump can0
>>>      cangen -v -g 50 can0
>>>
>>> when candump stops printing the messages, run:
>>>
>>>      ip link set down dev can0
>>>
>>> and the warnings appear in dmesg. I was also trying this with latest
>>> mainline kernel, which includes the fix for use-after-free, and the
>>> warnings are still there.
>>>
>>> -Michal
