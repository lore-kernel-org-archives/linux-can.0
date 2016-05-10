From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Tue, 10 May 2016 14:55:42 +0200
Message-ID: <CAJ=nTsuQgeLpjA6RrL-CKAx+2P9HQhXsad1Y-zk0Cm4b9FNA1g@mail.gmail.com>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
	<CAJ=nTsvE1ZMNC9zmagM=CA+7oE5FWCszeJFsXEO5rc7g=X_B-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34194 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcEJMzo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2016 08:55:44 -0400
Received: by mail-lf0-f43.google.com with SMTP id m64so13691905lfd.1
        for <linux-can@vger.kernel.org>; Tue, 10 May 2016 05:55:44 -0700 (PDT)
In-Reply-To: <CAJ=nTsvE1ZMNC9zmagM=CA+7oE5FWCszeJFsXEO5rc7g=X_B-g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2016-05-10 10:27 GMT+02:00 Mirza Krak <mirza.krak@hostmobility.com>:
> 2016-05-09 12:52 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>> Hello,
>>
>> this patch add support for a software bases rx-fifo implementation (=
patches
>> 1+2). The remaining patches modify the flexcan driver to make use of=
 it. imx6
>> and vf610 SoCs can make use of the 64 mailbox software FIFO, while o=
lder SoCs
>> still use flexcan's 6 mailbox deep hardware FIFO.
>>
>> Testing on any flexcan core is highly appreciated.
>
> Hi Marc.
>
> Tested your patch series on a vf610 SOC. I ran 2 x CAN @ 1Mbit, 80-90=
 % busload.
>
> I do no longer get any "overrun" errors, which I got without your
> patch series. And it seems to be stable, unlike previous patch series=
=2E
> Improvement!
>
> However I ran a simple sequence test and there seems to be some
> ordering issues. I have some memory of that similar issues have been
> discussed earlier on the mailing list and I am not quite sure if this
> is related to your patch series but I get following:
>
> root@mx4-v61-1000000:~/test/can_test# uname -a
> Linux mx4-v61-1000000 4.1.15-00056-ge0b8ccc-dirty #12 Mon May 9
> 15:59:54 CEST 2016 armv7l GNU/Linux
> root@mx4-v61-1000000:~/test/can_test# ./cansequence -r can1
> interface =3D can1, family =3D 29, type =3D 3, proto =3D 1
> received wrong sequence count. expected: 60, got: 61
> received wrong sequence count. expected: 62, got: 60
> received wrong sequence count. expected: 61, got: 62
> received wrong sequence count. expected: 118, got: 119
> received wrong sequence count. expected: 120, got: 118
> received wrong sequence count. expected: 119, got: 120
> received wrong sequence count. expected: 76, got: 77
> received wrong sequence count. expected: 78, got: 76
> received wrong sequence count. expected: 77, got: 78
>
> One strange thing is that the sequence errors only occur on can1, can=
0
> does not show any errors.

Some follow-up information.

Sequence errors occurs only if I run at 500 kbit/s or faster, which
suggests that higher CPU load triggers it.

I also ran same tests without your patch series and do not get any
sequence errors.

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
