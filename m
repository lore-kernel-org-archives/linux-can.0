From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Sun, 05 Jul 2015 11:18:20 +1000
Message-ID: <559885DC.8040208@optusnet.com.au>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:34357 "EHLO
	mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbbGEJcr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jul 2015 05:32:47 -0400
In-Reply-To: <55980FCE.4030304@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>

On 5/07/2015 2:54 AM, Oliver Hartkopp wrote:
> Hi Stephane,
> ...
> While testing the patches
> ...
> I discovered an increase of out-of-order CAN frame receptions.
> My setup is a core i7 with a PCAN USB and a PCAN USB pro connected to my
> full busload CAN source (1MBit/s, ~8008 frames/s).

Out of order reception is guaranteed with some CAN hardware and driver 
software, such as the MCP2515 controller and Linux. The chip doesn't 
implement a FIFO, but has two receive buffers which can give message 
swaps quite easily. This can be fixed in the driver, but nobody has. 
Details here:

http://www.microchip.com/forums/m620741.aspx

The PCAN-USB uses an SJA1000 which doesn't have that problem. It has a 
64 byte FIFO. What is inside the PCAN-USB Pro isn't documented on their 
web page, but it may be faster or have less transaction overhead or 
latency or something. The PCAN-USB Pro is "no longer manufactured", the 
replacement "PCAN-USB Pro FD" has an FPGA controller.

 > It's more with the PCAN USB and very few with PCAN USB pro.

I'd guess the Pro has less overhead and can get messages over USB faster 
than the other one.

 > I'm a bit confused as this effect seems to increase with Linux kernel
 > version numbers.

As for the later kernels being worse, that looks like a simple case of 
"bloat", with them taking longer to get around to servicing the 
interrupts and reading the messages. Earlier ones are probably reading 
CAN messages one at a time, with each one getting through the stack 
before the next one arrives. Later kernels are probably reading them in 
bursts. Slower controllers (PCAN-USB) expose this sooner.

Can you drop back to a single core to see if this is a multicore 
problem? It will either fix it or make it worse if it is a loading/delay 
problem.

Reordering packets should be considered a serious bug as some CAN 
protocols can't handle this at all.

Regards,

Tom


