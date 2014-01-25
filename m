From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Sat, 25 Jan 2014 17:55:43 +0100
Message-ID: <52E3EC8F.30200@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>	<52DE5EEF.6080100@hartkopp.net>	<52DE60C7.3050906@8devices.com>	<52DFC08C.2040400@universalnet.at>	<52DFD9B7.40300@pengutronix.de>	<52E36208.3020100@universalnet.at>	<CANQdSEHrxThB8KkmTY8UUqbp6kCdcSAt4-Gu0w1jV08gpHEhxw@mail.gmail.com>	<52E37EF4.3090807@universalnet.at> <CANQdSEH20nr9i0ASEKTBDSayDn8VasnBQYKv7XSx5rp5myFqWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:32716 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaAYQzp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jan 2014 11:55:45 -0500
In-Reply-To: <CANQdSEH20nr9i0ASEKTBDSayDn8VasnBQYKv7XSx5rp5myFqWQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brennan Ashton <bashton@brennanashton.com>, Bernd Krumboeck <krumboeck@universalnet.at>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Gediminas Simanskis <gediminas@8devices.com>, linux-can@vger.kernel.org

Hello Brennan,

a packet from Germany to the US is about 16 EUR with DHL and 60EUR with UPS??
Maybe I missed anything with the UPS Website while trying to get some shipping
costs %-]

Btw. with all the customs stuff it looks pretty pointless to sent this adapter
to you from Germany and back again :-(

I know some guys in the US that bought some of these adapters last year.
I'll try to contact them on Monday if it's possible to lend you one of the
adapters and ship it inside the US.

Regards,
Oliver

On 25.01.2014 16:55, Brennan Ashton wrote:
> Bernd,
> Assuming it's not coming from the Arctic Circle or something I have no
> problem covering the cost of shipping. Just shoot me a private email
> with how much shipping is and how to get the funds to you.
> 
> --Brennan
> 
> On 1/25/14, Bernd Krumboeck <krumboeck@universalnet.at> wrote:
>> I could lend, but the delivery costs would eat my pocket. ;-)
>>
>> Maybe I could find some time in the next days.
>> Are you willing to assist by mail?
>>
>>
>> regards,
>> Bernd
>>
>>
>>
>> Am 2014-01-25 09:29, schrieb Brennan Ashton:
>>> If there is interest and someone can lend me one of these for a bit of
>>> time I'm sure I could get this ported over to the GCC arm tool chain.
>>> I have done a few IAR to GCC ports and besides a few tricks they
>>> usually are not too bad.
>>>
>>> --Brennan Ashton
>>>
>>> On 1/24/14, Bernd Krumboeck <krumboeck@universalnet.at> wrote:
>>>> Hi!
>>>>
>>>>
>>>> Source code from firmware v1.5:
>>>> https://github.com/krumboeck/usb2can_firmware
>>>>
>>>>
>>>> After some experiments I was able to flash the firmware with dfu-util
>>>> under
>>>> linux:
>>>> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental
>>>>
>>>>
>>>> Sadly I don't know the way how to build the firmware with a free tools
>>>> chain.
>>>>
>>>>
>>>> regards,
>>>> Bernd
>>>>
>>>>
>>>> Am 2014-01-22 15:46, schrieb Marc Kleine-Budde:
>>>>> On 01/22/2014 01:58 PM, Bernd Krumboeck wrote:
>>>>>> May I kindly ask you to send me a diff/patch about the changes, so I
>>>>>> can
>>>>>> update the firmware sources on github.
>>>>>
>>>>> A complete new set of sources will do, too. Git will create the diff
>>>>> for
>>>>> you. :)
>>>>>
>>>>> Marc
>>>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
