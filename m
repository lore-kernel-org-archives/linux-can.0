From: Holger Schurig <holgerschurig@gmail.com>
Subject: CAN question: how to trace frame errors?
Date: Fri, 12 Jun 2015 11:29:25 +0200
Message-ID: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34825 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbFLJ30 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2015 05:29:26 -0400
Received: by wgme6 with SMTP id e6so20390113wgm.2
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2015 02:29:25 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi people,

I have two i.MX6 based boards with built-in FLEXCAN. On both boards I
loaded can_raw.

When I now run "cangen can0 -g 0 -x" one one board, I get frame errors
on the others (no matter if I run candump on the receiving side).


root@left:~# ifconfig can0; ip -s link show can0
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:20249437 errors:6 dropped:0 overruns:0 frame:6
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:116445504 (111.0 MiB)  TX bytes:0 (0.0 B)
          Interrupt:142

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 10
    link/can
    RX: bytes  packets  errors  dropped overrun mcast
    116445504  20249437 6       0       6       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0


In drivers/net/can/flexcan.c I activated all the netdev_dbg() calls,
to see if it is the flexcan IP inside the i.MX6 that gives me a bus
error. This is unfortunately not the case.

And now I'm at a loss to find out where the CAN frames errors might be
come from. I'm not fluent in the Linux networking layers, I even don't
yet know in which struct the frame and error counters reside.



PS: kernel is 3.18.14 with the patches to flexcan from 4.1-rc7 and
also the drivers/net/can patch "can: dev: Consolidate and unify state
change handling". However, I noticed this frame errors the first times
before I applied the patches.

Holger
