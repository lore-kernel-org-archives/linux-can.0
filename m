From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [Rfi] Cyclone V CAN errors when application pinned to CPU1
Date: Sun, 7 Feb 2016 11:54:54 +1100
Message-ID: <56B695DE.9050804@optusnet.com.au>
References: <562155B7.7020504@vsis.cz> <20151020071807.GH20879@pengutronix.de>
 <5625EF45.2000807@pengutronix.de> <56B63491.9020500@vstk.cz>
 <56B6750D.4040602@optusnet.com.au> <56B6881F.3010606@vstk.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:59523 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752227AbcBGAzE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 6 Feb 2016 19:55:04 -0500
In-Reply-To: <56B6881F.3010606@vstk.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Vlastimil Setka <setka@vstk.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, Robert Schwebel <r.schwebel@pengutronix.de>
Cc: rfi@lists.rocketboards.org, linux-can <linux-can@vger.kernel.org>

On 7/02/2016 10:56 AM, Vlastimil Setka wrote:
> 6.2.2016 23:34 Tom Evans:
>> On 7/02/2016 4:59 AM, Vlastimil Setka wrote:
>>>>> We have a linux application which sends data
>>>>> periodically (1 to 20 ms period) out over the
>>>>> can0 socketcan interface. Sometimes the first
>>>>> data byte in the CAN frame is zero on the wire,
>>>>> but non-zero in the data sent!
>>>> The TX functions is usually pretty straight forward. Copy all data bytes into the hardware, write ID and DLC, then hit the send bit (or whatever triggers the hardware to send the frame). Maybe there's some barrier missing in this sequence?
>> I'd suggest you "objdump -S" the CAN driver object file and check to see the optimizer hasn't re-ordered the above sequence too much.
>
> I'm not so familiar with reading assembly,

It is a skill worth working on.

 > and the driver is a bit
 > complicated by splitting this into many functions.

Having lots of simple functions makes it easier to understand and follow 
than the alternative.

I've looked at the source and the assembly and I'm pleasantly surprised. 
It looks like there's almost no optimization as the assembly exactly 
matches the code. Nothing unexpected.

If there are any barriers then they have to be in priv->write_reg()

Everything is done by NAPI in this driver [1]. The interrupt () does 
nothing but trigger NAPI to run "c_can_poll()". It receives messages, 
finds completed transmits, frees the buffers and restarts the NAPI 
transmit queue. NAPI transmits come through c_can_start_xmit(), which 
calls c_can_setup_tx_object() to load the data, THEN weirdly calls 
can_put_echo_skb() before starting the send with c_can_object_put().

NAPI should be guaranteeing that things are done in the right order. I'd 
still add the "recursive checks" though. Your problem might be due to 
the "rt preempt patch" messing up NAPI somehow so it isn't obeying the 
rules. Does it fail without that patch?

Note 1: I don't like NAPI. My experience with Freescale's FlexCAN (which 
did the same thing - reading all data from the chip in NAPI) was that 
the six-entry FIFO would easily overflow and lose messages at 1MHz CAN 
bit rate with high Ethernet loading.

> I uploaded objdump -S of my c_can.o here:
 > https://gist.github.com/vstk/9c4307bb9ae0a6ae0208

Read through from line 4092. The assembly follows the source exactly.

Tom

