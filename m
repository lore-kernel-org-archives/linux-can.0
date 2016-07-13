From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch
 flexcan driver to use it
Date: Wed, 13 Jul 2016 09:28:00 +0200
Message-ID: <CAJ=nTsuOfu4jyT6tiH+1fWarmSOVHV29zEm2sg6PphXTxKVHLQ@mail.gmail.com>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33031 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcGMH2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2016 03:28:09 -0400
Received: by mail-lf0-f47.google.com with SMTP id b199so31608783lfe.0
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2016 00:28:07 -0700 (PDT)
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, david@protonic.nl

2016-07-04 20:32 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
> Hello,
>
> this patch takes up the idea to read the CAN frames in IRQ context an=
d send
> them later in NAPI. The first two patches add each an offloading sche=
me.
>
> The first one is for hardware FIFO based cores, like the flexcan in F=
IFO mode.
> The second one requires mailboxes with timestamps. The mailboxes are =
read and
> sorted by timestamp in IRQ context, sending is done later in NAPI asw=
ell.
>
> The remaining patches modify the flexcan driver to make use of it. im=
x6 and
> vf610 SoCs can make use of the 64 mailbox software FIFO, while older =
SoCs still
> use flexcan's 6 mailbox deep hardware FIFO.
>
> Testing on any flexcan core is highly appreciated.

Did a test run on v2 series on my VF610 SOC.

I do not see any problems with order anymore [1] and it recovers fine
from "ERROFRAMES" [2]. No other issues to report.

Tested-by: Mirza Krak <mirza.krak@hostmobility.com>

[1]. https://www.marc.info/?l=3Dlinux-can&m=3D146286890307194&w=3D2
[2]. https://www.marc.info/?l=3Dlinux-can&m=3D146374389028083&w=3D2
--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
