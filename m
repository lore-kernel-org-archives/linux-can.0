From: Tim Hotfilter <thotfilter@osdr.org>
Subject: Re: Problem using Linux CAN
Date: Thu, 23 Jul 2015 15:13:32 +0200
Message-ID: <928F9D91-F184-4CEF-850E-899A84D444A1@osdr.org>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org> <55AFD5DA.7010601@hartkopp.net> <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org> <55AFE356.9070906@hartkopp.net> <0948A186-060F-4A31-8359-755DE78647A0@osdr.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dd20724.kasserver.com ([85.13.140.203]:58809 "EHLO
	dd20724.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbbGWNNd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2015 09:13:33 -0400
In-Reply-To: <0948A186-060F-4A31-8359-755DE78647A0@osdr.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Kernel version is 3.19.

Here is the output of ip link show:
[root@mcu15 ~]# ip -s -d link show can1
3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 128
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
          bitrate 1000000 sample-point 0.700
          tq 100 prop-seg 3 phase-seg1 3 phase-seg2 3 sjw 1
          sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
          clock 50000000
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    54816      12451    0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    5279       108392   0       0       0       0

The Inferface does not really go offline. This interface is also not in an error state. Receive still works: I can see incoming can frames via candump. Only the transmit path stops working.
My hardware configuration is quite simple: The control unit is directly connected to a vector can case with termination resistors. I can see incoming frames in CanOe and can also transmit frames. 

Regards,
Tim

> On 23 Jul 2015, at 15:12, Tim Hotfilter <thotfilter@osdr.org> wrote:
> 
> Hi Oliver,
> 
> Kernel version is 3.19.
> 
> Here is the output of ip link show:
> [root@mcu15 ~]# ip -s -d link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 128
>     link/can  promiscuity 0
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>           bitrate 1000000 sample-point 0.700
>           tq 100 prop-seg 3 phase-seg1 3 phase-seg2 3 sjw 1
>           sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>           clock 50000000
>           re-started bus-errors arbit-lost error-warn error-pass bus-off
>           0          0          0          0          0          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     54816      12451    0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     5279       108392   0       0       0       0
> 
> The Inferface does not really go offline. This interface is also not in an error state. Receive still works: I can see incoming can frames via candump. Only the transmit path stops working.
> My hardware configuration is quite simple: The control unit is directly connected to a vector can case with termination resistors. I can see incoming frames in CanOe and can also transmit frames. 
> 
> Regards,
> Tim
> 
> 
>> On 22 Jul 2015, at 20:39, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> 
>> On 22.07.2015 19:52, Tim Hotfilter wrote:
>> 
>>> I am using a kernel image from Xilinx git hub
>> 
>> This is 4.0 then, right?
>> 
>>> and cangen to generate static load. I get this error as result in cangen after a while.
>> 
>> Can you send the output from
>> 
>> ip -details link show can0 (or whatever canX got stuck)
>> ip -stat link show can0 (or whatever canX got stuck)
>> 
>> just to see why the CAN interface gets offline.
>> 
>> Do you have a proper CAN setup (with CAN transceivers, real wires, 2x 120 ohms termination, etc) ?
>> 
>> Sending CAN frames only works when there's a second/different node with the same bitrate acknowledging the sent frame. Sending without cabling/termination always leads to CAN controllers that feel sad :-)
>> 
>> Regards,
>> Oliver
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

