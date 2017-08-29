From: Andri Yngvason <andri.yngvason@marel.com>
Subject: RE: flexcan missing error state transitions
Date: Tue, 29 Aug 2017 13:41:38 +0000
Message-ID: <150401409824.16044.6548310235605366193@maxwell>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
 <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
 <23b53bdc-b7d4-f6de-b192-629ffe9795b0@grandegger.com>
 <c5b11618c98a41108dfbe6cf034398f0@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-he1eur01on0069.outbound.protection.outlook.com ([104.47.0.69]:60104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751834AbdH2Nlp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 29 Aug 2017 09:41:45 -0400
In-Reply-To: <c5b11618c98a41108dfbe6cf034398f0@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hi Yi,

Quoting ZHU Yi (ST-FIR/ENG1-Zhu) (2017-08-29 08:49:46)
> > From: Andri Yngvason [mailto:andri.yngvason@marel.com]
> > Sent: Monday, August 28, 2017 7:23 PM
...
> > I have users who can change the baudrate but they can not change the de=
vice
> > tree. The baudrate can even be changed by service technicians. I.e. it'=
s field
> > configurable. How would I configure the timeout to work well for rates =
between
> > 125k and 1M?
> Yes, the poll once approach assumes user have access to device-tree, othe=
rwise
> a catch-all delay (based on the slowest bitrate) is required, which is le=
ss
> flexible than the periodic timer.
Actually, if it depends on the bitrate, then it would be easiest for everyo=
ne to
just set it accordingly in the code based on the bitrate without involving =
dt.
Anyway, that doesn't really matter, since it seems that we're going with the
"irq + suppress flooding" approach.

> =

> > =

> > Do you think that a periodic timer would load the system more than an I=
RQ-flood
> > due to a bad error situation?
> > =

> If not the hrtimer than most likely the periodic timer will not load the =
system
> more than IRQ flood, and we can configure the interval so it can even low=
er the
> system load than IRQ flood. However, the error irq + suppress flooding ap=
proach
> has the following benefits compare to the timer approach:
> 1. report state transitions in time
> 2. no need to handle the contention between irq and timer
> 3. no need to deal with how to specify the delay
OK, good enough.

Regards,
Andri
