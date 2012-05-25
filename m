From: Abdul Khan <akhan@symboticware.com>
Subject: Re: Strange error with jspy utility
Date: Fri, 25 May 2012 18:46:52 -0400
Message-ID: <CA+cPUuRwRE4A82AxL0LEOsPsKuu5XTR0wxcejhJMpOe3-ZpXPA@mail.gmail.com>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
	<4FB76279.6040201@hartkopp.net>
	<CA+cPUuTm72nWUcoK5QBEqZdKq9EjcSHcZrR1Z0s=pVV2gK25Ow@mail.gmail.com>
	<4FBEEB87.4060902@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33061 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab2EYWqz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 May 2012 18:46:55 -0400
Received: by pbbrp8 with SMTP id rp8so2299510pbb.19
        for <linux-can@vger.kernel.org>; Fri, 25 May 2012 15:46:52 -0700 (PDT)
In-Reply-To: <4FBEEB87.4060902@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Please see my findings in-line with your questions.

On Thu, May 24, 2012 at 10:16 PM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> Hi Abdul,
>
> i've already seen from your answer to Kurt that you have also tested the CAN
> connection with 'cansend' and 'candump' - which was a really good idea :-)
>
> The CAN state going from "can state STOPPED ----> can state ERROR-ACTIVE" is a
> correct behaviour.
>

thanks for the info.

> In your shown examples you only send ONE single frame.
>

I sent multiple frames and there were three cases.

> It can be that ONLY ONE single frame can pass the bus and then e.g. the
> interrupt line is not processed correctly which does not re-arm the interrupt.
>


CASE-1  ( Loop back: can0-can1 and vice versa )
====================================

#./cansend can0 123#1122334455667788 (multiple time in a loop using script)

#./candump -e any,0:0,#FFFFFFFF

Output:
=====
can0 123 [8] 11 22 33 44 55 66 77 88
can1 123 [8] 11 22 33 44 55 66 77 88
can0 123 [8] 11 22 33 44 55 66 77 88
can1 123 [8] 11 22 33 44 55 66 77 88
.....................................................
.....................................................
.
Similarly for can1, there was no problem.

Result:
=====
All CAN frames passed through the bus and there was no problem with
interrupt line.


CASE-2  ( Loop back: can0-can1 and vice versa )
====================================

#./jsr can0:20,feda | ./jsr can1:40,feda

#./candump -e any,0:0,#FFFFFFFF

Output:
=====
can0 18FEDA40 [1] 0A
can1 18FEDA40 [1] 0A
.................................
................................

#./jspy -P -v

Output:
=====
can0:40,0feda - !6 [1] 0a
can1:40,0feda - !6 [1] 0a
.................................
................................

#./ip -d -s link show

Output:
=====
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can <TRIPLE-SAMPLING> state ERROR-PASSIVE (berr-counter tx 0 rx
128) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    55731          55731        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    1      1        0       0       0       0
    j1939 on

5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can <TRIPLE-SAMPLING> state ERROR-PASSIVE (berr-counter tx 0 rx
128) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    1      1        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    55731          55731        0       0       0       0
    j1939 on


Result:
=====
Only one j1939 frame passed through the bus and there was no problem
with interrupt line.



CASE-3  ( Connected j1939 simulator to can1 )
==================================
Start j1939 simulator connected with can1

#./candump -e any,0:0,#FFFFFFFF

Output:
=====
 can1  20000004  [8] 00 04 00 00 00 00 00 60   ERRORFRAME
	controller-problem{rx-error-warning}
	error-counter-tx-rx{{0}{96}}
 can1  20000004  [8] 00 10 00 00 00 00 00 80   ERRORFRAME
	controller-problem{rx-error-passive}
	error-counter-tx-rx{{0}{128}}


#./ip -d -s link show

Output:
=====
5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can <TRIPLE-SAMPLING> state ERROR-PASSIVE (berr-counter tx 0 rx
128) restart-ms 0
    bitrate 125000 sample-point 0.875
    tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          1          1          0
    RX: bytes  packets  errors  dropped overrun mcast
    16         2        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
    j1939 on


# dmesg

Output:
=====
[    4.616007] can: controller area network core (rev 20090105 abi 8)
[    4.616121] NET: Registered protocol family 29
[    4.618211] can: raw protocol (rev 20090105)
[    4.628480] CAN device driver interface
[    4.630351] sja1000 CAN netdevice driver
[    4.633162] sja1000_isa: platform device 0: port=0x600, mem=0x0, irq=10
[    4.634698] sja1000_isa: platform device 1: port=0x680, mem=0x0, irq=10
[    4.634744] sja1000_isa sja1000_isa.0: probing idx=0: port=0x600,
mem=0x0, irq=10
[    4.638424] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=0x00000600, irq=10)
[    4.638458] sja1000_isa sja1000_isa.1: probing idx=1: port=0x680,
mem=0x0, irq=10
[    4.648482] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=0x00000680, irq=10)
[    4.651477] Legacy sja1000_isa driver for max. 8 devices registered
[    4.665513] can: SAE J1939
[   96.910811] sja1000_isa sja1000_isa.0: can0: setting BTR0=0x03 BTR1=0x9c
[  102.318645] sja1000_isa sja1000_isa.1: can1: setting BTR0=0x03 BTR1=0x9c
[  117.660969] j1939-4: register
[  120.117923] j1939-5: register


I was getting this error, once I tried to send j1939 frame from j1939
simulator to can1

[  254.018168] sja1000_isa sja1000_isa.1: can1: error warning interrupt
[  254.021242] sja1000_isa sja1000_isa.1: can1: error passive interrupt


Result:
=====
No j1939 frame passed through the bus and there was problem with interrupt line.


> Can you please confirm that you can send MORE that ONE CAN frame from can0 to
> can1 and that you also can send more than one frame from can1 to can0?
>

Yes for CAN frames. However, No for j1939 frames

I am using the same sja1000_isa driver provided in the source code
provided by Kurt.

# modprobe sja1000_isa port=0x600,0x680 irq=10,10

I don't know, Why sja1000_isa driver is giving "error warning
interrupt" and "error passive interrupt" messages. As simulator
supposed to be sent properly formatted j1939 frame to can1.

What could be possible cause for this type of behaviour ?

> Regards,
> Oliver

Thanks
Abdul.
