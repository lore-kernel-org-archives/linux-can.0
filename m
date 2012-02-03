From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] CAN Data Transfer not happening at 1Mbps
Date: Fri, 03 Feb 2012 09:07:19 +0100
Message-ID: <4F2B95B7.5070507@grandegger.com>
References: <4ED62A07621E9C41B8CB2F608655EF45053759D1@POCITMSEXMB02.LntUniverse.com> <4F2AA2B4.2090906@grandegger.com> <4ED62A07621E9C41B8CB2F608655EF4505375D5A@POCITMSEXMB02.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46225 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab2BCIHZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 03:07:25 -0500
In-Reply-To: <4ED62A07621E9C41B8CB2F608655EF4505375D5A@POCITMSEXMB02.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikhil Kamath <Nikhil.Kamath@lnties.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 02/03/2012 05:11 AM, Nikhil Kamath wrote:
> Hi Wolfgang,
> Below are the details you asked for:
> 
> -This means you are not using a mainline kernel, right? Are you using Freescale's ltib linux-2.6.35 tree?
> Yes , I am not using a mainline kernel , it's from the Freescale's LTIB tree.
> 
> 
> - From what kernel version is the Flexcan driver derived?
> I integrated the FlexCAN driver present in linux-2.6.38 mainline Kernel. I am not using the FlexCAN driver given by Freescale since it had issues , for e.g. I used to get the following error -RTNETLINK answers: Operation not supported.

OK.

> - What does "dmesg" report when you load the driver?
> flexcan netdevice driver
> flexcan flexcan.0: device registered (reg_base=c8978000, irq=43)
> flexcan flexcan.0: writing ctrl=0x25292004
> 
> -What does "ip -d -s link show can0" report after an unsuccessful
>   transfer?
> root@freescale ~$ ip -d -s link show can0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>     link/can
>     can state ERROR-PASSIVE restart-ms 0
>     bitrate 1007575 sample-point 0.727
>     tq 90 prop-seg 3 phase-seg1 4 phase-seg2 3 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 66500000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          1          1          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     19         5        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     2          0        0       0       0       0

The CAN controller has reached the error passive state. It seems that
there are electrical problems on the CAN bus, e.g. improper termination
or bit-timing.

> -What does "candump -e any,0:0,#FFFFFFFF" report while sending
>   messages?
> I received a message saying invalid option for 'e' in the above command, I tried using  'L' option instead to check if something gets logged , but at 1 Mbps logging was not happening.

Your version of candump seems to be quite old. Just try without "-e" but
the statistics above already points to the problem.

> Further , this is the log I got when I executed the following command -
> root@freescale ~$ ip link set can0 up type can bitrate 1000000
> flexcan flexcan.0: bitrate error 0.7%

That might make the trouble. The built-in algorithm to determine the
bit-timing parameters does not work well for your clock frequency. Try
to add "sjw=4" to the ip command.

Wolfgang.

