From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
Date: Thu, 19 Oct 2017 13:50:22 +0200
Message-ID: <d40533e5-4992-1455-b76a-3effd98b065f@esd.eu>
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
 <5726c394-aa99-5dae-3226-d111d7ff253a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp02.htp-tel.de ([212.59.41.9]:39331 "EHLO mxpout02.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752738AbdJSLul (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Oct 2017 07:50:41 -0400
In-Reply-To: <5726c394-aa99-5dae-3226-d111d7ff253a@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

Am 19.10.2017 um 09:55 schrieb Marc Kleine-Budde:
> On 10/18/2017 04:35 PM, Stefan Mätje wrote:
>> Am 18.10.2017 um 13:48 schrieb Marc Kleine-Budde:
>>> On 10/18/2017 01:25 PM, Stefan Mätje wrote:
>>>> The original author of the module left our company. Replaced the email
>>>> in the MODULE_AUTHOR() macro with a valid one.
>>>>
>>>> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
>>>> ---
>>>>  drivers/net/can/usb/esd_usb2.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
>>>> index be928ce62d32..6183b7707ad7 100644
>>>> --- a/drivers/net/can/usb/esd_usb2.c
>>>> +++ b/drivers/net/can/usb/esd_usb2.c
>>>> @@ -2,6 +2,7 @@
>>>>   * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>>>>   *
>>>>   * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
>>>> + * Copyright (C)      2017 Stefan Maetje <stefan.maetje@esd.eu>, esd gmbh
>>>
>>> Hmmm a copyright for a one liner?
>>
>> Yes, it's somewhat ridiculous but I only wanted to make it clear not to
>> use Matthias's address any more already at the top of the source file.
>>
>>>>   *
>>>>   * This program is free software; you can redistribute it and/or modify it
>>>>   * under the terms of the GNU General Public License as published
>>>> @@ -26,7 +27,7 @@
>>>>  #include <linux/can/dev.h>
>>>>  #include <linux/can/error.h>
>>>>
>>>> -MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
>>>> +MODULE_AUTHOR("Stefan Maetje <stefan.maetje@esd.eu>");
>>>
>>> Maybe you should create a roll email address at your company and change
>>> Matthias Fuchs's email to something like kernel@esd.eu. Think about
>>> adding you or that role email to the MAINTAINERS file.
>>
>> I would suggest an email address of "linux-kernel@esd.eu" which would
>> result then in
>>
>> MODULE_AUTHOR("<linux-kernel@esd.eu>")
>>
>> Would that be ok?
> 
> I was thinking of:
> 
> -MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
> +MODULE_AUTHOR("Matthias Fuchs <linux-kernel@esd.eu>");
> 
> aswell as for the copyright.

That looks good for me.

> 
>> On the other hand I would hesitate to add that email address to the
>> kernel's MAINTAINER file. Then it would stand side by side to your and
>> Wolfgang Grandeggers email adresses under "CAN NETWORK DRIVERS".
>>
>> Or do you mean to create a new section only describing the esd driver
>> for the CAN-USB/2?
> 
> Yes.
> 
>> Wouldn't that be overkill also?
> 
> No, that's what that file is used for. All automated scripts use this
> file instead of the copyright line or the MODULE_AUTHOR.
> 
> Marc

But after discussing your proposal with the MODULE_AUTHOR stuff again
with some other people in house I would like to recall this patch
request and drop it entirely for the moment.

I think we will come back later on this.

Thank you for your effort.

Stefan

