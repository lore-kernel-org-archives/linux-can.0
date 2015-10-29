From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: CAN operstate
Date: Thu, 29 Oct 2015 11:00:15 +0100
Message-ID: <CAJ=nTssBePCQnObNRWVKr=rx-y6DzVGg_Zp8nuHyiEFagdRqHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36082 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbJ2KAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2015 06:00:17 -0400
Received: by lbjm5 with SMTP id m5so24511272lbj.3
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2015 03:00:15 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi.

I am having some issues with operstate on my CAN devices.

With the following command I would expect the operating state to be UP.

     ip link set can0 up type can bitrate 250000

But all I am getting is UNKNOWN.
root@mx4-v61-0:~/test/can_test# ip link set can0 up type can bitrate 25=
0000
root@mx4-v61-0:~/test/can_test# ip -det link show can0
2: can0@NONE: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1

After a
     ip link set can0 down

It shows correct value which is "state DOWN". I can get it to display
"state UP" if I transition to BUS-OFF state once and restart it with

root@mx4-t20-0:~# ip link set can0 up type can bitrate 1000000
root@mx4-t20-0:~# ip -det link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 83 prop-seg 4 phase-seg1 4 phase-seg2 3 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 12000000
root@mx4-t20-0:~# cansequence -p can0
interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
^C
root@mx4-t20-0:~# ip -det link show can0
2: can0: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN
mode DEFAULT qlen 10
    link/can
    can state BUS-OFF (berr-counter tx 127 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 83 prop-seg 4 phase-seg1 4 phase-seg2 3 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 12000000
root@mx4-t20-0:~# ip link set can0 type can restart
root@mx4-t20-0:~# ip -det link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP
mode DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 83 prop-seg 4 phase-seg1 4 phase-seg2 3 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 12000000

I have tested the above on two different kernel versions and two
different CAN drivers
    - Linux 4.1.5 (flexcan)
    - Linux 3.1.10 (sja1000)

I also found this [1] thread which touches this issue as well, but he
was happy doing "ip -det link show can0 | grep UP", I am not :).
operstate should be should be displaying a correct value?

Is it just me or do we have a problem in the kernel here?
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
