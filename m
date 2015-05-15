From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Linux board with 10 CANs
Date: Sat, 16 May 2015 01:24:20 +1000
Message-ID: <55560FA4.4090300@optusnet.com.au>
References: <5555A6A3.7090206@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58958 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933865AbbEOPYf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 11:24:35 -0400
In-Reply-To: <5555A6A3.7090206@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>, linux-can@vger.kernel.org

On 15/05/2015 5:56 PM, Fran=C3=A7ois Beaulier wrote:
> Hi,
>
> I'm starting the design of a CPU board, based on a computer on module
> with a very common SOC like i.mx6 or am335x.

There are SOCs with 8 CAN ports built in, like the Freescale MPC574X=20
chips. That should be a lot easier to work with, and should be supporte=
d=20
without any extra drivers.

The following Selector Guide tells me the Vybrid SVFxxxR has *FIFTY* CA=
N=20
ports. That may have multiple typos, as Freescale's web site doesn't=20
admit to that part.

http://cache.freescale.com/files/microcontrollers/doc/roadmap/BRAUTOPRD=
CTMAP.pdf

> CAN bitrate needed is quite low (50kbps)

So at about 110 bits for a minimum sized Standard ID packet, that gives=
=20
you 450 messages/second max. That gives you a maximum service latency o=
f=20
2.2ms for as many buffers as the chip has. If your data has 8=20
bytes/packet then that drops to 3.5ms/buffer (7ms for a chip with 2).

That wouldn't be impossible with MCP2515s, just inadvisable. Especially=
=20
with Linux as it isn't good at any service guarantees.

But I've successfully run three MCP2515's on a Coldfire part. The QSPI=20
helps a lot. There are a lot of parts with multiple QSPI ports, and tha=
t=20
makes it less onerous (or DSPI or ECSPI). The i.MX6D has 5 on it. So tw=
o=20
"real" CAN ports and two MCP2515's on each of the SPI ports, with a=20
spare SPI port. Or three per port.

> I don't want to use MCP2515, i had trouble with it on a previous
 > design because of the lack of buffer in the chip.
> I can't imagine putting 8 MCP2515 and not missing any frame, but may =
be
> i'm wrong ?

Did you turn the BUKT bit on? If you spread them across lots of SPI=20
interfaces it should get easier as they should all be accessed in paral=
lel.

Tom

