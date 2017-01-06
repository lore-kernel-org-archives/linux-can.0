From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: ti hecc rx frames out of order
Date: Fri, 6 Jan 2017 07:02:39 +0100
Message-ID: <CAGm1_ktuttM+aWpNVS6bJ7GxFjzKjce2_mj0-yQfq95YMg=8jg@mail.gmail.com>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com> <CAGm1_kspg3iYO87kk+iugNuC+ABwFn9DuN3KYTXiJ2LFh8_JOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35101 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034738AbdAFGDB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Jan 2017 01:03:01 -0500
Received: by mail-ua0-f196.google.com with SMTP id 96so35664784uaq.2
        for <linux-can@vger.kernel.org>; Thu, 05 Jan 2017 22:03:01 -0800 (PST)
In-Reply-To: <CAGm1_kspg3iYO87kk+iugNuC+ABwFn9DuN3KYTXiJ2LFh8_JOg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, hs@denx.de, anton.a.glukhov@gmail.com

Hi Anton and Heiko,

On Thu, Jan 5, 2017 at 10:10 AM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> Hi Dennis,
>
> On Fri, Dec 2, 2016 at 8:43 PM, Grim, Dennis <Dennis.Grim@teejet.com> wrote:
>> When running canfdtest on a TI AM3517 HECC, frames randomly appear out of order.
>>
>> "can-utils" is current (cloned this week from github)
>>
>> Linux kernel is 3.19.0.
>
> Are you using Device Tree (DTS)? If yes, could you share your HECC
> configuration fragment? Aside from hecc_ck I don't see much DTS
> related info.

Are you still working on upstreaming HECC driver?

Yegor
