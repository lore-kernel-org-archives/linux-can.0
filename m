From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: mcp251x issue
Date: Wed, 07 May 2014 17:52:45 +0200
Message-ID: <536A56CD.8020709@hartkopp.net>
References: <CADZ8cjkTH5=iYz1fD2Pua2nMZns1xinA+gEWaDLHqMM=WxR62g@mail.gmail.com>	<5367BDDC.70709@hartkopp.net> <CADZ8cjnEUT6r8EUxZdKbnuVADQ3bCbYJ1cU5evXxJrorJmNK3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:34360 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934016AbaEGPwv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 May 2014 11:52:51 -0400
In-Reply-To: <CADZ8cjnEUT6r8EUxZdKbnuVADQ3bCbYJ1cU5evXxJrorJmNK3g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Rocca <roccafrancesco@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Francesco,

the mcp251x is an SPI attached CAN controller which was reported to have some issues on your 2.6.36 Kernel.

Please take a look to the 2.6.36 log:
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/log/drivers/net/can/mcp251x.c?h=linux-2.6.36.y

And here the latest one:
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/log/drivers/net/can/mcp251x.c?h=linux-3.14.y

I would suggest to upgrade your Linux kernel.

As you still(!) did not write about your kind of embedded hardware, it's hard to help.

E.g. for the Raspberry Pi there are many community hints focusing the (often used) mcp251x - but they are already using a Linux 3.6.

Ah - and I CC'ed the Linux CAN mailing list.
Please always ask questions like this on the mailing list and not to me.
I'm not a mcp251x expert - but you might find them here.

Regards,
Oliver

On 07.05.2014 08:26, Francesco Rocca wrote:
> hello
> thank you for your support. the data request are following:
> 
> before
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>     link/can
>     can state ERROR-ACTIVE restart-ms 0
>     bitrate 500000 sample-point 0.875
>     tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
> 
> 
> after
> 3: can0: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
>     link/can
>     can state BUS-OFF restart-ms 0
>     bitrate 500000 sample-point 0.875
>     tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
> 
> you can see the bus goes OFF after few minutes! Performing can down and again
> can up the CAN module start to work! do you suggest to insert the command  ip
> link set can0 type can restart-ms 500? anyway is it a normal behavior? is
> there a way to avoid the bus off?
> thank you very much in advance!!
> 
> francesco
> 
> 
> 
> ---------- Forwarded message ----------
> From: *Oliver Hartkopp* <socketcan@hartkopp.net <mailto:socketcan@hartkopp.net>>
> Date: 2014-05-05 18:35 GMT+02:00
> Subject: Re: Socket CAN Issue
> To: Francesco Rocca <roccafrancesco@gmail.com <mailto:roccafrancesco@gmail.com>>
> 
> 
> What kind of CAN hardware are you using?
> 
> Please send the output of:
> 
> ip -details link show can0
> 
> At the beginning (before running your app) and when it is stuck (after running
> your app).
> 
> 
> Regards,
> Oliver
> 
> 
> On 05.05.2014 12:03, Francesco Rocca wrote:
>> Hello
>> I wrote you last time about BCM Interface; i Tried to use it but i had problem;
>> I use Embedded system with Linux kernel 2.6.36.
>> My Mutlihtrading application have a CAN BUS software module connected to
>> machine that receive message and answer to them.  The CAN MODULE open the
>> socket  on real interface "can0" and perform as following:
>>
>> - Send Cycling request
>> - Perform filtering on specific can id
>> -A loop that read the answers.
>>
>> A loop is built using CAN utility as base(CAN  dump, can sniffer etc)
>> After few seconds the module doesn't work anymore also if i try to open again
>> the socket!!
>>
>> The same things happen if i use RAW Protocol; in this last case i tried to use
>> also open and close conntection for any request but after 15 minutes more or
>> less does't work anymore!!!
>>
>> I'm using read and wirte fuction in the code and the other module of my
>> application as the CAN module write on log file by fprintf function. Is it
>> possible that is there interaction in the buffer I/O?
>> Is it the linux version too old?
>> It would be a pleasure if you suggest what i have to do to avoid this havy
>> problem!!
>>
>> Best Regards
>> Francesco
> 
