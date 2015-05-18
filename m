From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Linux board with 10 CANs
Date: Mon, 18 May 2015 22:56:32 +1000
Message-ID: <5559E180.9020105@optusnet.com.au>
References: <5555A6A3.7090206@orange.fr> <55560FA4.4090300@optusnet.com.au>    <5559AFF6.3040509@orange.fr> <45240.212.149.48.43.1431942011.squirrel@webmail.rdts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42395 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbbERM4i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 May 2015 08:56:38 -0400
In-Reply-To: <45240.212.149.48.43.1431942011.squirrel@webmail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de, =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Cc: linux-can@vger.kernel.org

On 18/05/2015 7:40 PM, Gerhard Bertelsmann wrote:
> Hi Francois,
> Am Mo, 18.05.2015, 11:25, schrieb Fran=C3=A7ois Beaulier:
>> I know the MCP2515 may work in some situation but it depends on kern=
el
>> latency and that is very unpredictable.

You can always try running RT or Xenomai. I wouldn't recommend that.

We had trouble with Linux kernel latency, until I found our supplier ha=
d=20
shipped Linux with a whole bunch of debugging turned on. We got rid of=20
CONFIG_DEBUG_PAGEALLOC, SPIN, MUTEX, and SLUB debugging and it got a lo=
t=20
more responsive. I had to trace the kernel to find out where it was=20
spending all its time (in SLUB debugging mainly).

We're running two FlexCAN ports, each with a 6-deep FIFO at 1MHz each.=20
We're not having any problems now [1]. You're wanting to run at 1/20 of=
=20
that data rate with 1/3 of the FIFO depth. That should work, even with=20
10 of them running.

Note 1: The CAN driver deferred reading data to NAPI, the debugs were o=
n=20
and the (old non-NAPI) Ethernet driver happily kept pulling hundreds of=
=20
Ethernet packets in during one interrupt, so I was getting CAN overruns=
=2E=20
I rewrote the CAN driver to read message data during Interrupts,=20
throttled Ethernet and added interrupt priority and turned the debugs=20
off. Now it is fine.

>> What is helping in QSPI ?

Instead of your GHZ CPU having to wait for a 10MHz SPI bus to send a=20
byte, or be interrupted once per byte, it can load up 16 multi-byte=20
transactions and be interrupted when the whole thing is complete. I=20
don't know how good the SPI drivers are and how well the Linux MCP2515=20
driver supports this (if it supports the hardware queue). It looks like=
=20
it reads a whole CAN message in a single SPI transaction though.

>> the main problem beeing latency between
 >> MCP irq and effective SPI transfer ?

Go Multicore and spread the load, or keep long latency stuff of the CAN=
=20
core.

> The only concern that I have is the latency/overhead of the SocketCAN
> API with 10 CANs at high packet rates on 1 GHz ARM ...

The interrupts, NAPI and SocketCAN switches and code all add about the=20
same overhead to each message processed. Multiple interrupts, a NAPI ru=
n=20
and SocketCAN context switch for 8 bytes of user data (or maybe even on=
e=20
or no bytes) is a pain. CAN and Linux really weren't mean to get on and=
=20
it shows.

Or you could run 5 complete CPUs, networked via Ethernet.

The USB solution looks good, as long as the USB is reliable.

Tom

