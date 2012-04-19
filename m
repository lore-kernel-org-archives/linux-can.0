From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN messages being lost on i.MX25 with flexcan
Date: Thu, 19 Apr 2012 12:54:58 +0200
Message-ID: <4F8FEF02.7040503@grandegger.com>
References: <jmonvu$nu8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36456 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2DSKzD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 06:55:03 -0400
In-Reply-To: <jmonvu$nu8$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

On 04/19/2012 12:04 PM, Martin Kozusky wrote:
> Hello,
> I'm using Voipac i.MX25 module with flexcan, kernel 2.6.38.9.
> I'm sending the data at 250kbps, around 1100 msgs/sec. When I enable the
> canbus interface (canconfig can0 start), CPU load is higher, that is
> understandable, there are many interrupts. I'm not doing anything else
> then using recvmsg (or recvmmsg which is little better), but some
> messages are still lost (around 1500 messages lost from 467 000 being
> send from another source). When I start doing something (like  "cat
> /proc/interrupts",  or write to file), many more messages are lost.
> 
> Do you have any idea how to fix this? I need to make some CAN messages
> logger and I cannot lose any message (idealy :) So I made big buffer in
> my program so that I don't need to write the messages into the file
> while "recording" is enabled, after "recording" is switched off, I write
> the buffer into the file, but that is still not good enough.
> Is there any way how to write to some buffer directly in flexcan driver
> (the best would be in the IRQ routine) and then read messages from this
> buffer in my program?
> Or are just interrupts lost when doing something else in the system and
> I cannot fix this? Or can I somehow specify that "can rx interrupts" has
> highest prioroty?

Do you already know where the packets are dropped (get lost). Maybe your
user space app is simply not faster enough to process them in time. You
can check that with the candump option "-d".

Wolfgang.
