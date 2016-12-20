From: Hans L <thehans@gmail.com>
Subject: Troubleshooting bus errors, bus turns off during canplayer playback
Date: Mon, 19 Dec 2016 22:53:17 -0600
Message-ID: <CAFoRp-PSPtdenVSihp+Ar-1xfsOQd1M6rrUN6kgMOGd2egCcoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35976 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754005AbcLTEx6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2016 23:53:58 -0500
Received: by mail-ua0-f179.google.com with SMTP id 88so10213669uaq.3
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2016 20:53:58 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm a developer writing firmware for a J1939 device and I have some
logs recorded from vehicles that I want to use as test data, playing
these on a "bench" setup.

I am using a Beaglebone black running debian, with a PEAK PCAN-USB
adapter to play these logs on my test bus.

When I attempt to play a log that has pretty high bus utilization, it
just quits after sending few frames with "No buffer space available".
I found that default txqueuelen was 10 and increasing it to 1000 helps
get rid of the buffer space issues, but then the canplayer process
still just stops transmitting after 300 frames or so.
I guess the bus is encountering some sort of error, and turning off,
so I set restart-ms 1 to have minimal downtime.

With these settings it seems that canplayer is able to get through the
whole log and transmit all frames, but I don't understand why the bus
has to restart so much in the first place, or the cause of these
errors that regularly kill the bus?

Also many options that I tried such as "berr-reporting on" result in
"RTNETLINK answers: Operation not supported".
And where are the descriptions of what these settings do? I search
through the manual but berr-reporting is only mentioned once in the
options list, but no explanation(same for most other settings)
https://www.kernel.org/doc/Documentation/networking/can.txt

Below is some system info:

debian@beaglebone:~$ uname -a
Linux beaglebone 3.8.13-bone79 #1 SMP Tue Oct 13 20:44:55 UTC 2015
armv7l GNU/Linux

debian@beaglebone:~$ sudo modinfo peak_usb
filename:
/lib/modules/3.8.13-bone79/kernel/drivers/net/can/usb/peak_usb/peak_usb.ko
license:        GPL v2
description:    CAN driver for PEAK-System USB adapters
author:         Stephane Grosjean <s.grosjean@peak-system.com>
srcversion:     E230D7B8207864FEABBECC6
alias:          usb:v0C72p000Dd*dc*dsc*dp*ic*isc*ip*in*
alias:          usb:v0C72p000Cd*dc*dsc*dp*ic*isc*ip*in*
depends:        can-dev
intree:         Y
vermagic:       3.8.13-bone79 SMP mod_unload modversions ARMv7 thumb2 p2v8

debian@beaglebone:~$ ip -d -s link show can0
5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP
mode DEFAULT qlen 1000
    link/can
    can state ERROR-PASSIVE restart-ms 1
    bitrate 250000 sample-point 0.875
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    18         0          0          36         41         20
    RX: bytes  packets  errors  dropped overrun mcast
    10167      2709     0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    1663258    207911   0       46      0       0
