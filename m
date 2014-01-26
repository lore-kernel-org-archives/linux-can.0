From: Gediminas Simanskis <gediminas@8devices.com>
Subject: Re: usb_8dev: firmware and windows library
Date: Sun, 26 Jan 2014 11:22:28 +0200
Message-ID: <52E4D3D4.8040307@8devices.com>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>	<52DE5EEF.6080100@hartkopp.net>	<52DE60C7.3050906@8devices.com>	<52DFC08C.2040400@universalnet.at>	<52DFD9B7.40300@pengutronix.de>	<52E36208.3020100@universalnet.at>	<CANQdSEHrxThB8KkmTY8UUqbp6kCdcSAt4-Gu0w1jV08gpHEhxw@mail.gmail.com>	<52E37EF4.3090807@universalnet.at> <CANQdSEH20nr9i0ASEKTBDSayDn8VasnBQYKv7XSx5rp5myFqWQ@mail.gmail.com> <52E3EC8F.30200@hartkopp.net> <52E4CEA2.5030407@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:63756 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaAZJWh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Jan 2014 04:22:37 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so1744140eae.33
        for <linux-can@vger.kernel.org>; Sun, 26 Jan 2014 01:22:35 -0800 (PST)
In-Reply-To: <52E4CEA2.5030407@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>, Oliver Hartkopp <socketcan@hartkopp.net>, Brennan Ashton <bashton@brennanashton.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>

Hello,

binary image must be encrypted in RC4 format with 40 bit key before 
making DFU file.

Gediminas

> Hi!
>
>
> I tried to build my own firmware for the microcontroller with GNU 
> Toolchain.
> I was able to build, but it doesn't work.
> Sadly I'm not able to debug.
>
>
> Maybe someone has an idea?
>
>
> CAUTION: You can brick your hardware, if you accidentally overwrite 
> the bootloader!
>
> If you work careful you can easily flash back to original firmware.
>
>
>
> Setup project and build project:
> 1. Download GNU Toolchain for ARM 
> (https://launchpad.net/gcc-arm-embedded)
> 2. Unpack into /opt
> 3. Set Path: "export PATH=/opt/gcc-arm-none-eabi-4_8-2013q4/bin/:$PATH"
> 4. Unpack gccstartup.tar.gz
> 5. execute "make"
>
>
> Convert bin file to dfu file:
> 1. Download dfu-20101118.tgz from 
> http://www.seeedstudio.com/forum/viewtopic.php?p=4504#p4504
> 2. Unpack wherever you want
> 3. execute "python dfu.py -b 0x20006000:main.bin main.dfu"
>
>
> Flash to device:
> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental 
>
>
>
> What it should do (but does not work):
> * Simple startup for C language
> * Turn on the red led
>
>
> Attached files:
> gccstartup.tar.gz   --- Project source
> main.bin            --- Binary output for flashing
> main.map            --- Linker Mapping file
>
>
> Some last thoughts:
> * The memory map from Gediminas contains a .checksum section. Maybe 
> the bootloader do some checks?
> * Maybe the binary file is ok, but the dfu file is not compatible?
>
>
>
> regards,
> Bernd
>
>
>
> Am 2014-01-25 17:55, schrieb Oliver Hartkopp:
>> Hello Brennan,
>>
>> a packet from Germany to the US is about 16 EUR with DHL and 60EUR 
>> with UPS??
>> Maybe I missed anything with the UPS Website while trying to get some 
>> shipping
>> costs %-]
>>
>> Btw. with all the customs stuff it looks pretty pointless to sent 
>> this adapter
>> to you from Germany and back again :-(
>>
>> I know some guys in the US that bought some of these adapters last year.
>> I'll try to contact them on Monday if it's possible to lend you one 
>> of the
>> adapters and ship it inside the US.
>>
>> Regards,
>> Oliver
>>
>> On 25.01.2014 16:55, Brennan Ashton wrote:
>>> Bernd,
>>> Assuming it's not coming from the Arctic Circle or something I have no
>>> problem covering the cost of shipping. Just shoot me a private email
>>> with how much shipping is and how to get the funds to you.
>>>
>>> --Brennan
>>>
>>> On 1/25/14, Bernd Krumboeck <krumboeck@universalnet.at> wrote:
>>>> I could lend, but the delivery costs would eat my pocket. ;-)
>>>>
>>>> Maybe I could find some time in the next days.
>>>> Are you willing to assist by mail?
>>>>
>>>>
>>>> regards,
>>>> Bernd
>>>>
>>>>
>>>>
>>>> Am 2014-01-25 09:29, schrieb Brennan Ashton:
>>>>> If there is interest and someone can lend me one of these for a 
>>>>> bit of
>>>>> time I'm sure I could get this ported over to the GCC arm tool chain.
>>>>> I have done a few IAR to GCC ports and besides a few tricks they
>>>>> usually are not too bad.
>>>>>
>>>>> --Brennan Ashton
>>>>>
>>>>> On 1/24/14, Bernd Krumboeck <krumboeck@universalnet.at> wrote:
>>>>>> Hi!
>>>>>>
>>>>>>
>>>>>> Source code from firmware v1.5:
>>>>>> https://github.com/krumboeck/usb2can_firmware
>>>>>>
>>>>>>
>>>>>> After some experiments I was able to flash the firmware with 
>>>>>> dfu-util
>>>>>> under
>>>>>> linux:
>>>>>> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental 
>>>>>>
>>>>>>
>>>>>>
>>>>>> Sadly I don't know the way how to build the firmware with a free 
>>>>>> tools
>>>>>> chain.
>>>>>>
>>>>>>
>>>>>> regards,
>>>>>> Bernd
>>>>>>
>>>>>>
>>>>>> Am 2014-01-22 15:46, schrieb Marc Kleine-Budde:
>>>>>>> On 01/22/2014 01:58 PM, Bernd Krumboeck wrote:
>>>>>>>> May I kindly ask you to send me a diff/patch about the changes, 
>>>>>>>> so I
>>>>>>>> can
>>>>>>>> update the firmware sources on github.
>>>>>>>
>>>>>>> A complete new set of sources will do, too. Git will create the 
>>>>>>> diff
>>>>>>> for
>>>>>>> you. :)
>>>>>>>
>>>>>>> Marc
>>>>>>>
>>>>

