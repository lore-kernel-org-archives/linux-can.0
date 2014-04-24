From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Thu, 24 Apr 2014 14:34:43 +0200
Message-ID: <CAGm1_kth41JX_Ru5fh2VYOdZY6xQDoGe_bV1-BNPNSbqRJ4s1g@mail.gmail.com>
References: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com>
 <5357e7f5.c72de00a.4ba2.40ff@mx.google.com> <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com>
 <5358D731.9000908@pengutronix.de> <5358FCFF.9020604@hartkopp.net> <5358FE56.3020408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50975 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbaDXMfJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 08:35:09 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so1907347pbb.36
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2014 05:35:09 -0700 (PDT)
In-Reply-To: <5358FE56.3020408@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Kvaser Support <support@kvaser.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

On Thu, Apr 24, 2014 at 2:06 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/24/2014 02:01 PM, Oliver Hartkopp wrote:
>>
>>
>> On 24.04.2014 11:19, Marc Kleine-Budde wrote:
>>> On 04/24/2014 09:46 AM, Yegor Yefremov wrote:
>>>> What about making a table with following columns:
>>>>
>>>> 1. driver module name
>>>> 2. supported devices
>>>> 3. kernel version, where all these devices are supported
>>>>
>>>> *alternative variant*
>>>>
>>>> 1. device name
>>>> 2. related driver module name
>>>> 3. kernel version
>>>
>>> ^^^ I think this is the most useful variant.
>>
>> Yep!
>>
>> If possible I would like to add the Vendor too:
>>
>> 1. Vendor (with URL to the Vendor)
>> 2. device name  (with URL to the Product if possible)
>> 3. related driver module name
>> 4. Kconfig option: CONFIG_CAN CONFIG_CAN_DEV CONFIG_SJA1000 CONFIG_EMS_PCMCIA
>
> Please only the Kconfig option of the device (CONFIG_EMS_PCMCIA), maybe
> CONFIG_SJA1000, but not more.

Have created a table and the first entry. Our wiki seems to have problems
with sorted lists.

Yegor
