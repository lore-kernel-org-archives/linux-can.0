From: wg <wg@grandegger.com>
Subject: Re: AW: Receiving messages issue
Date: Tue, 25 Jun 2013 14:58:43 +0200
Message-ID: <1a8586be9d1ed808cba9effa255d3138@grandegger.com>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
 <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:44750 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab3FYM6p (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Jun 2013 08:58:45 -0400
In-Reply-To: <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de
Cc: Michael Luxen <mluxen@gmx.net>, Luka Rahne <luka.rahne@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 25 Jun 2013 14:00:11 +0200 (CEST), "Gerhard Bertelsmann"

<info@gerhard-bertelsmann.de> wrote:

> Hi,

> 

>>> On 06/24/2013 02:26 PM, Luka Rahne wrote:

>>> > I am using MCP2515 with  i.MX27

>>>

>>> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is

worse.

>>>

> 

> IMHO the controller isn't bad - it's the host interface (SPI).



Well let's say it's a bad choice for Linux because there is no message

buffer/fifo requiring hard realtime response...



> The MCP2515 based capes are using the BB SPI bus. As already stated

before,

> the CAN controller is not read-out fast enough. Root cause of this is

> mainly

> the latency between MCP2515 interrupt and the SPI commands. I have seen

> this on different platforms: there are gaps sometimes in the 100usec

range.



... and 100 us is hard to meet, even with the -rt extension.



> The BBB is fast but there will be still gaps between MCP2515 attention

> needed

> and SPI transfers and on heavy loaded links there will be reordered

packets

> or packet losts.

> One solution could be running the SPI with higher priority. Second one

> would

> be to tie SPI and MCP2515 driver together, but this is a quite dirty

hack.

> 

> But the Beaglebone-CPU has a nifty thing: the PRUSS - 2x200 MHz CPUs

> independantly running from the main CPU. Coupling one or more MCP2515s

> to the appropiate pins could be easily served. The PRUSS doesn't have a

> hardware SPI interface, but with old school bitbanging you could get 

all

> CAN packets even on fully loaded 1MBit link.

> There is shared memory region between main and PRUSS CPU. Both CPU

> domains could generate an interrupt for the other domain. So the data

> could be easily exchanged - without any lost or reordered packets.



Well, what an pain just to support that CAN controller. Could be done, but



there are better choices.



Anyway, there is still room for improving the software and it would be

nice

to get Andre B. Oliveira mainline.



Wolfgang.
