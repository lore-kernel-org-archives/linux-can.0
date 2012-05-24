From: Abdul Khan <akhan@symboticware.com>
Subject: Re: Strange error with jspy utility
Date: Thu, 24 May 2012 16:30:14 -0400
Message-ID: <CA+cPUuTm72nWUcoK5QBEqZdKq9EjcSHcZrR1Z0s=pVV2gK25Ow@mail.gmail.com>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
	<4FB76279.6040201@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61077 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab2EXUaP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 16:30:15 -0400
Received: by pbbrp8 with SMTP id rp8so750474pbb.19
        for <linux-can@vger.kernel.org>; Thu, 24 May 2012 13:30:15 -0700 (PDT)
In-Reply-To: <4FB76279.6040201@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Please see my findings in-line.

> Are you sure that at least your CAN interfaces are running properly?

I can able to send packet from can0 to can1 and vice versa.

#./cansend can0 123#1122334455667788

#./candump can1

Output:
=====
can1 123 [8] 11 22 33 44 55 66 77 88

> The sja1000 interfaces usually tell you when the are set in dmesg.
> This is definitely missing in this grep'ed output.

I am getting following dmesg.
[    4.629951] can: controller area network core (rev 20090105 abi 8)
[    4.630072] NET: Registered protocol family 29
[    4.631864] can: raw protocol (rev 20090105)
[    4.642162] CAN device driver interface
[    4.644036] sja1000 CAN netdevice driver
[    4.646370] sja1000_isa: platform device 0: port=0x600, mem=0x0, irq=10
[    4.647973] sja1000_isa: platform device 1: port=0x680, mem=0x0, irq=10
[    4.648073] sja1000_isa sja1000_isa.0: probing idx=0: port=0x600,
mem=0x0, irq=10
[    4.651991] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=0x00000600, irq=10)
[    4.652063] sja1000_isa sja1000_isa.1: probing idx=1: port=0x680,
mem=0x0, irq=10
[    4.662256] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=0x00000680, irq=10)
[    4.665633] Legacy sja1000_isa driver for max. 8 devices registered
[    4.672009] sja1000_isa sja1000_isa.0: can0: bit-timing not yet defined
[    4.673968] sja1000_isa sja1000_isa.1: can1: bit-timing not yet defined

on loading can-j1939.ko module
# modprobe can-j1939

dmesg output:
==========
[   76.791667] can: SAE J1939

on setting bit-rate using below command.
#./ip link set can0 type can bitrate 125000
#./ip link set can1 type can bitrate 125000

dmesg output:
==========
[  168.014338] sja1000_isa sja1000_isa.0: can0: setting BTR0=0x03 BTR1=0x1c
[  173.198542] sja1000_isa sja1000_isa.1: can1: setting BTR0=0x03 BTR1=0x1c


on setting link using below command
#./ip link set can0 j1939 on
#./ip link set can1 j1939 on

dmesg output:
==========
[  187.406173] j1939-4: register
[  190.325970] j1939-5: register

> E.g
>
> # ip -details link show
>

# ip -details link show ( Before: ifconfig can0/1 up )

Output:
======================
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
state DOWN qlen 1000
    link/ether 00:01:05:0b:58:7e brd ff:ff:ff:ff:ff:ff
3: sit0: <NOARP> mtu 1480 qdisc noop state DOWN
    link/sit 0.0.0.0 brd 0.0.0.0
4: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    j1939 on
5: can1: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    j1939 on
======================


# ip -details link show  ( After: ifconfig can0/1 up )

Output:
======================
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
state DOWN qlen 1000
    link/ether 00:01:05:0b:58:7e brd ff:ff:ff:ff:ff:ff
3: sit0: <NOARP> mtu 1480 qdisc noop state DOWN
    link/sit 0.0.0.0 brd 0.0.0.0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    j1939 on
5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    j1939 on
======================


#./ifconfig

Output:
======================
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:8 (8.0 B)  TX bytes:8 (8.0 B)
          Interrupt:10 Base address:0x600

can1      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:8 (8.0 B)  TX bytes:8 (8.0 B)
          Interrupt:10 Base address:0x680
======================


# ./ip address show

Output:
======================
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast
state DOWN qlen 1000
    link/ether 00:01:05:0b:58:7e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.2/24 brd 192.168.1.255 scope global eth0
3: sit0: <NOARP> mtu 1480 qdisc noop state DOWN
    link/sit 0.0.0.0 brd 0.0.0.0
4: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can-j1939 0x20 scope link
5: can1: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can-j1939 0x40 scope link
======================

Observation:
=========
After ifconfig up command, it's state changes from "STOPPED" to "ERROR-ACTIVE"

can state STOPPED ----> can state ERROR-ACTIVE

I am not sure, its a normal behaviour or there is some kind of error.

Thanks
Abdul.
