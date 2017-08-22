From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: AW: AW: flexcan missing error state transitions
Date: Tue, 22 Aug 2017 14:14:07 +0000
Message-ID: <150341124698.27819.5656792817823911040@maxwell>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-he1eur01on0044.outbound.protection.outlook.com ([104.47.0.44]:51921
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932510AbdHVOOU (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 22 Aug 2017 10:14:20 -0400
In-Reply-To: <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>

Hello Mark,

Quoting Jonas Mark (ST-FIR/ENG1) (2017-08-22 13:50:35)
> > > Which polling interval do you think would be appropriate? It somehow =
has to be
> > a reasonable trade-off between latency and CPU usage.
> > That's a good question. I don't think that there is a really good answe=
r to it.
> > It would be nice to see intermittent state-transitions happening, so I =
would say as
> > fast as possible without affecting CPU usage to a significant degree. T=
he polling
> > timer should not be a high resolution timer or anything that would pree=
mpt an rt
> > task.
> > =

> > This value could also depend on the bitrate as that will affect the rat=
e at which the
> > error-counter can change. E.g. on 125 k rate, you will receive at most =
one frame
> > per 1 ms. This means that the error state will change at at least
> > 64 ms intervals, so we would have to sample at 32 ms intervals to catch=
 all the
> > transitions. For 1 M this would be around 2 ms.
> > =

> > Note that this is all somewhat speculative as I do not know exactly how=
 fast the
> > error counters are incremented/decremented.
> =

> We agree that there is a sensible lower boundary for the polling interval=
 which depends on the bitrate. And there is a upper boundary which depends =
on the application.
> =

> We are currently thinking about whether it would be possible to do the po=
lling only in case the controller is actually experiencing trouble.
> =

> For the i.MX6 there is an interrupt when the controller changes from Erro=
r Active to Error Warning. This shall enable the polling.
> =

> For the i.MX53 there is no Active -> Warning interrupt. But for all kinds=
 of error events on the bus an Error interrupt will be created. So the poll=
ing shall be enabled then. This is a little bit less efficient compared to =
i.MX6 but the polling will be disabled during the next interrupt if the sta=
te is still Error Active (see below).
> =

> For both, the polling can be disabled when the status is read and it is E=
rror Active. The polling shall be disabled as well when a Bus-Off interrupt=
 occurs.
> =

> What we still need to resolve is the concurrency between the timer and th=
e interrupt when accessing internal data structures and sending SocketCAN e=
rror frames. Once we have that sorted out we will send a patch. None the le=
ss, early feedback is welcome.
The last time we discussed this issue, I suggested something similar and
Wolfgang's response was "Puh, that's far too sophisticated."

What you suggest does not sound overly complicated, so I would say it's a g=
ood
idea. It seems like it's the best that we can do with what we have.

Wolfgang, Marc, what do you think?
> =

> > > Would it make sense to make the polling interval configurable via dev=
ice tree?
> > Also a good questions. I tried compiling a C program that runs usleep(2=
000) in a
> > loop for the i.MX6. It runs at around 1% CPU usage in top. I would call=
 that
> > significant. Perhaps it would run better in kernel space?
> > =

> > If the polling interval can be configured, users who care about it can =
set it to a
> > value that matches their bitrate. Others could set it to zero to turn i=
t off.
> =

> We also think that the polling interval should be configurable. It strong=
ly depends on the application which latency between state change and notifi=
cation is acceptable and how much computing resources may be invested to ac=
hieve that.
Good.
> =

> > As the useful sampling frequency depends on the bitrate, perhaps it sho=
uld even
> > be a part of the netlink interface? This would also make it easier for =
the user to find
> > a good sampling frequency based on trial and error.
> =

> Right now we are not convinced that adding to the netlink interface is ju=
stified to work around deficiencies of a single CAN peripheral.
Fair enough.

Regards,
Andri
