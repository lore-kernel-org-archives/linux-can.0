From: Damien Dusha <d.dusha@gmail.com>
Subject: Re: Dropped Tx frames with SJA1000
Date: Fri, 29 Jul 2016 09:19:44 +1000
Message-ID: <CABeNA8fh=kLpAYo49FLpxzQv-sBSBqWm1v_anbAkGA1sXAF-mQ@mail.gmail.com>
References: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
 <111f48cb-d8e6-67fc-9644-389f342601cb@optusnet.com.au> <CABeNA8dX7GRTDO+1wgz3Wv9v-n4U5tnpHJUHi=V_G57PtXVyCQ@mail.gmail.com>
 <caed996e-2c8e-f54d-78ba-d69ab4361ae6@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33263 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcG1XTp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2016 19:19:45 -0400
Received: by mail-yw0-f177.google.com with SMTP id r9so100851263ywg.0
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2016 16:19:45 -0700 (PDT)
In-Reply-To: <caed996e-2c8e-f54d-78ba-d69ab4361ae6@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: tom_usenet@optusnet.com.au, linux-can@vger.kernel.org

Hello Wolfgang,

>> I am attempting to debug an issue with the SJA1000 driver. The symptom
>> is the occasional dropped frame when transmitting a burst of frames.
>> Reception is unaffected.

> What does "ip -d -s link show can0" report?

[damien@localhost can-utils]$ ip -d -s link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc fq_codel state UNKNOWN
mode DEFAULT group default qlen 1000
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
      bitrate 250000 sample-point 0.875
      tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
      sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
      clock 8000000
      re-started bus-errors arbit-lost error-warn error-pass bus-off
      0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    747304     183494   0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    14767      3859     0       0       0       0


> What device are you using to monitor/trace the traffic?

On a second machine, I have a PEAK USB-CAN adaptor.  I don't believe
this is the problem because:
 - To test, I had a second USB-CAN adaptor, and they both happened to
drop exactly the same frame.
 - On the machine with the SJA1000 which drops frames on transmit, I
can read back the traffic via ./candump can0, which results in the
same dropped frame as the remote machine with the PEAK adaptor.
 - Yesterday I tried to reproduce the problem with a TI Sitara AM3352
(single core ARM Cortex-A8 300MHz, with Bosch D_CAN, running Linux
4.1.8) but was unable to do so (i.e. the PEAK USB works flawlessly).

Incidentally, I bring up the driver in the following way, in the
off-chance it may help:

[damien@localhost ~]$ cat enable_can0.sh
#!/bin/sh

CAN_DEVICE=can0
CAN_BITRATE=250000

sudo ip link set $CAN_DEVICE type can bitrate $CAN_BITRATE
sudo ifconfig $CAN_DEVICE up
sudo ifconfig $CAN_DEVICE txqueuelen 1000
