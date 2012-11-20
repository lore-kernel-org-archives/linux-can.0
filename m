From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Tue, 20 Nov 2012 19:59:42 +0100
Message-ID: <50ABD31E.9010008@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <loom.20121115T165949-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36560 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab2KTS7p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Nov 2012 13:59:45 -0500
In-Reply-To: <loom.20121115T165949-68@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

Looking to your previous messages...

On 11/15/2012 05:12 PM, Michael Pellegrini wrote:
> Oliver Hartkopp <socketcan <at> hartkopp.net> writes:
> 
>>
>> On 14.11.2012 16:39, Michael Pellegrini wrote:
>>
>>> I am trying to use the pch_can driver to interface with a CANopen system.
>>> I am encountering a serious issue where, at random intervals, the CAN 
> interface
>>> will lock up and stop transmitting data.  Data reception continues normally.
>>> The only way I've found to resolve the issue so far is to issue an
>>> "ifconfig canx down" command followed by an "ifconfig canx up" command.
>>> After the interface is reset through these commands, the TX packet dropped 
> count
>>> and the TX packet carrier count increment by 1.
>>>
>>> I am running Ubuntu 12.04 with kernel version 3.2.0-23.
>>>
>>> Has anyone else seen this problem or have a fix for it?
>>
>> Hello Mike,
>>
>> i put the relevant people into CC that probably know better than me.
>>
>> Btw. using the pch_can driver:
>>
>> 1. Can you please provide the output of 
>>
>> 	ip -details link show can0
>>
>> (if can0 is your device with the problem)
>> at start time and when the problem happened?
> 
> At Start Time:
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 250000 sample-point 0.875
>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>     pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>     clock 50000000
> 
> After Problem Happens:
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 250000 sample-point 0.875
>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>     pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>     clock 50000000
> 
> I then reset the interface via "ifconfig can0 down" and "ifconfig can0 up".
> 
> Output is:
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 250000 sample-point 0.875
>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>     pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>     clock 50000000
> 
> Output of "ifconfig can0" is:
> 
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-
> 00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:1085 errors:0 dropped:769 overruns:0 frame:0
>           TX packets:2039 errors:0 dropped:1 overruns:0 carrier:1
>           collisions:0 txqueuelen:10
>           RX bytes:1085 (1.0 KB)  TX bytes:10467 (10.4 KB)
>           Interrupt:18
> 
> Notice that the "dropped" and "carrier" count incremented by 1.

This means that the device was closed with pending TX messages.
Actually, the TX done did not come. Somehow the message did not go out
to the bus.

Wolfgang.


