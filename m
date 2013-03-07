From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: write: No buffer space available
Date: Thu, 07 Mar 2013 17:36:27 +0100
Message-ID: <5138C20B.1070306@hartkopp.net>
References: <CACekSAN4Roq50mr7+2P5Fk8zxY6hSOErqgrxu-3sLbyS7SzwJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:42734 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab3CGQga (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Mar 2013 11:36:30 -0500
In-Reply-To: <CACekSAN4Roq50mr7+2P5Fk8zxY6hSOErqgrxu-3sLbyS7SzwJQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Michael_Th=E9nault?= <michael.thenault@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Michael,

there are more than one threads handling the "no buffer space" question=
 :-)

Usually there is no correct CAN network attached to the CAN interface, =
means:

- there is a least a second CAN node which can acknowledge the sent CAN=
 frames
- the bitrate is identical for all CAN nodes
- the CAN bus is terminated properly (with 2x 120 =3D 60 Ohms)

If you have a working CAN network try to attach your Linux box and read=
 the
data from the working environment first.

So you can be sure, that the bitrate settings and terminations are corr=
ect.

Regards,
Oliver


On 07.03.2013 10:55, Michael Th=E9nault wrote:

> hello,
>=20
> I'm working on a arm system with the 2.6.38.8 kernel.
> When I try to send can frames (with cansend, cangen or sockets) the t=
x
> queue is getting full and then i get this error :
>=20
> write: No buffer space available
>=20
> I've been monitoring the CAN bus with an oscilloscope and nothing
> seems to happen.
> I saw a thread with the similar problem, and there was some problem
> with the one-shot mode. This mode doesn't work with me :
>=20
> # ip link set can0 up type can one-shot on
> RTNETLINK answers: Operation not supported
>=20
> here are some details :
>=20
> # ip -details -statistics link show can0
> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNO=
WN qlen 10
>     link/can
>     can state ERROR-PASSIVE restart-ms 0
>     bitrate 125000 sample-point 0.875
>     tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          4          4          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     0          0        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        3       3       0       0
>=20
> what am i doing wrong ?
> Thank you in advance for your help
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


