From: Rostislav Lisovy <lisovy@gmail.com>
Subject: Re: Fwd: Using TC from iproute, unable to match canid
Date: Mon, 25 Nov 2013 18:37:07 +0100
Message-ID: <1385401027.16954.11.camel@umadbro>
References: <201311251757.12012.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:47149 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab3KYRhM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 12:37:12 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so2090426bkb.6
        for <linux-can@vger.kernel.org>; Mon, 25 Nov 2013 09:37:10 -0800 (PST)
In-Reply-To: <201311251757.12012.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Karsten Aalykke Stenzhorn <Karsten.Stenzhorn@marel.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Hello;
I tried the example from the PDF and it worked for me. I am using Ubuntu
12.10 (Linux kernel 3.5.0-43-generic) with x86 CPU (32-bit Little
Endian).
You have to be careful, that it is necessary to byte-swap the ID used
with the 'u32 match' according to the architecture used.
For CAN ID 0x123 on LE the matching rule is 0x23010000, on BE it should
be 0x00000123.
You can also try to set the mask only for significant bits in the CAN ID
(i.e. 0xff070000 for LE, or 0x000007ff for BE).

The exact commands I used:

modprobe can
modprobe can-raw
modprobe vcan
ip link add dev vcan0 type vcan
ip link set vcan0 up
ifconfig -a

> vcan0     Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
>           NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0 
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

tc qdisc add dev vcan0 root handle 1: prio bands 5

tc -s class show dev vcan0
> class prio 1:1 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:2 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:3 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:4 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:5 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 

tc filter add dev vcan0 parent 1:0 prio 1 u32 match u32 0x01000000
0xffffffff at 0 flowid 1:1

cangen -I 0x2 -L 1 vcan0 -n 22 -g 1
tc -s class show dev vcan0
> class prio 1:1 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:2 parent 1: 
>  Sent 352 bytes 22 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:3 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:4 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:5 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 

cangen -I 0x1 -L 1 vcan0 -n 11 -g 1
> class prio 1:1 parent 1: 
>  Sent 176 bytes 11 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:2 parent 1: 
>  Sent 352 bytes 22 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:3 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:4 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 
> class prio 1:5 parent 1: 
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
>  backlog 0b 0p requeues 0 


Best regards;
Rostislav Lisovy



On Mon, 2013-11-25 at 17:57 +0100, Pavel Pisa wrote:
> 
> ----------  Forwarded Message  ----------
> 
> Subject: Using TC from iproute, unable to match canid
> Date: Monday 25 of November 2013, 17:49:02
> From: Karsten Aalykke Stenzhorn <Karsten.Stenzhorn@marel.com>
> To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> 
> I'm trying to use tc from iproute2 to prioritize packets sent to a canbus.
> 
> Before doing so I read this guide about the 
> issue: http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
> Even using the exact examples from that pdf, I'm not able get any of the 
> filters to get a match. My current version of kernel and tc only allows me to 
> use the u32 match option.
> 
> Tried (both big and little endian):
> 
> tc filter add dev can0 parent 1:0 prio 1 u32 match u32 0x01000000 0xffffffff 
> at 0 flowid 1:1
> 
> and also:
> 
> tc filter add dev can0 parent 1:0 prio 1 u32 match u8 0x01 0xff at 4 flowid 
> 1:1
> 
> Sending packets to fit those filters does not trigger a match. I'm a bit 
> confused why exact examples from the guide does not seem to work.
> 
> Any hints or experience on this would be much appreciated.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -------------------------------------------------------


