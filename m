From: Amr Bekhit <amrbekhit@gmail.com>
Subject: Flooding AT91_CAN peripheral with messages causes it to stop
 receiving any more messages
Date: Tue, 5 Apr 2016 14:10:48 +0100
Message-ID: <CAOLz05quWjxFaxdPcLvybc4YdTmE+qUGhbKUCjji6DGNAUwZ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36566 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314AbcDENLJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Apr 2016 09:11:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id 127so24056720wmu.1
        for <linux-can@vger.kernel.org>; Tue, 05 Apr 2016 06:11:08 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

Hello,

<Sorry for the re-send. I initially sent this as HTML, but then found
out that it was recommended to send all emails as plaintext, hence the
resend>

I working on a board based on the AT91SAM9X25 SoC and I'm using
integrated CAN peripheral. I seem to have run into an issue whereby
sending lots of messages very rapidly in quick succession causes the
CAN peripheral to then stop receiving any messages at all. The only
way to bring it back to a functional state is to bring the network
interface down and then back up again.

The problem can be replicated as follows:

The CAN interface is initialised using:

ip link set can0 type can bitrate 100000 restart-ms 100
ifconfig can0 up

I then start sending CAN messages to the unit using a PCAN-USB adapter
that is plugged into a test Linux PC. After bringing up the CAN
interface on the test PC, messages can be continuously sent using the
following bash script:

#!/bin/bash

while :
do
cansend can0 123#DEADBEEFDEADBEEF
done

After running the script, I check that messages are being received on
the AT91 target by running

ifconfig can0

and checking that the number of received packets is increasing.

I then leave the system running for some time (1.5 hours typically,
may vary), periodically running ifconfig can0 to check to see if new
packets are being received. After a while, the can interface will stop
receiving new packets, even though the test PC is still transmitting
them. Stopping and restarting the CAN transmissions on the test PC
does not solve the problem. The interface does not appear to be in the
bus off state, as shown by running the following:

# ip -details -statistics link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
          bitrate 99950 sample-point 0.739
          tq 435 prop-seg 8 phase-seg1 8 phase-seg2 6 sjw 1
          at91_can: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 2..128 brp-inc 1
          clock 133333333
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    12609768   1576221  5       0       5       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0


# ifconfig can0
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1576221 errors:5 dropped:0 overruns:0 frame:5
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:12609768 (12.0 MiB)  TX bytes:0 (0.0 B)
          Interrupt:40

Using the devmem command line program and a custom python script, I
dumped the contents of the CAN peripheral registers to a file. When
the AT91 CAN peripheral is in the failed state, here is what the
peripheral memory looks like:

Dumping memory from 0xF8004000 to 0xF8004000:
0xF8004000: [00000001] 0000 0000 0000 0000 0000 0000 0000 0001
0xF8004004: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004008: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF800400C: [1F040000] 0001 1111 0000 0100 0000 0000 0000 0000
0xF8004010: [20E000FF] 0010 0000 1110 0000 0000 0000 1111 1111
0xF8004014: [00390775] 0000 0000 0011 1001 0000 0111 0111 0101
0xF8004018: [000090EF] 0000 0000 0000 0000 1001 0000 1110 1111
0xF800401C: [00009C81] 0000 0000 0000 0000 1001 1100 1000 0001
0xF8004020: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004024: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004028: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF80040E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80040E8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF8004200: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
0xF8004204: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004208: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF800420C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF8004210: [01881273] 0000 0001 1000 1000 0001 0010 0111 0011
0xF8004214: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF8004218: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF800421C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF8004220: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
0xF8004224: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004228: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF800422C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF8004230: [018812E6] 0000 0001 1000 1000 0001 0010 1110 0110
0xF8004234: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF8004238: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF800423C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF8004240: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
0xF8004244: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004248: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF800424C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF8004250: [01881359] 0000 0001 1000 1000 0001 0011 0101 1001
0xF8004254: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF8004258: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF800425C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF8004260: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
0xF8004264: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004268: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF800426C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF8004270: [018813CC] 0000 0001 1000 1000 0001 0011 1100 1100
0xF8004274: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF8004278: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF800427C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF8004280: [01000000] 0000 0001 0000 0000 0000 0000 0000 0000
0xF8004284: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF8004288: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF800428C: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF8004290: [0188143F] 0000 0001 1000 1000 0001 0100 0011 1111
0xF8004294: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF8004298: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF800429C: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF80042A0: [02000000] 0000 0010 0000 0000 0000 0000 0000 0000
0xF80042A4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042A8: [048C0000] 0000 0100 1000 1100 0000 0000 0000 0000
0xF80042AC: [00000123] 0000 0000 0000 0000 0000 0001 0010 0011
0xF80042B0: [0188E950] 0000 0001 1000 1000 1110 1001 0101 0000
0xF80042B4: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF80042B8: [EFBEADDE] 1110 1111 1011 1110 1010 1101 1101 1110
0xF80042BC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF80042C0: [03000000] 0000 0011 0000 0000 0000 0000 0000 0000
0xF80042C4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042C8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042CC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042D0: [00800000] 0000 0000 1000 0000 0000 0000 0000 0000
0xF80042D4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042D8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042DC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

0xF80042E0: [03000000] 0000 0011 0000 0000 0000 0000 0000 0000
0xF80042E4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042E8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042EC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042F0: [00800000] 0000 0000 1000 0000 0000 0000 0000 0000
0xF80042F4: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042F8: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000
0xF80042FC: [00000000] 0000 0000 0000 0000 0000 0000 0000 0000

I noticed that the RBSY flag is set, even though there was nothing
transmitted to the CAN bus. All of the message boxes had data inside
ready to be retrieved.

If there are any other test you would like me to carry out, just let me know.

Regards,

Amr Bekhit
