From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 8 Oct 2013 13:47:06 -0700
Message-ID: <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
	<5254608B.4080208@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49918 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab3JHUrH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 16:47:07 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so21401987ieb.9
        for <linux-can@vger.kernel.org>; Tue, 08 Oct 2013 13:47:07 -0700 (PDT)
In-Reply-To: <5254608B.4080208@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Wolfgang,

Thanks for taking the time to help!

Both CAN channels are active and at least one of them has external
traffic on the bus when the problem occurs.

I have installed the PEAK card in an "IntensePC" (
http://www.fit-pc.com/web/products/intense-pc/ ).  It is in the only
full sized miniPCIe slot in the PC.

I'll start some tests to determine the mean failure time so I can try
a non-rt kernel and give you a definitive answer on whether or not
that fixes it.  That could take me a day or two given how long it
takes to reproduce.

I built the kernel once already, and am comfortable patching it.  I'm
currently running a Debian Sid kernel (3.10).  I saw the same problem
with the Debian 3.2 kernel where I backported the sja1000 driver.

Austin

$ ip -d -s link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX: bytes  packets  errors  dropped overrun mcast
    7964       57       0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    7964       57       0       0       0       0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UP mode DEFAULT qlen 1000
    link/ether 00:01:c0:12:29:80 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast
    160966647  505906   0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    1565668810 1457778  0       0       0       0
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UP mode DEFAULT qlen 1000
    link/ether 00:01:c0:12:29:7f brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast
    92348233   293914   0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    2152586    27438    0       0       0       0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 10
    link/can
    can <TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0)
restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    15428069   1929618  0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 30
    link/can
    can <TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0)
restart-ms 0
    bitrate 500000 sample-point 0.875
    tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    89752816   11505773 0       468029  0       0
    TX: bytes  packets  errors  dropped carrier collsns
    3283508    1281127  0       0       0       0
6: vcan0: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
7: vcan1: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    3620640    452580   0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    3620640    452580   0       0       0       0
8: vcan2: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    9999880    1249985  0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    9999880    1249985  0       0       0       0
9: vcan3: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
10: vcan10: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
11: vcan11: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    3552992    444124   0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    3552992    444124   0       0       0       0
12: vcan12: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
13: vcan13: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
14: vcan20: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
15: vcan21: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
16: vcan22: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
17: vcan23: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
18: vcan50: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN mode DEFAULT
    link/can
    vcan
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

On Tue, Oct 8, 2013 at 12:44 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 10/08/2013 08:48 PM, Austin Schuh wrote:
>> $ cat /proc/interrupts  | grep " 18:"
>>  18:   23361632   96767425   20421047   23392586   IO-APIC-fasteoi
>> ata_generic, can1, can0
>
> Are both CAN active when the problem occurs. At least two handler for
> the SJA1000 are called.
>
> [105918.136861] handlers:
> [105918.136962] [<ffffffff810a126f>] irq_default_primary_handler
>   threaded [<ffffffffa00db857>] ata_bmdma_interrupt [libata]
> [105918.136972] [<ffffffff810a126f>] irq_default_primary_handler
>   threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
> [105918.136980] [<ffffffff810a126f>] irq_default_primary_handler
>   threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
> [105918.136981] Disabling IRQ #18
>
>> Looks like the IRQ is shared with ata_generic.  I don't see any
>> hard-drive related problems though after the message, only CAN
>> problems.  If I bring the interface down and then back up with
>> ifconfig, it works again.
>>
>> I see this failure about once per day.
>
> Can you use another PCI slot to have an IRQ solely for the CAN devices?
>
> What does "ip -d -s link" list?
>
> Does the problem show up with a vanilla (non-rt) kernel as well?
>
> Does the problem show up if an app is reading the CAN messages?
>
> Are you able to rebuild your kernel with some additional debug code?
> (Not sure what to trigger yet, though).
>
> Wolfgang.
>
