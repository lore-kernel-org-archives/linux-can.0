From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 02 Apr 2015 10:21:29 +1100
Message-ID: <551C7D79.50906@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:48661 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429AbbDAXVc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 19:21:32 -0400
In-Reply-To: <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paarvai Naai <opensource3141@gmail.com>
Cc: linux-can@vger.kernel.org

On 02/04/15 07:33, Paarvai Naai wrote:
> Hi Tom,
>
> I'm not sure if you quite followed my concern with multiple clients to
> the SocketCAN interface.  All of the clients of a particular SocketCAN
> interface (i.e., "can0") are piggybacking on the same electrical node
> of the CAN bus -- this is their shared pipe to get their frames out on
> the bus.  Let me try to do a better job of explaining:
>
> 1) Lets call presuppose a node in our network, node "A", that runs
> Linux and has uses SocketCAN.
> 2) Client #1 of node A's SocketCAN-based interface submits a frame to
> its socket with ID=0x7ff.
> 3) Other non-Linux-based nodes on the bus, say nodes "B", "C", and "D"
> are spewing higher priority messages out on the bus.
> 4) As such, node A is unable to send frame with ID=0x7ff for while.
> 5) Now, some small amount of time later, Client #2 of the
> SocektCAN-based interface to node "A" submits a frame to its socket
> with ID=0x000.  Client #2 might be another thread or process running
> on the Linux OS of node A.
> 6) On the next arbitration loss of ID=0x7ff, node A should ideally
> reprioritize its TX queue such that ID=0x000 has a chance to get out.
>
> I have a suspicion that SocketCAN implementations are not careful
> about doing this, even though particular controllers may support this
> type of re-prioritization of frames (with their own internal TX
> queues).
>
> Does this make sense?  Do you have any thoughts?

You've given a very good and clear description of this problem.

The same thing can happen with a "deeply embedded" device. It depends on how 
many hardware transmit buffers there are, and how these are used by the 
controlling software.

There are two basic classes of CAN hardware. One has a lot of separate 
transmit and receive buffers, and is expected to be set up with one-only ID 
per buffer, in and outbound. This can be so "bare metal" that the buffer 
memory in the CAN controller is used as the ONLY place where the "variables" 
in the CAN messages are stored. The software reads and writes these variables 
in the buffers. The other sort of CAN controller implements FIFOs and better 
supports "streams" of packets. Many controllers are a bit of both.

I'm familiar with a few different CAN controllers.

The early/original Philips PCA82C200 and the compatible NXP SJA1000. They only 
have ONE hardware transmit buffer (even with the SJA1000 in PeliCAN mode), so 
this hardware suffers from the exact same problem you mention above. It can 
only handle priority properly if it is only sending ONE ID only.

The Microchip  MCP2515 has 3 transmit buffers, so can automatically prioritise 
three different IDs in hardware if the software supports that. But a maximum 
of three.

The Microchip ECAN controllers support the MCP2515 mode as well as a mode with 
(up to) 8 hardware transmit buffers.

Freescale's MSCAN has three transmit buffers.

Freescale's FlexCAN controller has 16 buffers that can be split between 
transmit and receive.

As the "System Designer", if your system (your car) uses SJA1000 controllers, 
or other ones, but with software that doesn't support the multiple hardware 
buffers, or has more IDs in use that the number of buffers, they you have to 
design the *SYSTEM* so it works within those constraints.

 > say nodes "B", "C", and "D" are spewing higher priority
 > messages out on the bus.

Then as part of the "system design" they're not allowed to do that. They have 
to rate-limit their transmissions to allow the other devices to meet the 
system requirements for latency, jitter or whatever.

TTCAN was invented in 2002 to try and solve this (and other) problems, but it 
looks to have been the "Betamax" of CAN protocols. Details here if you're 
interested:

http://www.microchip.com/forums/m849480.aspx

Tom

