From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan missing error state transitions
Date: Mon, 21 Aug 2017 16:18:23 +0000
Message-ID: <150333230375.13890.2773067532209799515@maxwell>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:30388
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753264AbdHUQSc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 21 Aug 2017 12:18:32 -0400
In-Reply-To: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>

Hello Yi ZHU,

Quoting ZHU Yi (ST-FIR/ENG1-Zhu) (2017-08-18 07:47:41)
> Sadly, the flexcan core does not generate error state interrupts for all =
state transitions.
> This is required for the current flexcan driver to operate smoothly. We p=
ropose the following
> workaround to mitigate this problem:
> 1. update state upon _any_ interrupt
> 2. update state when user explicitly inquires (via do_get_state callback)

For now, I think that it would be good enough to implement option 1 as this=
 is
how things were before the regression. Unless there's a performance penalty?

I am not sure that I like the userspace polling idea. I think it would be b=
etter
to have the polling implemented within the driver because it keeps the inte=
rface
"simple" and there will be fewer differences between different platforms. I=
.e.
the same userpspace code should work for flexcan, sja1000, mscan, etc..

Regards,
Andri
