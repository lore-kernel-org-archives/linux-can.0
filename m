From: Gediminas Simanskis <gediminas@8devices.com>
Subject: Re: Linux board with 10 CANs
Date: Wed, 20 May 2015 14:35:06 +0300
Message-ID: <555C716A.3090509@8devices.com>
References: <5555A6A3.7090206@orange.fr> <5555FAAB.4090306@universalnet.at> <5559ABE6.5030206@orange.fr> <5559E994.4000103@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34002 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbETLfL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 May 2015 07:35:11 -0400
Received: by wicmc15 with SMTP id mc15so146734389wic.1
        for <linux-can@vger.kernel.org>; Wed, 20 May 2015 04:35:10 -0700 (PDT)
In-Reply-To: <5559E994.4000103@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>, linux-can@vger.kernel.org

Hi,
GPL2
Gediminas

On 2015-05-18 16:31, Bernd Krumboeck wrote:
> Hi Gediminas!
>
>
> Can you tell us the license of the source code from usb2can firmware?
>
>
> regards,
> Bernd
>
>
> Am 2015-05-18 um 11:07 schrieb Fran=C3=A7ois Beaulier:
>> Le 15/05/2015 15:54, Bernd Krumboeck a =C3=A9crit :
>>> Hi!
>>>
>>>
>>> I don't know much about this things, but what do you think about=20
>>> following:
>>>
>>> Use two 4 port usb hub (MICROCHIP USB4624I-1080HN) with 8 x=20
>>> STM32F072 or STR750FV2.
>>>
>>> You can flash the MCUs under linux with dfu-util=20
>>> (http://dfu-util.sourceforge.net/).
>>>
>>> A firmware for STR750FV2 is available here (please check license):
>>> https://github.com/krumboeck/usb2can_firmware
>>>
>>> I don't know if it works, but there is also a gcc version available=
:
>>> https://github.com/krumboeck/usb2can_firmware/tree/gcc-test
>>>
>>>
>>> If you use this firmware or at least the same procotol, then the
>>> hardware will be compatible with usb_8dev can driver.
>>>
>>>
>>> regards,
>>> Bernd
>>>
>>>
>>
>> Hi Bernd,
>>
>> Thank you for pointed out this USB solution. I didn't know such=20
>> firmware existed.
>> I looked in the gcc-test repository, and apart from ST files the=20
>> license is not specified.
>> Can you tell us more about license ?
>>
>> Francois
>>
>>
>>>
>>>
>>> Am 2015-05-15 um 09:56 schrieb Fran=C3=A7ois Beaulier:
>>>> Hi,
>>>>
>>>> I'm starting the design of a CPU board, based on a computer on=20
>>>> module with a very common SOC like i.mx6 or am335x.
>>>> I need to fit my board with at least 10 CAN ports, may be more.=20
>>>> (The SOC have 2 CANs so i need 8 more)
>>>> The board will run with Linux and of course i want a socketcan=20
>>>> interface for each bus !
>>>> CAN bitrate needed is quite low (50kbps) and latency is not=20
>>>> critical but bus load may reach 100% sometimes.
>>>> As far as possible i want to avoid driver development, or just=20
>>>> doing slight modifications on an existing driver.
>>>> I don't want to use MCP2515, i had trouble with it on a previous=20
>>>> design because of the lack of buffer in the chip.
>>>> I can't imagine putting 8 MCP2515 and not missing any frame, but=20
>>>> may be i'm wrong ?
>>>>
>>>> Here are the options i have considered, they involve using externa=
l=20
>>>> MCUs to provide enough CAN interfaces :
>>>>
>>>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it=20
>>>> should offer enough performance at low data rate. Problem is that=20
>>>> it would require 8 UARTS. I could modify SLCAN driver to allow=20
>>>> multiple CAN channels on the same UART, and so use MCUs with=20
>>>> multiple CANs, does it sounds reasonable ?
>>>>
>>>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI=20
>>>> protocol manageable on the MCU side (SPI slave). The MCU will be=20
>>>> able to provide the buffer for CAN frames that the MCP does not=20
>>>> have. This option is just a way of trying to go fast, it is not=20
>>>> very elegant, and have the limitation of one CAN channel per SPI=20
>>>> connection / driver instance.
>>>>
>>>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on thi=
s=20
>>>> list. This is probably the best choice for a long term and more=20
>>>> generic solution. But i'm afraid it may require too much work to=20
>>>> complete. What is the status of this driver right now ? Does anyon=
e=20
>>>> have an idea of the remaining work to do to make it ready for=20
>>>> mainline ? Stefano are you available to spend more time on it ? I'=
m=20
>>>> also wondering whether multiple instances of the driver can run=20
>>>> concurently if i put more than one MCU ?
>>>>
>>>> Concerning the MCU software i could release it as an open-source=20
>>>> project, anyone interested in participating ?
>>>> I'm very familiar with STM32 MCUs so i will probably use an=20
>>>> STM32F072 (low cost cortex M0 with one CAN).
>>>>
>>>> Any idea or advice is welcome, thank you for reading this much too=
=20
>>>> long post.
>>>>
>>>> Regards
>>>>
>>>> Francois Beaulier
>>>> www.ingelibre.fr
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe=20
>>>> linux-can" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

