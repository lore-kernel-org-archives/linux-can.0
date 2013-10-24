From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: CAN messages being lost on i.MX25 with flexcan - continued (was CAN
 messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Thu, 24 Oct 2013 15:48:08 +0200
Message-ID: <l4b8eg$40b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55468 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab3JXNsW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 24 Oct 2013 09:48:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VZLGu-0002g2-S7
	for linux-can@vger.kernel.org; Thu, 24 Oct 2013 15:48:20 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 24 Oct 2013 15:48:20 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 24 Oct 2013 15:48:20 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
after more than year I'm back with CAN fifo overrun problems on i.MX25 board.
(it was good enough earlier, if some frames were lost, but not this time)

I have 2 flexcan interfaces, each receiving around 1100 msgs/s (situation is a little better if I use just one iface, but I need both)
I just configure them and then run:

I=0; while [ $I -le 20 ]; do dd if=/dev/zero of=/mnt/mmcblk0p1/test bs=512 count=200; sync; sleep 1; I=$(($I+1)); done
(simulate writing to SDcard with 100KB blocks in 1 sec intervals)

and start sending data from another device.

I am not running any other program (like candump etc) to read from CAN.

this is what is shown after I finish sending 35777 packets (both interfaces now connected to same bus so they should receive same data) with ip -d -s link show can0/1

2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
     link/can
     can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
     bitrate 250000 sample-point 0.857
     tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
     clock 66500000
     re-started bus-errors arbit-lost error-warn error-pass bus-off
     0          0          0          1          1          0
     RX: bytes  packets  errors  dropped overrun mcast
     151769     19000    1699    0       1699    0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0
root@vmx25 /opt/waytracer$ /root/utils/ip -d -s link show can1
3: can1: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
     link/can
     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
     bitrate 250000 sample-point 0.857
     tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
     clock 66500000
     re-started bus-errors arbit-lost error-warn error-pass bus-off
     0          0          0          0          0          0
     RX: bytes  packets  errors  dropped overrun mcast
     157377     19696    2664    0       2664    0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0


With just one iface used:

2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
     link/can
     can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
     bitrate 250000 sample-point 0.857
     tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
     clock 66500000
     re-started bus-errors arbit-lost error-warn error-pass bus-off
     0          0          0          1          1          0
     RX: bytes  packets  errors  dropped overrun mcast
     233277     29201    1483    0       1483    0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0


Too many packets are lost.

I tried to play with FLEXCAN_NAPI_WEIGHT (quota for napi) and that didn't hepl too much, if I put it too high then the system response was slow and packets still lost, also tried to change priority of CAN interrupts with (don't know if correctly)
   // imx_irq_set_priority(43,14);
   // imx_irq_set_priority(44,14);

But it didn't help either.


Does anybody have any idea how not to lose any packets? :)


Thanks,
Martin

