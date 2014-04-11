From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 00/21] can: c_can: Another pile of fixes and improvements
Date: Fri, 11 Apr 2014 08:13:09 -0000
Message-ID: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52357 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbaDKIM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:12:59 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Changes since V1:

 - Slightly modified version of the interrupt reduction patch
 - Included the fix for PCH / C_CAN
 - Lockless XMIT path
 - Further reduction of register access
 - Add the missing can.type setup in c_can_pci.c
 - A pile of code cleanups.

It would be nice to reduce the register access some more by relying
completely on the status interrupt, but it turned out that the TX/RXOK
is not reliable enough. So we need to invalidate the message objects
in the tx softirq handling.

But the overall change of this series is that the I/O load gets
reduced by about 45% according to perf top. Though that PCH thing
sucks. The beaglebone manages to almost saturate the bus with short
packets at 1Mbit while PCH fails miserably and thats solely related to
the miserable I/O performance.

time cangen can0 -g0 -p10 -I5A5 -L0 -x -n 1000000 

arm: real	0m51.510s 	I/O read:  ~6%  I/O write: 1.5%  ~3.5s
x86: real	1m48.533s	I/O read: ~29%  I/O write: 0.8%  ~32 s!!

That's both with HW loopback on, as my PCH does not have a
tranceiver. Granted the C_CAN in the PCH needs the double IF transfer
to prevent the message loss versus the D_CAN in the ARM chip, but even
that taken into account makes a whopping 16s per 1M messages vs. 3.5s
on ARM.

w/o loopback the arm I/O read load drops to ~3.5% on the sender side
and ~5.5% on the receiver side. The time drops to 50.5s on the
transmit side if we do not have to get all the RX packets from HW
loopback. On TX we have a ~10us large gap every 16 packets which is
caused by the queue stall as we have to wait for the last
packet in the "FIFO" to be transferred. 

It seems there is a reason why the ATOM perf events do not expose the
stalled cpu cycles. But it's easy to figure out. You can compare the
CAN load case with some other scenario which has 100% CPU utilization
by running 

# perf stat -a sleep 60

The interesting part is: insns per cycle

CAN:	 0.23  insns per cycle
Other:	 0.53  insns per cycle

I don't have comparison numbers for ARM due to not supported perf
events, but the perf top numbers and the transfer performance tell a
clear story.

There might be room for a few improvements, but I'm running out of
cycles and I really want to get the IF3 DMA feature functional on the
TI chips, but that seems to be an equally tedious reverse engineering
problem as the rest of this.

Thanks,

        tglx

---------
 Kconfig     |    7 
 c_can.c     |  662 +++++++++++++++++++++++++++---------------------------------
 c_can.h     |   21 -
 c_can_pci.c |    2 
 4 files changed, 320 insertions(+), 372 deletions(-)



