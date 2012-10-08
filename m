From: Steffen Rose <ro@emtas.de>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 16:36:02 +0200
Message-ID: <1722972.yqiF7qX92T@lisa>
References: <6309304.MqJsLKDGaO@lisa> <5072BCFE.5000006@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50912 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab2JHOgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 10:36:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 578A55637DD
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 16:36:05 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osWPpvCcZozj for <linux-can@vger.kernel.org>;
	Mon,  8 Oct 2012 16:36:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id C8A615637A4
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 16:36:04 +0200 (CEST)
In-Reply-To: <5072BCFE.5000006@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

Am Montag, 8. Oktober 2012, 13:46:06 schrieb Marc Kleine-Budde:
> > I use:
> > Virtual box - Host Win 7/Guest kubuntu
> > Linux lisa 3.2.0-30-generic #48-Ubuntu SMP Fri Aug 24 16:52:48 UTC =
2012
> > x86_64 x86_64 x86_64 GNU/Linux
> >=20
> > SocketCAN connector is a EMS CPC-USB.

[...]

> Your program probably produces CAN frames faster than they could be
> delivered by your CAN hardware. Your choices are:

I'm unsure.
My CPU load is high. My application polling is not optimal at the momen=
t. But=20
the CAN busload is not so high.

At the moment I would think, it is more a problem internal or on USB. I=
'm=20
unsure. I search information to analyze the current situation.

> 2) Increase txqueue length to 10000 or so.
>    (ifconfig can0 txqueuelen 10000)

I did it.

after a little bit time...

Now my error:
	write: Interrupted system call


$ ./candump can0

I see nothing.
But: There is traffic on the CAN and the USB traffic light of the CPC-U=
SB is=20
blinking. Means, the CAN-USB transfer data from the CAN to the socketca=
n CAN=20
driver.

Can I see more states about the can, can_raw or the ems_usb modules?


$ ip -det -stat link show can0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen=20
10000
    link/can=20
    can state ERROR-ACTIVE restart-ms 0=20
    bitrate 250000 sample-point 0.875=20
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    ems_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          19         0          1          1          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    18122      25463    19      0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    195038     164170   0       0       0       0     =20

--=20
Mit freundlichen Gr=FC=DFen / Best regards

Steffen Rose
