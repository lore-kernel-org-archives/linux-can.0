From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem using Linux CAN
Date: Thu, 23 Jul 2015 19:26:17 +0200
Message-ID: <55B123B9.1090306@hartkopp.net>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org> <55AFD5DA.7010601@hartkopp.net> <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org> <55AFE356.9070906@hartkopp.net> <0948A186-060F-4A31-8359-755DE78647A0@osdr.org> <928F9D91-F184-4CEF-850E-899A84D444A1@osdr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:37952 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbGWR0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2015 13:26:21 -0400
In-Reply-To: <928F9D91-F184-4CEF-850E-899A84D444A1@osdr.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Hotfilter <thotfilter@osdr.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Tim,

On 23.07.2015 15:13, Tim Hotfilter wrote:
> Kernel version is 3.19.

ok

> Here is the output of ip link show:
> [root@mcu15 ~]# ip -s -d link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 128
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>            bitrate 1000000 sample-point 0.700
>            tq 100 prop-seg 3 phase-seg1 3 phase-seg2 3 sjw 1
>            sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>            clock 50000000
>            re-started bus-errors arbit-lost error-warn error-pass bus-off
>            0          0          0          0          0          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      54816      12451    0       0       0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      5279       108392   0       0       0       0
>
> The Inferface does not really go offline. This interface is also not in an error state. Receive still works: I can see incoming can frames via candump.

ok.

> Only the transmit path stops working.

Hm :-(

> My hardware configuration is quite simple: The control unit is directly connected to a vector can case with termination resistors.
 > I can see incoming frames in CanOe and can also transmit frames.

Ah - you are using CANoe with CANcase ...

So here are some ideas.

1. Try it with 500kbit/s with a sampling-point of 80% on both sides.

2. I had a similar CANoe problem in the past. Please try to add *another* CAN 
node which can ACK your sent frames. E.g. connect one of the other CAN 
interfaces of your Xilinx board to the existing bus.

3. The error state handling has changed in 3.19. For a test you might revert 
this commit: 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=215db1856e8313ef8a1d9b64346dc261570012a6

Regards,
Oliver

