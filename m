From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued (was
 CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Fri, 25 Oct 2013 14:59:20 +0200
Message-ID: <526A6B28.4040800@kkmicro.cz>
References: <l4b8eg$40b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.aquastore.cz ([37.157.193.242]:40348 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab3JYM72 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Oct 2013 08:59:28 -0400
Received: from localhost (unknown [127.0.0.1])
	by server.aquastore.cz (Postfix) with ESMTP id B38ADABC0D
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2013 12:59:25 +0000 (UTC)
Received: from server.aquastore.cz ([127.0.0.1])
	by localhost (server.aquastore.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE6mTHCWkYLd for <linux-can@vger.kernel.org>;
	Fri, 25 Oct 2013 14:59:22 +0200 (CEST)
Received: from [127.0.0.1] (unknown [213.191.105.242])
	by server.aquastore.cz (Postfix) with ESMTPSA id DC5D5ABBF7
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2013 14:59:22 +0200 (CEST)
In-Reply-To: <l4b8eg$40b$1@ger.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 24.10.2013 15:48, Martin Kozusky napsal(a):
> Hello,
> after more than year I'm back with CAN fifo overrun problems on i.MX25 board.
> (it was good enough earlier, if some frames were lost, but not this time)
>
> I have 2 flexcan interfaces, each receiving around 1100 msgs/s (situation is a little better if I use just one iface, but I need both)
> I just configure them and then run:
>
> I=0; while [ $I -le 20 ]; do dd if=/dev/zero of=/mnt/mmcblk0p1/test bs=512 count=200; sync; sleep 1; I=$(($I+1)); done
> (simulate writing to SDcard with 100KB blocks in 1 sec intervals)
>
> and start sending data from another device.
>
> I am not running any other program (like candump etc) to read from CAN.
>
> this is what is shown after I finish sending 35777 packets (both interfaces now connected to same bus so they should receive same data) with ip -d -s link show can0/1
>
> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
>      link/can
>      can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>      bitrate 250000 sample-point 0.857
>      tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>      flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>      clock 66500000
>      re-started bus-errors arbit-lost error-warn error-pass bus-off
>      0          0          0          1          1          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      151769     19000    1699    0       1699    0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
> root@vmx25 /opt/waytracer$ /root/utils/ip -d -s link show can1
> 3: can1: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
>      link/can
>      can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>      bitrate 250000 sample-point 0.857
>      tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>      flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>      clock 66500000
>      re-started bus-errors arbit-lost error-warn error-pass bus-off
>      0          0          0          0          0          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      157377     19696    2664    0       2664    0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
>
>
> With just one iface used:
>
> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
>      link/can
>      can <LISTEN-ONLY> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>      bitrate 250000 sample-point 0.857
>      tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>      flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>      clock 66500000
>      re-started bus-errors arbit-lost error-warn error-pass bus-off
>      0          0          0          1          1          0
>      RX: bytes  packets  errors  dropped overrun mcast
>      233277     29201    1483    0       1483    0
>      TX: bytes  packets  errors  dropped carrier collsns
>      0          0        0       0       0       0
>
>
> Too many packets are lost.
>
> I tried to play with FLEXCAN_NAPI_WEIGHT (quota for napi) and that didn't hepl too much, if I put it too high then the system response was slow and packets still lost, also tried to change priority of CAN interrupts with (don't know if correctly)
>    // imx_irq_set_priority(43,14);
>    // imx_irq_set_priority(44,14);
>
> But it didn't help either.
>
>
> Does anybody have any idea how not to lose any packets? :)


Hello,
I tried to disable
//netif_receive_skb(skb); in  flexcan_read_frame() and other functions so that data is not processed further in system

It didn't help.
So I tried to put time_start=ktime_get_real() at the begining of flexcan_read_frame(), then time_stop=ktime_get_real(); at the end and add their difference to the global variable time_total+=time_stop-time_start;
I divided this time_total by rx_packets count at flexcan_chip_stop and wrote with dev_info into log (variables were initialized in flexcan_chi_start, so I could just do ifconfig can0 up/down and reset those counters and write them to log), so now I had average time spent int flexcan_read_frame.
This time it was around 100usec! just with one CAN used, if both were connected, it was more than twice. And many CAN frames were lost.

So I tried to disable
     /*
         skb = alloc_can_skb(dev, &cf);
         if (unlikely(!skb)) {
                 stats->rx_dropped++;
                 return 0;
         }
      */
and made "struct can_frame cf" (not pointer, so that I can use it in flexcan_read_fifo call)
And tried to send data again.
Now - average time in flexcan_read_frame was not 100usec, but just 2 usec! 50x less ...  no CAN frame was lost, even if I was using both CAN interfaces, each getting over 1100 msgs/sec and writing 100KB data to SD card.

So I am asking - how to make this alloc_can_skb faster (or is there any alternative)? Or if there is another way how to get data to user?

Thank you,
Martin

>
> Thanks,
> Martin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

