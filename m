From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev - WARN_ON(in_irq())
Date: Tue, 4 Feb 2020 18:52:02 +0100
Message-ID: <8aaec717-0ff7-922b-6969-482363d2790b@hartkopp.net>
References: <87h8245gyv.fsf@steelpick.2x.cz>
 <7429cd37-f4dd-247c-7fa3-259801f20944@rusoku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:30411 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgBDRwG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 12:52:06 -0500
In-Reply-To: <7429cd37-f4dd-247c-7fa3-259801f20944@rusoku.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gediminas Simanskis <gediminas@rusoku.com>, Michal Sojka <michal.sojka@cvut.cz>, linux-can@vger.kernel.org
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Gediminas,

I took a look into the old firmware of the former USB_8DEV adapter with 
the white housing which had a CANAL_STATUSMSG_BUSLIGHT (== 0x02) return 
value:

https://github.com/krumboeck/usb2can_firmware/blob/master/main.c#L227

Is this the right place to search for the value that is checked in the 
kernel here:
https://elixir.bootlin.com/linux/v5.5.1/source/drivers/net/can/usb/usb_8dev.c#L581

??

can0: Tx URB aborted (-2)

At least the status is *only* printed in usb_8dev_write_bulk_callback() 
and the echo skb handling is still performed as there was a zero status 
(== ok?!?).

Do you have an idea how to proceed with the driver in the case the user 
has the newer
https://www.8devices.com/products/usb2can_korlan
device?

Best regards,
Oliver

On 13/12/2019 18.20, Gediminas Simanskis wrote:
> Seems like to USB2CAN buffer overflow and firmware crashing.
> 
> Gediminas
> 
> On 2019-12-13 18:27, Michal Sojka wrote:
>> On Fri, Dec 13 2019, Michal Sojka wrote:
>>> Hi Oliver,
>>>
>>> On Fri, Dec 13 2019, Oliver Hartkopp wrote:
>>>> Did you do anything weird (e.g. pulling the USB plug on the run) to get
>>>> this problem?
>>> No, I just connected it to an ECU and started sending messages on the
>>> bus. The behaviour was like if the messages were not acknowledged, i.e.,
>>> initially, candump on my laptop showed the messages sent, but after some
>>> time (perhaps after TX buffers were full), candump stopped. I was also
>>> not able to see any messages sent by the ECU (both before and after I
>>> sent my messages).
>>>
>>> When I used the same ECU and all the wiring with peak_usb, communication
>>> with the ECU was without any problems.
>> I did more investigation - I was able to fix the problem by adding a
>> terminator resistor to the bus.
>>
>> However, the problem can be easily reproduced by the following sequence
>> of commands, when the USB2CAN is not connected to any bus:
>>
>>      ip link set can0 up txqueuelen 1000 type can bitrate 500000
>>      candump can0
>>      cangen -v -g 50 can0
>>
>> when candump stops printing the messages, run:
>>
>>      ip link set down dev can0
>>
>> and the warnings appear in dmesg. I was also trying this with latest
>> mainline kernel, which includes the fix for use-after-free, and the
>> warnings are still there.
>>
>> -Michal
