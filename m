From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: Linux board with 10 CANs
Date: Thu, 21 May 2015 05:19:35 +0200
Message-ID: <555D4EC7.60900@universalnet.at>
References: <5555A6A3.7090206@orange.fr> <5555FAAB.4090306@universalnet.at> <5559ABE6.5030206@orange.fr> <5559E994.4000103@universalnet.at> <555C716A.3090509@8devices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:35446 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752357AbbEUDUX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 20 May 2015 23:20:23 -0400
In-Reply-To: <555C716A.3090509@8devices.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gediminas Simanskis <gediminas@8devices.com>
Cc: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>, linux-can@vger.kernel.org

Thank you for the fast response.
I'll update the notes on github (asap).


regards,
Bernd


Am 2015-05-20 um 13:35 schrieb Gediminas Simanskis:
> Hi,
> GPL2
> Gediminas
>
> On 2015-05-18 16:31, Bernd Krumboeck wrote:
>> Hi Gediminas!
>>
>>
>> Can you tell us the license of the source code from usb2can firmware=
?
>>
>>
>> regards,
>> Bernd
>>
>>
>> Am 2015-05-18 um 11:07 schrieb Fran=C3=A7ois Beaulier:
>>> Le 15/05/2015 15:54, Bernd Krumboeck a =C3=A9crit :
>>>> Hi!
>>>>
>>>>
>>>> I don't know much about this things, but what do you think about f=
ollowing:
>>>>
>>>> Use two 4 port usb hub (MICROCHIP USB4624I-1080HN) with 8 x STM32F=
072 or STR750FV2.
>>>>
>>>> You can flash the MCUs under linux with dfu-util (http://dfu-util.=
sourceforge.net/).
>>>>
>>>> A firmware for STR750FV2 is available here (please check license):
>>>> https://github.com/krumboeck/usb2can_firmware
>>>>
>>>> I don't know if it works, but there is also a gcc version availabl=
e:
>>>> https://github.com/krumboeck/usb2can_firmware/tree/gcc-test
>>>>
>>>>
>>>> If you use this firmware or at least the same procotol, then the
>>>> hardware will be compatible with usb_8dev can driver.
>>>>
>>>>
>>>> regards,
>>>> Bernd
>>>>
>>>>
>>>
>>> Hi Bernd,
>>>
>>> Thank you for pointed out this USB solution. I didn't know such fir=
mware existed.
>>> I looked in the gcc-test repository, and apart from ST files the li=
cense is not specified.
>>> Can you tell us more about license ?
>>>
>>> Francois
>>>
>>>
>>>>
>>>>
>>>> Am 2015-05-15 um 09:56 schrieb Fran=C3=A7ois Beaulier:
>>>>> Hi,
>>>>>
>>>>> I'm starting the design of a CPU board, based on a computer on mo=
dule with a very common SOC like i.mx6 or am335x.
>>>>> I need to fit my board with at least 10 CAN ports, may be more. (=
The SOC have 2 CANs so i need 8 more)
>>>>> The board will run with Linux and of course i want a socketcan in=
terface for each bus !
>>>>> CAN bitrate needed is quite low (50kbps) and latency is not criti=
cal but bus load may reach 100% sometimes.
>>>>> As far as possible i want to avoid driver development, or just do=
ing slight modifications on an existing driver.
>>>>> I don't want to use MCP2515, i had trouble with it on a previous =
design because of the lack of buffer in the chip.
>>>>> I can't imagine putting 8 MCP2515 and not missing any frame, but =
may be i'm wrong ?
>>>>>
>>>>> Here are the options i have considered, they involve using extern=
al MCUs to provide enough CAN interfaces :
>>>>>
>>>>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it=
 should offer enough performance at low data rate. Problem is that it w=
ould require 8 UARTS. I could modify SLCAN driver to allow multiple CAN=
 channels on the same UART, and so use MCUs with multiple CANs, does it=
 sounds reasonable ?
>>>>>
>>>>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI=
 protocol manageable on the MCU side (SPI slave). The MCU will be able =
to provide the buffer for CAN frames that the MCP does not have. This o=
ption is just a way of trying to go fast, it is not very elegant, and h=
ave the limitation of one CAN channel per SPI connection / driver insta=
nce.
>>>>>
>>>>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on th=
is list. This is probably the best choice for a long term and more gene=
ric solution. But i'm afraid it may require too much work to complete. =
What is the status of this driver right now ? Does anyone have an idea =
of the remaining work to do to make it ready for mainline ? Stefano are=
 you available to spend more time on it ? I'm also wondering whether mu=
ltiple instances of the driver can run concurently if i put more than o=
ne MCU ?
>>>>>
>>>>> Concerning the MCU software i could release it as an open-source =
project, anyone interested in participating ?
>>>>> I'm very familiar with STM32 MCUs so i will probably use an STM32=
=46072 (low cost cortex M0 with one CAN).
>>>>>
>>>>> Any idea or advice is welcome, thank you for reading this much to=
o long post.
>>>>>
>>>>> Regards
>>>>>
>>>>> Francois Beaulier
>>>>> www.ingelibre.fr
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

