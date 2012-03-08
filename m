From: Gianluca <gmattiroli@midsx.ch>
Subject: socketCAN mcp2515 - rx buffer overflow
Date: Thu, 8 Mar 2012 13:09:29 +0000 (UTC)
Message-ID: <loom.20120308T140608-84@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53324 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab2CHNUO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Mar 2012 08:20:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1S5dGF-0002D5-Ay
	for linux-can@vger.kernel.org; Thu, 08 Mar 2012 14:20:03 +0100
Received: from 62-48-103-138.adsl.ticino.com ([62-48-103-138.adsl.ticino.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Mar 2012 14:20:03 +0100
Received: from gmattiroli by 62-48-103-138.adsl.ticino.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Mar 2012 14:20:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,
I'm using an embedded Armadeus evaluation board - apf51 - with the mcp2515 CAN 
controller (via spi) and linux 2.6.38.8.
As a preliminar test I tried to dump all the traffic on our CANbus running at 
500Kb/s. 
Apparently, everything works fine, I can see messages being captured without 
problems.
But if I enable the error reporting I can see different ERRORFRAME messages to 
be reported ('rx buffer overflow'). 

This is how I configure the interface:

modprobe can
modprobe can_dev
modprobe can_raw
modprobe mcp251x
ip link set can0 up type can bitrate 500000
ip link set can0 txqueuelen 20

This is the operation detail:

$ ip -details -statistics link show can0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 20
    link/can 
    can state ERROR-ACTIVE restart-ms 0 
    bitrate 500000 sample-point 0.875 
    tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0         
    RX: bytes  packets  errors  dropped overrun mcast   
    13086      2308     213     0       213     0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      

dmesg output:

can: controller area network core (rev 20090105 abi 8)
NET: Registered protocol family 29
CAN device driver interface
can: raw protocol (rev 20090105)
PM: Adding info for No Bus:can0
mcp251x spi1.0: probed
mcp251x spi1.0: CNF: 0x00 0xb5 0x01
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
eth0: no IPv6 routers present

This is an example of candump results:

 candump -ta -d -e any,0:0,#FFFFFFFF
 (125.351573)  can0     15004  [2] 00 00
 (126.193767)  can0    400060  [4] FF FF 00 00
 (126.194163)  can0    600060  [4] FF FF 00 00
 (126.194469)  can0  20000004  [8] 00 01 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-overflow}
 (126.194743)  can0    E00060  [4] FF FF 00 00
 (126.195018)  can0   1200060  [4] FF FF 00 00
 (126.195323)  can0   1800060  [4] FF FF 00 00
 (126.195567)  can0  20000004  [8] 00 01 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-overflow}
 (126.195842)  can0      5067  [6] 01 00 00 00 00 00
 (126.196086)  can0   1A00060  [4] FF FF 00 00
 (126.196361)  can0  20000004  [8] 00 01 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-overflow}
 (126.196635)  can0    200060  [4] FF FF 00 00
 (126.196818)  can0      D067  [6] 01 00 00 00 00 00
 (126.197093)  can0      F066  [6] 01 00 00 00 00 00
 (126.197337)  can0  20000004  [8] 00 01 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-overflow}
 (126.197673)  can0      7067  [6] 01 00 00 00 00 00
 (126.197978)  can0      B067  [6] 01 00 00 00 00 00
 (126.198253)  can0     19066  [6] 01 00 00 00 00 00
 (126.198558)  can0     1B066  [6] 01 00 00 00 00 00
 (126.198894)  can0     11066  [6] 01 00 00 00 00 00
 (126.199168)  can0      3067  [6] 01 00 00 00 00 00
 (126.199443)  can0  20000004  [8] 00 01 00 00 00 00 00 00   ERRORFRAME
        controller-problem{rx-overflow}
 (126.199718)  can0     17066  [6] 01 00 00 00 00 00
 (126.199931)  can0     1D066  [6] 01 00 00 00 00 00
 (126.200328)  can0     1F066  [6] 01 00 00 00 00 00
^C$ 

Increasing the buffer size was not possible:

$ candump -r 200000 -ta -d -e any,0:0,#FFFFFFFF
The socket receive buffer size was adjusted due to /proc/sys/net/core/rmem_max.

$ cat /proc/sys/net/core/rmem_max 
108544

Thanks in advance,
Gianluca

