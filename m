From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Sun, 16 Jun 2013 11:20:05 +0200
Message-ID: <51BD8345.8090808@grandegger.com>
References: <51B9BF61.8050905@hostmobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:45698 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab3FPJUJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Jun 2013 05:20:09 -0400
In-Reply-To: <51B9BF61.8050905@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: linux-can@vger.kernel.org

On 06/13/2013 02:47 PM, Mirza Krak wrote:
> Dear Sirs.
> 
> I am running a 3.1.10 kernel on Nvidia Tegra 2 CPU (Dual Core). Not
> vanilla kernel (Linux4Tegra).
> 
> We are using dual can controllers connected on th external data bus on
> our custom hardware. The can controllers are SJA1000.

What external data bus is the CAN controller connected to?
And which CAN controller board/card?

> Driver that is used is vanilla sja1000 driver (sja1000.c)

Which bus driver is used and how do you load the module?

> Now to the issue at hand. Will try my best to explain our scenario and
> issue:
>     1. The two can controllers are connected with each other with a
> loop-back.
>     2. What we are attempting is to send data on both controllers in two
> separate processes. We are using following command "cansequence can0 -p
> &" and "cansequence can1 -p &". With a bit-rate configured to 1 Mbit/s.
>     3. What we see when we attempt the above is that one of the
> controllers stop sending and the software buffer gets filled up. When it
> stops varies but usually after a few packets are sent.
> 
> After some digging we came to this conclusion. The two cansequence
> processes end up on different CPU cores. The process that ends up in
> CPU1 is the one that always stops transmitting.
> 
> Workarounds that we have seen that works is
>     1. Disable dual core with kernel argument "maxcpus=1".
>     2. Forcing the cansequence processes to CPU0 with "taskset" command.
> 
> My question to you is if anyone has tested the SJA1000 driver on an SMP
> system or anything similar.

Well, sending from two processes concurrently is not really a typical
use case. ftrace is your friend. A function trace may help to find the
root of the problem. Let me know if you need further help on that.

Wolfgang.

