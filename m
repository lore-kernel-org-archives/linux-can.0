From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: c_can driver sometimes sends first two bytes filled with zeros
Date: Wed, 1 Jun 2016 15:09:55 +0200
Message-ID: <574EDEA3.5090204@grandegger.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <574349BB.3010703@grandegger.com>
 <0120733A154AE74CA608A286CE7FFD2621DD3945@rg-contact.RG.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.140]:51408 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcFANJ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Jun 2016 09:09:59 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621DD3945@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Thor Thayer <tthayer@opensource.altera.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>

Hello Richard,

Am 01.06.2016 um 11:40 schrieb Richard Andrysek:
> Hi Wolfgang,
>
> Sorry for one week break. Good idea with dumps, see answers below.
>
>>> The official "cansend" does not support "--loop".
> I've made the extra test program, please see my email from " 20 May 1=
4:01 2016	Richard Andrysek".
> With this test I've made following steps.
>
>>> ip  -s -d link show
> After 1 hour I've called this command
> # ip -s -d link show
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN m=
ode DEFAULT group default
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00 promiscuit=
y 0
>      RX: bytes  packets  errors  dropped overrun mcast
>      0          0        0       0       0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNO=
WN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>            bitrate 1000000 sample-point 0.750

>            tq 50 prop-seg 7 phase-seg1 7 phase-seg2 5 sjw 1
>            c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc=
 1
>            clock 100000000
>            re-started bus-errors arbit-lost error-warn error-pass bus=
-off
>            0          0          0          0          0          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      0          0        0       0       0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      85337216   10667152 0       0       0       0
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNO=
WN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>            bitrate 1000000 sample-point 0.750
>            tq 50 prop-seg 7 phase-seg1 7 phase-seg2 5 sjw 1
>            c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc=
 1
>            clock 100000000
>            re-started bus-errors arbit-lost error-warn error-pass bus=
-off
>            0          0          0          0          0          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      0          0        0       0       0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      85337216   10667152 0       0       0       0

OK, no errors reported.

>>> run "candump any,0:0,#FFFFFFFF"
> I can run following commands, I let to run for 5min, 10 min, and more=
:
>    # candump can0 | grep -v "01 02 03 04"
>    interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
>     Or
>   # candump can1 | grep -v "01 02 03 04"
>   interface =3D can1, family =3D 29, type =3D 3, proto =3D 1
>
> Nothing except a first line, which is OK.

Ok, anyway, please use the official CAN utilities [1] sooner than later=
=2E


> Summary:
>      If I understand it correctly socketcan is OK. On the bus I have =
logging without any error, so from Altera to PEAK it is also OK. It is =
somewhere between "socketcan layer" and peripheral out buffer. What can=
 I do now? E.g. shall I try to make the  atomic call over " priv->write=
_reg(...)", if yes how?

Making "priv->write_regs() atomic is something I would try as well. My=20
suspicion is that something goes wrong writing(/reading) the controller=
=20
registers.

[1] https://github.com/linux-can/can-utils

Wolfgang.

> CH.
>
> Richard
>
>
> -----Urspr=FCngliche Nachricht-----
> Von: Wolfgang Grandegger [mailto:wg@grandegger.com]
> Gesendet: Montag, 23. Mai 2016 20:20
> An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.ker=
nel.org
> Betreff: Re: c_can driver sometimes sends first two bytes filled with=
 zeros
>
> Hello,
>
> Am 12.05.2016 um 11:23 schrieb Richard Andrysek:
>> We can reproduce an issue with the canutils. We send messages in the=
 loop with non-zero bytes and from time to time we get first two bytes =
of the message with zero values. The test script looks so:
>>
>> #!/bin/sh
>>
>> echo "Press [CTRL+C] to stop.."
>> while true
>> do
>>                  cansend can1 --loop=3D15 -i 933 0xde 0xde 0xde 0xde=
 0xde
>> 0xde done
>>
>> With CAN analyzer we see normally the right message, but in cycles ~=
1min we see first two bytes are zero.
>>
>> If we add some delays between messages, like this:
>>
>> do
>>                  cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde =
0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>>
>> done
>>
>> It works fine.
>>
>> We use Altera Cyclone V, where the  c_can driver is used. It runs wi=
th Linux kernel 3.16, but I've checked 4.5 version of a driver and it i=
s a same one.
>>
>> Have somebody idea how to find a reason for that?
>
> The official "cansend" does not support "--loop". The official canuti=
ls have cangen and canfdtest for more thorough testing. Anyway, does "i=
p -s -d link show" report any errors? And could you run "candump any,0:=
0,#FFFFFFFF" while sending. Does it also list the messages with the wro=
ng data?
>
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
