From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 15:54:51 +0200
Message-ID: <5555FAAB.4090306@universalnet.at>
References: <5555A6A3.7090206@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:34523 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030335AbbEOOIY (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 15 May 2015 10:08:24 -0400
In-Reply-To: <5555A6A3.7090206@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>, linux-can@vger.kernel.org

Hi!


I don't know much about this things, but what do you think about follow=
ing:

Use two 4 port usb hub (MICROCHIP USB4624I-1080HN) with 8 x STM32F072 o=
r STR750FV2.

You can flash the MCUs under linux with dfu-util (http://dfu-util.sourc=
eforge.net/).

A firmware for STR750FV2 is available here (please check license):
https://github.com/krumboeck/usb2can_firmware

I don't know if it works, but there is also a gcc version available:
https://github.com/krumboeck/usb2can_firmware/tree/gcc-test


If you use this firmware or at least the same procotol, then the
hardware will be compatible with usb_8dev can driver.


regards,
Bernd




Am 2015-05-15 um 09:56 schrieb Fran=C3=A7ois Beaulier:
> Hi,
>
> I'm starting the design of a CPU board, based on a computer on module=
 with a very common SOC like i.mx6 or am335x.
> I need to fit my board with at least 10 CAN ports, may be more. (The =
SOC have 2 CANs so i need 8 more)
> The board will run with Linux and of course i want a socketcan interf=
ace for each bus !
> CAN bitrate needed is quite low (50kbps) and latency is not critical =
but bus load may reach 100% sometimes.
> As far as possible i want to avoid driver development, or just doing =
slight modifications on an existing driver.
> I don't want to use MCP2515, i had trouble with it on a previous desi=
gn because of the lack of buffer in the chip.
> I can't imagine putting 8 MCP2515 and not missing any frame, but may =
be i'm wrong ?
>
> Here are the options i have considered, they involve using external M=
CUs to provide enough CAN interfaces :
>
> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it sho=
uld offer enough performance at low data rate. Problem is that it would=
 require 8 UARTS. I could modify SLCAN driver to allow multiple CAN cha=
nnels on the same UART, and so use MCUs with multiple CANs, does it sou=
nds reasonable ?
>
> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI pro=
tocol manageable on the MCU side (SPI slave). The MCU will be able to p=
rovide the buffer for CAN frames that the MCP does not have. This optio=
n is just a way of trying to go fast, it is not very elegant, and have =
the limitation of one CAN channel per SPI connection / driver instance.
>
> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this l=
ist. This is probably the best choice for a long term and more generic =
solution. But i'm afraid it may require too much work to complete. What=
 is the status of this driver right now ? Does anyone have an idea of t=
he remaining work to do to make it ready for mainline ? Stefano are you=
 available to spend more time on it ? I'm also wondering whether multip=
le instances of the driver can run concurently if i put more than one M=
CU ?
>
> Concerning the MCU software i could release it as an open-source proj=
ect, anyone interested in participating ?
> I'm very familiar with STM32 MCUs so i will probably use an STM32F072=
 (low cost cortex M0 with one CAN).
>
> Any idea or advice is welcome, thank you for reading this much too lo=
ng post.
>
> Regards
>
> Francois Beaulier
> www.ingelibre.fr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

