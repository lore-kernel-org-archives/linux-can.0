From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH 1/2] can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
Date: Wed, 18 Oct 2017 16:35:57 +0200
Message-ID: <b7dc7929-f4b3-2b0b-cfd5-7c514166943d@esd.eu>
References: <8cbd7f4c-cccb-d237-519d-030d82e8b8e9@esd.eu>
 <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp02.htp-tel.de ([212.59.41.9]:41858 "EHLO mxpout02.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdJROgJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Oct 2017 10:36:09 -0400
In-Reply-To: <161fb16b-de6c-0eef-f908-1cb1e11d7f0e@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

Am 18.10.2017 um 13:48 schrieb Marc Kleine-Budde:
> On 10/18/2017 01:25 PM, Stefan Mätje wrote:
>> The original author of the module left our company. Replaced the email
>> in the MODULE_AUTHOR() macro with a valid one.
>>
>> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
>> ---
>>  drivers/net/can/usb/esd_usb2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
>> index be928ce62d32..6183b7707ad7 100644
>> --- a/drivers/net/can/usb/esd_usb2.c
>> +++ b/drivers/net/can/usb/esd_usb2.c
>> @@ -2,6 +2,7 @@
>>   * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>>   *
>>   * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
>> + * Copyright (C)      2017 Stefan Maetje <stefan.maetje@esd.eu>, esd gmbh
> 
> Hmmm a copyright for a one liner?

Yes, it's somewhat ridiculous but I only wanted to make it clear not to
use Matthias's address any more already at the top of the source file.

>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms of the GNU General Public License as published
>> @@ -26,7 +27,7 @@
>>  #include <linux/can/dev.h>
>>  #include <linux/can/error.h>
>>
>> -MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
>> +MODULE_AUTHOR("Stefan Maetje <stefan.maetje@esd.eu>");
> 
> Maybe you should create a roll email address at your company and change
> Matthias Fuchs's email to something like kernel@esd.eu. Think about
> adding you or that role email to the MAINTAINERS file.

I would suggest an email address of "linux-kernel@esd.eu" which would
result then in

MODULE_AUTHOR("<linux-kernel@esd.eu>")

Would that be ok?

On the other hand I would hesitate to add that email address to the
kernel's MAINTAINER file. Then it would stand side by side to your and
Wolfgang Grandeggers email adresses under "CAN NETWORK DRIVERS".

Or do you mean to create a new section only describing the esd driver
for the CAN-USB/2? Wouldn't that be overkill also?

>>  MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>> interfaces");
>>  MODULE_LICENSE("GPL v2");
>>
> 
> Marc

