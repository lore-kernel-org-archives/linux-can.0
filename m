From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 17:42:48 +0100
Message-ID: <CAKT-o-cxTrE28g2HOGUZrdK+eefr9Os2LyrKZddxfkwiWrczOg@mail.gmail.com>
References: <20170106125344.15267-1-mkl@pengutronix.de> <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de> <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de> <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>
 <14f11375-b53e-d839-81f7-469cec1d9547@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32947 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755602AbdAJQnJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 11:43:09 -0500
Received: by mail-vk0-f48.google.com with SMTP id 137so363300579vkl.0
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2017 08:43:09 -0800 (PST)
In-Reply-To: <14f11375-b53e-d839-81f7-469cec1d9547@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Marc,

On 10 January 2017 at 11:33, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/10/2017 11:18 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>> Hi,
>>
>> I can see three major problems with setting up predefined bitrates:
>> 1. I think that there is no way to pass supported bitrates to
>> userspace (other than printk)
>
> yes
>
>> 2. The bitrate that is passed to the driver is calculated/validated by
>> can_get_bittiming. This causes that driver not always get exact value
>> that was input by a user.
>
> Have you seen my patch?
Yes, your patch solves that issue too.

>
>> 3. When CAN device is using predefined bitrates you do not have
>> influence or even access to bittiming parameters. As you noticed I had
>> to hardcode those values in mcba_usb to present them correctly to
>> userspace.
>
> With my patch, there's no need to set bittiming_const anymore.
You are right, but can_bittiming is still passed to userspace and
since devices with predefined bitrates have no interest in bittiming
parameters the struct will contain undefined values (i.e. tq,
prop_seg, phase_seg etc.).

>
>> Based on solution created by Oliver for termination I created
>> something similar for predefined bitrates. It solves issue number 1
>> and 2. Not sure how to solve issue 3 correctly to maintain
>> compatibility (adding another netlink value for predefined bitrate
>> will break it). As for now I just zeroed values.
>>
>> The patch is just to visualise my idea. It definitely needs some more wo=
rk.
>>
>> Inside the driver:
>> const u32 predef_bitrate[] =3D {20000, 50000, 100000};
>>
>> priv->bitrate_const =3D predef_bitrate;
>> priv->bitrate_const_cnt =3D ARRAY_SIZE(predef_bitrate);
>
> The general idea makes sense, although we need support for CANFD, too.
I'm not so familiar with CANFD. Do you mean can_data_bittiming part?

> Let's first agree on Oliver's and my patch, then yours will fit in easily=
.
>
Ok.

Cheers,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
