From: Lucas Zampar Bernardi <lucas.zampar@gmail.com>
Subject: Re: MCP2515 DTS support
Date: Wed, 26 Feb 2014 14:36:44 -0300
Message-ID: <530E262C.2040603@gmail.com>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com> <1393388253.686159171@f330.i.mail.ru> <530DE824.2060803@gmail.com> <1393426239.267518204@f362.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:43268 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbaBZRgu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 12:36:50 -0500
Received: by mail-yk0-f174.google.com with SMTP id 20so3353084yks.5
        for <linux-can@vger.kernel.org>; Wed, 26 Feb 2014 09:36:49 -0800 (PST)
In-Reply-To: <1393426239.267518204@f362.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

You are right Alexander!
The CONFIG_COMMON_CLK hasn't enable!
But for all SOC AT91_SAM9x5 still uses old clock style (AT91_USE_OLD_CL=
K):

config SOC_AT91SAM9X5
         bool "AT91SAM9x5 family"
         select HAVE_AT91_DBGU0
         select HAVE_FB_ATMEL
         select SOC_AT91SAM9
         select AT91_USE_OLD_CLK
         select HAVE_AT91_UTMI
         select HAVE_AT91_SMD
         select HAVE_AT91_USB_CLK

and one of dependencies for COMMON_CLK_AT91 is don't be AT91_USE_OLD_CL=
K

config COMMON_CLK_AT91
         bool
        default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
         select COMMON_CLK

config OLD_CLK_AT91
         bool
         default AT91_PMC_UNIT && AT91_USE_OLD_CLK




Now came my question: Can I use CONFIG_COMMON_CLK without my ARCH=20
support? If not, how we will support devices that need CONFIG_COMMON_CL=
K?



regards,


Lucas

On 26-02-2014 11:50, Alexander Shiyan wrote:
> =D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 26 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=
=D1=8F 2014, 10:12 -03:00 =D0=BE=D1=82 Lucas Zampar Bernardi <lucas.zam=
par@gmail.com>:
>> Hello Alexander,
>>
>>
>> Follow attach my DTS file and my dmesg log.
>> How you can see, we have "mcp251x: probe of spi32766.2 failed with e=
rror
>> -2.".
>> I discovered that the cause is the clock config structure, because i=
f
>> I've forced a frequency hardcode all driver works.
>> The point where I've forced is:
> ...
>
> Seems, you are missing "fixed-clock" driver in the kernel.
> Is CONFIG_COMMON_CLK option is enabled in your .config?
>
> ---

