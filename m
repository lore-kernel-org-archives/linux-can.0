From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: AW: flexcan missing error state transitions
Date: Mon, 21 Aug 2017 18:21:01 +0000
Message-ID: <150333966184.28484.15326759292718336833@maxwell>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:29497
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753222AbdHUSVK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 21 Aug 2017 14:21:10 -0400
In-Reply-To: <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>

Hi Mark,

Quoting Jonas Mark (ST-FIR/ENG1) (2017-08-21 17:13:34)
> > I am not sure that I like the userspace polling idea. I think it would =
be better to have
> > the polling implemented within the driver because it keeps the interfac=
e "simple"
> > and there will be fewer differences between different platforms. I.e.
> > the same userpspace code should work for flexcan, sja1000, mscan, etc..
> =

> Which polling interval do you think would be appropriate? It somehow has =
to be a reasonable trade-off between latency and CPU usage.
That's a good question. I don't think that there is a really good answer to=
 it.
It would be nice to see intermittent state-transitions happening, so I woul=
d say
as fast as possible without affecting CPU usage to a significant degree. The
polling timer should not be a high resolution timer or anything that would
preempt an rt task.

This value could also depend on the bitrate as that will affect the rate at
which the error-counter can change. E.g. on 125 k rate, you will receive at=
 most
one frame per 1 ms. This means that the error state will change at at least
64 ms intervals, so we would have to sample at 32 ms intervals to catch all=
 the
transitions. For 1 M this would be around 2 ms.

Note that this is all somewhat speculative as I do not know exactly how fas=
t the
error counters are incremented/decremented.

> =

> Would it make sense to make the polling interval configurable via device =
tree?
Also a good questions. I tried compiling a C program that runs usleep(2000)=
 in a
loop for the i.MX6. It runs at around 1% CPU usage in top. I would call that
significant. Perhaps it would run better in kernel space?

If the polling interval can be configured, users who care about it can set =
it to
a value that matches their bitrate. Others could set it to zero to turn it =
off.

As the useful sampling frequency depends on the bitrate, perhaps it should =
even
be a part of the netlink interface? This would also make it easier for the =
user
to find a good sampling frequency based on trial and error.

Regards,
Andri
