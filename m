From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 16:56:37 +0200
Message-ID: <5072E9A5.2060908@grandegger.com>
References: <6309304.MqJsLKDGaO@lisa> <5072BCFE.5000006@pengutronix.de> <1722972.yqiF7qX92T@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53469 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2JHO4k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 10:56:40 -0400
In-Reply-To: <1722972.yqiF7qX92T@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On 10/08/2012 04:36 PM, Steffen Rose wrote:
> Hello,
> 
> Am Montag, 8. Oktober 2012, 13:46:06 schrieb Marc Kleine-Budde:
>>> I use:
>>> Virtual box - Host Win 7/Guest kubuntu
>>> Linux lisa 3.2.0-30-generic #48-Ubuntu SMP Fri Aug 24 16:52:48 UTC 2012
>>> x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> SocketCAN connector is a EMS CPC-USB.
> 
> [...]
> 
>> Your program probably produces CAN frames faster than they could be
>> delivered by your CAN hardware. Your choices are:
> 
> I'm unsure.
> My CPU load is high. My application polling is not optimal at the moment. But 
> the CAN busload is not so high.
> 
> At the moment I would think, it is more a problem internal or on USB. I'm 
> unsure. I search information to analyze the current situation.
> 
>> 2) Increase txqueue length to 10000 or so.
>>    (ifconfig can0 txqueuelen 10000)
> 
> I did it.
> 
> after a little bit time...

Did it run longer than before? Anyway, the candump utility shows how to
count messages dropped because the queue was full. Search for the option
"-d".

> 
> Now my error:
> 	write: Interrupted system call

Hm, who has interrupted the write system call? gdb?

> 
> 
> $ ./candump can0

Please use "candump can0 any,0:0,#FFFFFFFF" to also see error messages.

> 
> I see nothing.

Maybe error frames?

> But: There is traffic on the CAN and the USB traffic light of the CPC-USB is 
> blinking. Means, the CAN-USB transfer data from the CAN to the socketcan CAN 
> driver.
> 
> Can I see more states about the can, can_raw or the ems_usb modules?

The stats below should tell you if you still receive messages.

> 
> $ ip -det -stat link show can0
> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 
> 10000
>     link/can 
>     can state ERROR-ACTIVE restart-ms 0 
>     bitrate 250000 sample-point 0.875 
>     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     ems_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          19         0          1          1          0    

You seemed to have electrical problem on the bus. Not sure if it's
related, though.

Wolfgang.

