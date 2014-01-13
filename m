From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 2/2] slcand: reimplement daemonize routine
Date: Mon, 13 Jan 2014 11:02:39 +0100
Message-ID: <CAGm1_kuDApxXrm+3+CETQ7+KhA5f9cnGVjAMe_0PVU92UaZ0sQ@mail.gmail.com>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
 <1389603245-24023-2-git-send-email-yegorslists@googlemail.com> <20140113095825.GD29475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:34025 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaAMKDE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 05:03:04 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so705053bkz.27
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2014 02:02:59 -0800 (PST)
In-Reply-To: <20140113095825.GD29475@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

On Mon, Jan 13, 2014 at 10:58 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Yegor,
>
> On Mon, Jan 13, 2014 at 09:54:05AM +0100, yegorslists@googlemail.com =
wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Replace daemonize() routine with daemone() system call, because of
>> conflicting licenses. daemonize() routine was derived from under
>> GNU Free Documentation License licensed code. This license is
>> incompatible with GPL-2+.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Thanks.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Just a note. I've tested the patches with our VScom USB-CAN device at
3Mbit/s. So
far everything was working as expected: daemon started and I could
send/receive frames.

Yegor
