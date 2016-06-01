From: Richard Andrysek <richard.andrysek@gomtec.de>
Subject: AW: c_can driver sometimes sends first two bytes filled with zeros
Date: Wed, 1 Jun 2016 09:40:03 +0000
Message-ID: <0120733A154AE74CA608A286CE7FFD2621DD3945@rg-contact.RG.local>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <574349BB.3010703@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from apollon.gomtec.de ([80.153.46.48]:57428 "EHLO post.gomtec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbcFAJkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Jun 2016 05:40:07 -0400
In-Reply-To: <574349BB.3010703@grandegger.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Thor Thayer <tthayer@opensource.altera.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>

Hi Wolfgang,

Sorry for one week break. Good idea with dumps, see answers below.

>> The official "cansend" does not support "--loop".
I've made the extra test program, please see my email from " 20 May 14:=
01 2016	Richard Andrysek".
With this test I've made following steps.

>>ip  -s -d link show
After 1 hour I've called this command
# ip -s -d link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mod=
e DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00 promiscuity 0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
          bitrate 1000000 sample-point 0.750
          tq 50 prop-seg 7 phase-seg1 7 phase-seg2 5 sjw 1
          c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
          clock 100000000
          re-started bus-errors arbit-lost error-warn error-pass bus-of=
f
          0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    85337216   10667152 0       0       0       0
3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
          bitrate 1000000 sample-point 0.750
          tq 50 prop-seg 7 phase-seg1 7 phase-seg2 5 sjw 1
          c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
          clock 100000000
          re-started bus-errors arbit-lost error-warn error-pass bus-of=
f
          0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    85337216   10667152 0       0       0       0

>> run "candump any,0:0,#FFFFFFFF"
I can run following commands, I let to run for 5min, 10 min, and more:
  # candump can0 | grep -v "01 02 03 04"
  interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
   Or
 # candump can1 | grep -v "01 02 03 04"
 interface =3D can1, family =3D 29, type =3D 3, proto =3D 1=20

Nothing except a first line, which is OK.

Summary:
    If I understand it correctly socketcan is OK. On the bus I have log=
ging without any error, so from Altera to PEAK it is also OK. It is som=
ewhere between "socketcan layer" and peripheral out buffer. What can I =
do now? E.g. shall I try to make the  atomic call over " priv->write_re=
g(...)", if yes how?

CH.

Richard
   =20

-----Urspr=FCngliche Nachricht-----
Von: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
Gesendet: Montag, 23. Mai 2016 20:20
An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.kerne=
l.org
Betreff: Re: c_can driver sometimes sends first two bytes filled with z=
eros

Hello,

Am 12.05.2016 um 11:23 schrieb Richard Andrysek:
> We can reproduce an issue with the canutils. We send messages in the =
loop with non-zero bytes and from time to time we get first two bytes o=
f the message with zero values. The test script looks so:
>
> #!/bin/sh
>
> echo "Press [CTRL+C] to stop.."
> while true
> do
>                 cansend can1 --loop=3D15 -i 933 0xde 0xde 0xde 0xde 0=
xde=20
> 0xde done
>
> With CAN analyzer we see normally the right message, but in cycles ~1=
min we see first two bytes are zero.
>
> If we add some delays between messages, like this:
>
> do
>                 cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0x=
de 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
>
> done
>
> It works fine.
>
> We use Altera Cyclone V, where the  c_can driver is used. It runs wit=
h Linux kernel 3.16, but I've checked 4.5 version of a driver and it is=
 a same one.
>
> Have somebody idea how to find a reason for that?

The official "cansend" does not support "--loop". The official canutils=
 have cangen and canfdtest for more thorough testing. Anyway, does "ip =
-s -d link show" report any errors? And could you run "candump any,0:0,=
#FFFFFFFF" while sending. Does it also list the messages with the wrong=
 data?

Wolfgang.
