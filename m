From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: Adding new CAN driver
Date: Fri, 21 Oct 2016 20:47:26 +0200
Message-ID: <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34929 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbcJUSru (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Oct 2016 14:47:50 -0400
Received: by mail-vk0-f53.google.com with SMTP id q126so125781017vkd.2
        for <linux-can@vger.kernel.org>; Fri, 21 Oct 2016 11:47:49 -0700 (PDT)
In-Reply-To: <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Thanks for you answer Oliver :)

On 21 October 2016 at 18:37, Oliver Hartkopp <socketcan@hartkopp.net> wrote=
:
> Hello Remik,
>
> On 10/20/2016 11:11 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>>
>> Hello,
>>
>> I have created SocketCAN driver for Michrochip CAN BUS Analyzer
>> (details: https://github.com/rkollataj/mcba_usb). I would like to
>> upstream it, but as I've never done it before I want to make sure I
>> will take proper steps.
>>
>> My understanding is that I should merge my changes with
>> linux-can-next/master, generate patch and send it to this list. Is
>> that right?
>
>
> Yes :-)
>
> 'git send-email' is easy to use and the best way to send stuff to the
> mailing list.
>
> I was just looking through your code and wondered whether we should suppo=
rt
> the termination switching feature via 'ip' tool or via sysfs.
>
> Just added Marc in CC.
>

I tried to use 'ip' for setting up termination, but I couldn't find a
way. If this is possible I will modify the driver as it seems to be
better idea. Could you give me some hints?

> Regards,
> Oliver
>

One more question about the structure of the driver. I have split it
into source and header files as it was easier to run some tests. I do
not expect that the header will be useful for other drivers. Shall I
merge it with source file in final version?

Regards,
Remik
