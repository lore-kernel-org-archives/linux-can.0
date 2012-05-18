From: Abdul Khan <akhan@symboticware.com>
Subject: Strange error with jspy utility
Date: Fri, 18 May 2012 17:50:51 -0400
Message-ID: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60075 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757993Ab2ERVuw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 May 2012 17:50:52 -0400
Received: by dady13 with SMTP id y13so4349744dad.19
        for <linux-can@vger.kernel.org>; Fri, 18 May 2012 14:50:52 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

I am facing strange error with jspy utility provided with j1939-utils
package. I am using can-j1939-utils, iproute2 and
can-j1939-linux-3.3.0-rc6 provided by Kurt.

#./jspy -P -v

OUTPUT:
===================
 can0:20,0feda - !6 [1] 0a
 can1:20,0feda - !6 [1] 0a
 can0:40,0feda - !6 [1] 0a
 can1:40,0feda - !6 [1] 0a
 can0:40,0feda - !6 [1] 0a
 can1:40,0feda - !6 [1] 0a
===================

I did following steps before running the jsr utility.

#./ip link set can0 type can bitrate 125000 triple-sampling on
#./ip link set can1 type can bitrate 125000 triple-sampling on

#./ip link set can0 j1939 on
#./ip link set can1 j1939 on

#./ip addr add dev can0 j1939 0x20
#./ip addr add dev can1 j1939 0x40

#ifconfig can0 up
#ifconfig can1 up

#./jsr can0:20,feda | ./jsr can1:40,feda

Following configuration, I am using on Linux machine

#./uname -a

OUTPUT:
===================
Linux 3.3.0-rc6 #1 SMP Thu May 17 23:13:08 UTC 2012 i686 unknown
===================

#./lsmod

OUTPUT:
===================
Module                  Size  Used by    Not tainted
can_j1939              32312  0
sja1000_isa             3013  0
sja1000                 5344  1 sja1000_isa
can_dev                 5703  1 sja1000
can_raw                 4939  0
can                    20230  2 can_j1939,can_raw
===================

#./dmesg | grep can

OUTPUT:
===================
[    1.289519] rtc_cmos 00:05: RTC can wake from S4
[    1.455446] md: Scanned 0 and added 0 devices.
[    4.561925] can: controller area network core (rev 20090105 abi 8)
[    4.563889] can: raw protocol (rev 20090105)
[    4.601750] sja1000_isa sja1000_isa.0: can0: bit-timing not yet defined
[    4.606770] sja1000_isa sja1000_isa.1: can1: bit-timing not yet defined
[  598.521246] can: SAE J1939
===================

#./ip addr show

OUTPUT:
===================
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
4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can
    can-j1939 0x20 scope link
5: can1: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can
    can-j1939 0x40 scope link
===================

#./ifconfig

OUTPUT:
===================
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:10 Base address:0x600

can1      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:10 Base address:0x680
===================


Thanks in advance.
Abdul.
