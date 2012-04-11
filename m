From: Krzysztof Witkowski <Krzysztof.Witkowski@mobile.put.edu.pl>
Subject: Re: CPU load inhibits CAN interrupts
Date: Wed, 11 Apr 2012 11:40:31 +0200
Message-ID: <4F85518F.9020305@mobile.put.edu.pl>
References: <4F84464E.7030403@mobile.put.edu.pl> <4F847253.5080507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from seawolf.cs.put.poznan.pl ([150.254.23.147]:42000 "EHLO
	seawolf.cs.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2DKLke (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 07:40:34 -0400
In-Reply-To: <4F847253.5080507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

W dniu 4/10/2012 7:48 PM, Wolfgang Grandegger pisze:
>> However, if I generate artificial CPU load with stress command:
>>
>>     chrt --idle 0 stress -c 2
>
> What does "-c 2" do? My "chrt" command does not have that option.

It is an option for stress command:
-c, --cpu N
               spawn N workers spinning on sqrt()

>> Why CPU load inhibits hardware interrupts and what can be done about it?
>
> Hm, what does "ip -d -s can0" report while you are producing CPU load
> with the stress command above.

# ip -s -d link show can0

4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT qlen 10
     link/can
     can state ERROR-PASSIVE (berr-counter tx 0 rx 128) restart-ms 100
     bitrate 1000000 sample-point 0.750
     tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 2
     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
     clock 8000000
     re-started bus-errors arbit-lost error-warn error-pass bus-off
     0          0          0          1          1          0
     RX: bytes  packets  errors  dropped overrun mcast
     728        91       0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0


It can occasionally deliver packets, but the rate is no more than ~2 
packets/second.
