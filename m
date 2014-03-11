From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 08:05:08 +0100
Message-ID: <531EB5A4.1090302@hartkopp.net>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:59478 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaCKHFO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 03:05:14 -0400
In-Reply-To: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

Hi Austin,



On 11.03.2014 01:22, Austin Schuh wrote:

> $ Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1

Oh, one of these -rt kernels again %-)

> Mar 10 16:49:12 vpc3 kernel: [356480.638351] Dead loop on virtual device
> vcan2, fix it urgently!

The vcan driver usually does not set the IFF_ECHO flag:
> 
> austin[4262] vpc3 ~
> $ ifconfig vcan2
> vcan2     Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
                            ^^
Which would be indicated here then.

Therefore the 'shortcut' in af_can.c is used to provide the echo:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/af_can.c#n283

which increases performance but may lead to funny effects as the sending
process leads to a reception event which is probably already handled by the
receiver when the write() of the sender returns.

Two things I would suggest:

1. Let the vcan really handle the frames by enabling IFF_ECHO
2. Add a queue (queue length != 0) to the vcan interface

For 1: Insert the vcan module with the parameter echo=1, e.g.

# rmmod vcan
# modprobe vcan echo=1
# ip link add type vcan
# ip link show vcan0
26: vcan0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default 
    link/can 

And see if this already fixes your problem ('ECHO' is enabled here).

For 2: Add a queue length to your vcan with

# ip link set vcan0 txqueuelen 10
# ip link show vcan0
26: vcan0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can 

This urges the network subsystem to used the normal packet flow, as a queue
length of zero is only feasible for software devices like loopback / vcan ...

Please give a feedback if it solves the problem in your -rt kernel.

Best regards,
Oliver

