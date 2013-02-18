From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] can-utils: AOSP build improvements
Date: Mon, 18 Feb 2013 10:10:27 +0100
Message-ID: <CAGm1_ks1qZkaE0UGMV2F9ooFrziMNb3JAtcqMW1AWX7VSP9Teg@mail.gmail.com>
References: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com> <5121E30E.1050305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:65188 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3BRJKt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Feb 2013 04:10:49 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so2418032bkc.11
        for <linux-can@vger.kernel.org>; Mon, 18 Feb 2013 01:10:47 -0800 (PST)
In-Reply-To: <5121E30E.1050305@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Feb 18, 2013 at 9:15 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/18/2013 09:06 AM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Add local headers and GCC flags for all can-utils targets.
>
> Can you create a variable PRIVATE_LOCAL_CFLAGS or whatever to hold the
> -O2 -g -W -Wall \
>> +         -DSO_RXQ_OVFL=40 \
>> +         -DPF_CAN=29 \
>> +         -DAF_CAN=PF_CAN
>
> and reuse that?

Thanks. That makes the code cleaner.

Btw what about isotp.h? Is it going to be mainlined?

Yegor
