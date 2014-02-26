From: Lucas Zampar Bernardi <lucas.zampar@gmail.com>
Subject: Re: MCP2515 DTS support
Date: Wed, 26 Feb 2014 15:17:02 -0300
Message-ID: <530E2F9E.2030809@gmail.com>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com> <530E262C.2040603@gmail.com> <530E294C.4050209@pengutronix.de> <1393437707.859123970@f386.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:45238 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbaBZSRO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 13:17:14 -0500
Received: by mail-yh0-f48.google.com with SMTP id z6so1281266yhz.35
        for <linux-can@vger.kernel.org>; Wed, 26 Feb 2014 10:17:14 -0800 (PST)
In-Reply-To: <1393437707.859123970@f386.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Tnks a lot guys!

I will check for COMMON_CLK support at linux-at91, but for while, I wil=
l=20
use the hardcode frequency!

regards,

lucas

On 26-02-2014 15:01, Alexander Shiyan wrote:
> =D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 26 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=
=D1=8F 2014, 18:50 +01:00 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pengutron=
ix.de>:
>> On 02/26/2014 06:36 PM, Lucas Zampar Bernardi wrote:
>>> You are right Alexander!
>>> The CONFIG_COMMON_CLK hasn't enable!
>>> But for all SOC AT91_SAM9x5 still uses old clock style (AT91_USE_OL=
D_CLK):
>>>
>>> config SOC_AT91SAM9X5
>>>          bool "AT91SAM9x5 family"
>>>          select HAVE_AT91_DBGU0
>>>          select HAVE_FB_ATMEL
>>>          select SOC_AT91SAM9
>>>          select AT91_USE_OLD_CLK
>>>          select HAVE_AT91_UTMI
>>>          select HAVE_AT91_SMD
>>>          select HAVE_AT91_USB_CLK
>>>
>>> and one of dependencies for COMMON_CLK_AT91 is don't be AT91_USE_OL=
D_CLK
>>>
>>> config COMMON_CLK_AT91
>>>          bool
>>>         default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
>>>          select COMMON_CLK
>>>
>>> config OLD_CLK_AT91
>>>          bool
>>>          default AT91_PMC_UNIT && AT91_USE_OLD_CLK
>>>
>>>
>>>
>>>
>>> Now came my question: Can I use CONFIG_COMMON_CLK without my ARCH
>>> support? If not, how we will support devices that need CONFIG_COMMO=
N_CLK?
>> You probably have to wait for common clock support. However you can
>> still hook platform data to your spi device. For a mxs add this to
>> arch/arm/mach-mxs/mach-mxs.c:
>>
>> static int abc_spi_notifier_call(struct notifier_block *nb,
>> 					unsigned long event, void *data)
> ...
>
> Nevertheless, support for the CLK API for SOC AT91_SAM9x5 seems
> already in the kernel.
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree=
/drivers/clk/at91/pmc.c?id=3D05202872ca98f8ea61943a9b530417c5503b816f
>
> You can ask about the CLK status in the AT91 mailing list.
>
> ---

