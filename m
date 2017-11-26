From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sun, 26 Nov 2017 13:38:56 +0100
Message-ID: <0a300896-3980-3b4e-ce5a-a3a97de3df55@hartkopp.net>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
 <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:16293 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdKZMjX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Nov 2017 07:39:23 -0500
In-Reply-To: <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kernel@martin.sperl.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

-devicetree
-Mark Rutland
-Rob Herring

On 11/25/2017 03:47 PM, kernel@martin.sperl.org wrote:
>> Unfortunately [PATCH 2/2] only hit the devicetree mailing list but not the linux-can mailing list for the review.
> 
> I have no idea why you have not received it, but I have sent all
> of them to the same  Recipient list!
> 
> I even got a relayed confirmation for all 3 of them:
> 19:35:28.689 2 DEQUEUER [7520159] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org
> 19:35:29.823 2 DEQUEUER [7520154] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org
> 19:35:31.902 2 DEQUEUER [7520160] SMTP(vger.kernel.org)linux-can@vger.kernel.org relayed: relayed via vger.kernel.org
> 
> So they should all have arrived!

In fact patch 2/2 didn't show up on the mailing list archive and in my 
inbox ...

	https://marc.info/?l=linux-can&r=1&b=201711&w=2

Hm ... obviously no sender issue then :-)

>> Seems you improved the SPI handling here. Would it make sense to separate the SPI-related part of the code to a separate C-file so that the existing mcp251x driver can benefit from these improvements too?
> 
> The biggest problem is that the Register-design of the mcp2517fd is totally
> different compared to mcp251x, so most of those “optimizations” for the
> mcp2517 do not apply to the mcp251x (SPI-API wise IMO the mcp2515 is much
>   more efficient - better still when having dedicated gpios for the RX lines
> to avoid having to query the status first via spi (reduces latencies
> and thus reduces packet loss/overflow on a saturated CAN bus).
> 
> I have a spi_async only version of the mcp251x as well (which has been dormant
> for a long time, as the mcp251x stopped showing interrupt stopped issues...).

Interesting. I was not aware that the mcp251x is working reliable under 
heavy loads. I've just seen people providing bcm2835 related hacks/fixes 
to make it run with the Raspi.

>>> (still dropps are observed in the can/network stack).
>>
>> Are you sure drops are taking place in the network layer? Can you give me some more details about this statement?
> Well - when I increase net->stat.rx_dropped there is always a
> dev_warn_ratelimited that comes along. Also rx_errors is increased at the
> same time. And I see the drops counters increase while there are no messages
> in dmesg.

Ok - at least this is not network layer related (the code in 
linux/net/can) but network driver stuff (linux/drivers/net/can/).

> Also note that the driver is only incrementing rx_packets and rx_bytes only
> when netif_rx_ni(skb) is called.
> 
> So the setup is this:
> * raspberry pi 2 with the mcp2517fd
> * beagle bone black
> * 1MHz CAN2.0 bus
> 
> Beagle bone black:
> root@beaglebone:~# cangen can0 -g0.0 -L0 -n 1000000 -p10 -Ii
> 
> This saturates the CAN BUS to 100%
> 
> on the RPI2 I have no consumer (candump or similar) and the module has
> just been reloaded (counters are reset).
> 
> I see the following counters:
> 7: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> 	  bitrate 1000000 sample-point 0.750
> 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
> 	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 40000000
> 	  re-started bus-errors arbit-lost error-warn error-pass bus-off
> 	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>      RX: bytes  packets  errors  dropped overrun mcast
>      0          998774   703     4588    0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
> 
> So you see that packets + dropped > transmitted (1000000).
> 
> In a different setup with 4 bytes of data payload:
> root@beaglebone:~# cangen can0 -g0.0 -L0 -n 10000 -L4 -p10 -Ii
> root@beaglebone:~# cangen can0 -g0.0 -L0 -n 100000 -L4 -p10 -Ii
> 
> I get the following statistics:
> root@rasp2a:~# ip -details -statistics link show can0
> 8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> 	  bitrate 1000000 sample-point 0.750
> 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
> 	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 40000000
> 	  re-started bus-errors arbit-lost error-warn error-pass bus-off
> 	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>      RX: bytes  packets  errors  dropped overrun mcast
>      440000     110000   0       4343    0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
> Here 1 get 100% reception rates (bytes and packets are exactly what they
> are supposed to be) but still 0.1% dropped.
> 
> When CAN FD is configured on the mcp2517 then things look different
> even on a RPI2:
> root@beaglebone:~# cangen can0 -g0.0 -L0 -n 1000000 -L0 -p10 -Ii
> root@rasp2a:~# ip -details -statistics link show can0
> 13: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can <ONE-SHOT,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> 	  bitrate 1000000 sample-point 0.750
> 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
> 	  mcp2517fd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  dbitrate 2000000 dsample-point 0.750
> 	  dtq 25 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1
> 	  mcp2517fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 40000000
> 	  re-started bus-errors arbit-lost error-warn error-pass bus-off
> 	  0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>      RX: bytes  packets  errors  dropped overrun mcast
>      0          999840   3       752028  0       0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
> 
> In this case the number of packets actually lost on the controller is 0.01%
> But the number of dropped packets on the stack is 75%.

Looking into https://marc.info/?l=devicetree&m=151154853410879&w=2 :

+static int mcp2517fd_can_transform_rx_fd(struct spi_device *spi,
+					 struct mcp2517fd_obj_rx *rx)
+{
+	struct mcp2517fd_priv *priv = spi_get_drvdata(spi);
+	struct canfd_frame *frame;
+	struct sk_buff *skb;
+	u32 flags = rx->header.flags;
+
+	/* allocate the skb buffer */
+	skb = alloc_canfd_skb(priv->net, &frame);
+	if (!skb) {
+		dev_err(&spi->dev, "cannot allocate RX skb\n");
+		priv->net->stats.rx_dropped++;
+		return -ENOMEM;

Here the packet is counted as dropped - and the function is finished.

+	}
+
+	mcp2517fd_mcpid_to_canid(rx->header.id, flags, &frame->can_id);
+	frame->flags |= (flags & CAN_OBJ_FLAGS_BRS) ? CANFD_BRS : 0;
+	frame->flags |= (flags & CAN_OBJ_FLAGS_ESI) ? CANFD_ESI : 0;
+
+	frame->len = can_dlc2len((flags & CAN_OBJ_FLAGS_DLC_MASK)
+				 >> CAN_OBJ_FLAGS_DLC_SHIFT);
+
+	memcpy(frame->data, rx->data, frame->len);
+
+	priv->net->stats.rx_packets++;

Here the packet is counted.

+	priv->net->stats.rx_bytes += frame->len;
+
+	can_led_event(priv->net, CAN_LED_EVENT_RX);
+
+	netif_rx_ni(skb);
+
+	return 0;
+}

I wonder how you can send 1.000.000 frames and then count
999.840 + 752.028 = 1.751.868 on the reception side ?!?

> The shorter the interval the lower the dropped count.
> 
> P.s: For the last test-case here the fifo utilization statistics:
> root@rasp2a:~# cat /sys/kernel/debug/mcp2517fd-can0/fifo_usage/* | awk '{ C=C+$1; printf "%8i %s\n",C,$0}’
> Total    Count/fifo
>    384401 384401
>    674306 289905
>    960133 285827
>    990117 29984
>    994351 4234
>    996745 2394
>    997668 923
>    998217 549
>    998593 376
>    998849 256
>    999059 210
>    999240 181
>    999385 145
>    999508 123
>    999604 96
>    999680 76
>    999745 65
>    999797 52
>    999840 43
> root@rasp2a:~# cat /sys/kernel/debug/mcp2517fd-can0/rx/fifo_count
> 19
> root@rasp2a:~# dmesg
> [77843.229423] mcp2517fd spi0.0: RX MAB overflow
> [77856.329824] mcp2517fd spi0.0: RX MAB overflow
> [77883.299221] mcp2517fd spi0.0: RX MAB overflow
> 
> These dmesg lines correspond with the errors (and would also increase “dropped” by 3)
> 

But doesn't this FIFO behavior just show that the SPI connection is too 
slow to be able to cope with the CAN FD traffic?

Best regards,
Oliver
