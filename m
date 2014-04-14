From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [patch V2 00/21] can: c_can: Another pile of fixes and improvements
Date: Mon, 14 Apr 2014 10:38:04 +0200
Message-ID: <2227317.E2ytjs4Wd3@ws-stein>
References: <20140411080547.845836199@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54950 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbaDNIjQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Apr 2014 04:39:16 -0400
In-Reply-To: <20140411080547.845836199@linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

On Friday 11 April 2014 08:13:09, Thomas Gleixner wrote:
> Changes since V1:
> 
>  - Slightly modified version of the interrupt reduction patch
>  - Included the fix for PCH / C_CAN
>  - Lockless XMIT path
>  - Further reduction of register access
>  - Add the missing can.type setup in c_can_pci.c
>  - A pile of code cleanups.
> 
> It would be nice to reduce the register access some more by relying
> completely on the status interrupt, but it turned out that the TX/RXOK
> is not reliable enough. So we need to invalidate the message objects
> in the tx softirq handling.
> 
> But the overall change of this series is that the I/O load gets
> reduced by about 45% according to perf top. Though that PCH thing
> sucks. The beaglebone manages to almost saturate the bus with short
> packets at 1Mbit while PCH fails miserably and thats solely related to
> the miserable I/O performance.
> 
> time cangen can0 -g0 -p10 -I5A5 -L0 -x -n 1000000 
> 
> arm: real	0m51.510s 	I/O read:  ~6%  I/O write: 1.5%  ~3.5s
> x86: real	1m48.533s	I/O read: ~29%  I/O write: 0.8%  ~32 s!!
> 
> That's both with HW loopback on, as my PCH does not have a
> tranceiver. Granted the C_CAN in the PCH needs the double IF transfer
> to prevent the message loss versus the D_CAN in the ARM chip, but even
> that taken into account makes a whopping 16s per 1M messages vs. 3.5s
> on ARM.
> 
> w/o loopback the arm I/O read load drops to ~3.5% on the sender side
> and ~5.5% on the receiver side. The time drops to 50.5s on the
> transmit side if we do not have to get all the RX packets from HW
> loopback. On TX we have a ~10us large gap every 16 packets which is
> caused by the queue stall as we have to wait for the last
> packet in the "FIFO" to be transferred. 
> 
> It seems there is a reason why the ATOM perf events do not expose the
> stalled cpu cycles. But it's easy to figure out. You can compare the
> CAN load case with some other scenario which has 100% CPU utilization
> by running 
> 
> # perf stat -a sleep 60
> 
> The interesting part is: insns per cycle
> 
> CAN:	 0.23  insns per cycle
> Other:	 0.53  insns per cycle
> 
> I don't have comparison numbers for ARM due to not supported perf
> events, but the perf top numbers and the transfer performance tell a
> clear story.
> 
> There might be room for a few improvements, but I'm running out of
> cycles and I really want to get the IF3 DMA feature functional on the
> TI chips, but that seems to be an equally tedious reverse engineering
> problem as the rest of this.

Run this patchset on top of linux-can-fixes-for-3.15-20140401 on idle system and with running iperf and I2C:
idle: 10 runs with 2 x 250'000 frames each, _no_ losts or swaps at all
load: 10 runs with 2 x 250'000 frames each, _no_ losts or swaps at all
\o/

CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING is not set. Maybe we can drop it now?

Despite that:
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Thanks a lot and best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

