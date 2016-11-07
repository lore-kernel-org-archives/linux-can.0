From: Rein Appeldoorn <reinappeldoorn@gmail.com>
Subject: Problems PEAK CAN SJA1000 CAN interface
Date: Mon, 7 Nov 2016 15:15:32 +0100
Message-ID: <CAPO0vctcyJMMVJ7BvhGYum+BzbhJ4vK+LM2fPPbVC_S-o=L9Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36752 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbcKGOQE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 09:16:04 -0500
Received: by mail-wm0-f54.google.com with SMTP id p190so185640318wmp.1
        for <linux-can@vger.kernel.org>; Mon, 07 Nov 2016 06:16:04 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

We have two of these a linux machine:

http://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1

According to http://elinux.org/CAN_Bus , the cards should be
supported. They are getting discovered by the kernel and listed in
ifconfig

$ ifconfig can0

can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00

          UP RUNNING NOARP  MTU:16  Metric:1

          RX packets:17386379 errors:0 dropped:3 overruns:0 frame:0

          TX packets:0 errors:17386373 dropped:3 overruns:0 carrier:3

          collisions:0 txqueuelen:10

          RX bytes:139091032 (139.0 MB)  TX bytes:0 (0.0 B)

          Interrupt:16

And it is possible to bring the interface up:

$ ip link set can0 type can bitrate 500000 $ ifconfig can0 up

However, candump and cansend do not seem to work. Another thing I
noticed is that I have a lot of TX errors.

Somebody any ideas? Any help is appreciated!

Thanks,

-Rein



--------------

Some more information:

$ cat /proc/net/can/version

rev 20120528 abi 9

$ lsmod:

slcan                    16384    1

can_raw              20480    1

can                       45056    1             can_raw

can_dev              24576    1             sja1000

peak_pci             16384    0

sja1000                16384    1             peak_pci

i2c_algo_bit       16384    3             igb,i915,peak_pci
