From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: Adding new CAN driver
Date: Sun, 23 Oct 2016 11:39:09 +0200
Message-ID: <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net> <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:32877 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbcJWJja (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 23 Oct 2016 05:39:30 -0400
Received: by mail-ua0-f173.google.com with SMTP id u68so13140490uau.0
        for <linux-can@vger.kernel.org>; Sun, 23 Oct 2016 02:39:30 -0700 (PDT)
In-Reply-To: <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On 22 October 2016 at 13:57, Oliver Hartkopp <socketcan@hartkopp.net> wrote=
:
> Hi Remik,
>
> On 10/21/2016 08:47 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>>>
>>> I was just looking through your code and wondered whether we should
>>> support
>>> the termination switching feature via 'ip' tool or via sysfs.
>>>
>>> Just added Marc in CC.
>>>
>>
>> I tried to use 'ip' for setting up termination, but I couldn't find a
>> way. If this is possible I will modify the driver as it seems to be
>> better idea. Could you give me some hints?
>
>
> No - not now :-)
>
> That's why I wanted to start the discussion whether we should add this ki=
nd
> of feature to 'ip'.

I have misunderstood, sorry. I know it's not democracy, but I vote for
"yes" :) Having termination as a part of "ip" would be more
straightforward. Putting it to sysfs is more like hidden/secret
feature. On the other hand I do not know how many CAN devices has
possibility to configure built-in termination.

If you will find this feature reasonable enough I could probably spend
some effort to work on it.

>
>> One more question about the structure of the driver. I have split it
>> into source and header files as it was easier to run some tests. I do
>> not expect that the header will be useful for other drivers. Shall I
>> merge it with source file in final version?
>
>
> Yes.
>
> Your patch should contain the changes for Kconfig, Makefile and the creat=
ion
> of the mcba_usb.c file.
>
> Regards,
> Oliver

Regards,
Remik
