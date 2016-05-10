From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Tue, 10 May 2016 10:27:21 +0200
Message-ID: <CAJ=nTsvE1ZMNC9zmagM=CA+7oE5FWCszeJFsXEO5rc7g=X_B-g@mail.gmail.com>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34488 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcEJI1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2016 04:27:23 -0400
Received: by mail-lf0-f41.google.com with SMTP id m64so6335283lfd.1
        for <linux-can@vger.kernel.org>; Tue, 10 May 2016 01:27:22 -0700 (PDT)
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2016-05-09 12:52 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
> Hello,
>
> this patch add support for a software bases rx-fifo implementation (p=
atches
> 1+2). The remaining patches modify the flexcan driver to make use of =
it. imx6
> and vf610 SoCs can make use of the 64 mailbox software FIFO, while ol=
der SoCs
> still use flexcan's 6 mailbox deep hardware FIFO.
>
> Testing on any flexcan core is highly appreciated.

Hi Marc.

Tested your patch series on a vf610 SOC. I ran 2 x CAN @ 1Mbit, 80-90 %=
 busload.

I do no longer get any "overrun" errors, which I got without your
patch series. And it seems to be stable, unlike previous patch series.
Improvement!

However I ran a simple sequence test and there seems to be some
ordering issues. I have some memory of that similar issues have been
discussed earlier on the mailing list and I am not quite sure if this
is related to your patch series but I get following:

root@mx4-v61-1000000:~/test/can_test# uname -a
Linux mx4-v61-1000000 4.1.15-00056-ge0b8ccc-dirty #12 Mon May 9
15:59:54 CEST 2016 armv7l GNU/Linux
root@mx4-v61-1000000:~/test/can_test# ./cansequence -r can1
interface =3D can1, family =3D 29, type =3D 3, proto =3D 1
received wrong sequence count. expected: 60, got: 61
received wrong sequence count. expected: 62, got: 60
received wrong sequence count. expected: 61, got: 62
received wrong sequence count. expected: 118, got: 119
received wrong sequence count. expected: 120, got: 118
received wrong sequence count. expected: 119, got: 120
received wrong sequence count. expected: 76, got: 77
received wrong sequence count. expected: 78, got: 76
received wrong sequence count. expected: 77, got: 78

One strange thing is that the sequence errors only occur on can1, can0
does not show any errors.

Otherwise statistics look good:
root@mx4-v61-1000000:~/test/can_test# ip -d -s link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 83 prop-seg 4 phase-seg1 4 phase-seg2 3 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 24000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    14000000   1750000  0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
root@mx4-v61-1000000:~/test/can_test# ip -d -s link show can1
3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 83 prop-seg 4 phase-seg1 4 phase-seg2 3 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 24000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    12000000   1500000  0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

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
