From: kernel@martin.sperl.org
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sat, 25 Nov 2017 15:47:58 +0100
Message-ID: <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:41440
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdKYOr7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Nov 2017 09:47:59 -0500
In-Reply-To: <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hi Oliver!

> On 25.11.2017, at 13:03, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
> Hello Martin,
> 
> thanks for the contribution!
> 
> Unfortunately [PATCH 2/2] only hit the devicetree mailing list but not the linux-can mailing list for the review.

I have no idea why you have not received it, but I have sent all
of them to the same  Recipient list!

I even got a relayed confirmation for all 3 of them:
19:35:28.689 2 DEQUEUER [7520159] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org
19:35:29.823 2 DEQUEUER [7520154] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org
19:35:31.902 2 DEQUEUER [7520160] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org

So they should all have arrived!

> 
> Btw. I already have two questions from the description:
> 
> On 11/24/2017 07:35 PM, kernel@martin.sperl.org wrote:
> 
> (..)
> 
>> The driver has been heavily optimized so that it can handle
>> a 100% utilized 1MHz Can-bus (with 11 bit can frames with DLC=0)
>> even on less powerfull SOCs like the raspberry pi 1 without
>> dropping frames due to driver/spi latencies
> 
> (..)
> 
> > The driver implements a lock-less design for transmissions
> > making use instead of prepared spi messages submitted via spi_async
> > for transmission in the start_xmit_start code without requireing
> > an extra workqueue and the corresponding latencies.
> 
> Seems you improved the SPI handling here. Would it make sense to separate the SPI-related part of the code to a separate C-file so that the existing mcp251x driver can benefit from these improvements too?

The biggest problem is that the Register-design of the mcp2517fd is totally 
different compared to mcp251x, so most of those “optimizations” for the 
mcp2517 do not apply to the mcp251x (SPI-API wise IMO the mcp2515 is much
 more efficient - better still when having dedicated gpios for the RX lines
to avoid having to query the status first via spi (reduces latencies
and thus reduces packet loss/overflow on a saturated CAN bus).

I have a spi_async only version of the mcp251x as well (which has been dormant
for a long time, as the mcp251x stopped showing interrupt stopped issues...).

> 
>> (still dropps are observed in the can/network stack).
> 
> Are you sure drops are taking place in the network layer? Can you give me some more details about this statement?
Well - when I increase net->stat.rx_dropped there is always a 
dev_warn_ratelimited that comes along. Also rx_errors is increased at the 
same time. And I see the drops counters increase while there are no messages
in dmesg.

Also note that the driver is only incrementing rx_packets and rx_bytes only 
when netif_rx_ni(skb) is called.

So the setup is this:
* raspberry pi 2 with the mcp2517fd
* beagle bone black
* 1MHz CAN2.0 bus

Beagle bone black:
root@beaglebone:~# cangen can0 -g0.0 -L0 -n 1000000 -p10 -Ii

This saturates the CAN BUS to 100%

on the RPI2 I have no consumer (candump or similar) and the module has
just been reloaded (counters are reset).

I see the following counters:
7: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
	  bitrate 1000000 sample-point 0.750
	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
	  clock 40000000
	  re-started bus-errors arbit-lost error-warn error-pass bus-off
	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped overrun mcast
    0          998774   703     4588    0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

So you see that packets + dropped > transmitted (1000000).

In a different setup with 4 bytes of data payload:
root@beaglebone:~# cangen can0 -g0.0 -L0 -n 10000 -L4 -p10 -Ii
root@beaglebone:~# cangen can0 -g0.0 -L0 -n 100000 -L4 -p10 -Ii

I get the following statistics:
root@rasp2a:~# ip -details -statistics link show can0
8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
	  bitrate 1000000 sample-point 0.750
	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
	  clock 40000000
	  re-started bus-errors arbit-lost error-warn error-pass bus-off
	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped overrun mcast
    440000     110000   0       4343    0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0
Here 1 get 100% reception rates (bytes and packets are exactly what they 
are supposed to be) but still 0.1% dropped.

When CAN FD is configured on the mcp2517 then things look different
even on a RPI2:
root@beaglebone:~# cangen can0 -g0.0 -L0 -n 1000000 -L0 -p10 -Ii
root@rasp2a:~# ip -details -statistics link show can0
13: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can <ONE-SHOT,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
	  bitrate 1000000 sample-point 0.750
	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
	  dbitrate 2000000 dsample-point 0.750
	  dtq 25 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1
	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
	  clock 40000000
	  re-started bus-errors arbit-lost error-warn error-pass bus-off
	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped overrun mcast
    0          999840   3       752028  0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

In this case the number of packets actually lost on the controller is 0.01%
But the number of dropped packets on the stack is 75%.

The shorter the interval the lower the dropped count.

Ciao,
	Martin

P.s: For the last test-case here the fifo utilization statistics:
root@rasp2a:~# cat /sys/kernel/debug/mcp2517fd-can0/fifo_usage/* | awk '{ C=C+$1; printf "%8i %s\n",C,$0}’
Total    Count/fifo
  384401 384401
  674306 289905
  960133 285827
  990117 29984
  994351 4234
  996745 2394
  997668 923
  998217 549
  998593 376
  998849 256
  999059 210
  999240 181
  999385 145
  999508 123
  999604 96
  999680 76
  999745 65
  999797 52
  999840 43
root@rasp2a:~# cat /sys/kernel/debug/mcp2517fd-can0/rx/fifo_count
19
root@rasp2a:~# dmesg
[77843.229423] mcp2517fd spi0.0: RX MAB overflow
[77856.329824] mcp2517fd spi0.0: RX MAB overflow
[77883.299221] mcp2517fd spi0.0: RX MAB overflow

These dmesg lines correspond with the errors (and would also increase “dropped” by 3)

