From: Marek Vasut <marex@denx.de>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Sun, 22 May 2016 23:11:33 +0200
Message-ID: <57422085.6040606@denx.de>
References: <573E491E.1000906@denx.de> <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com> <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de> <57421634.5050607@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:52258 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcEVVLm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 May 2016 17:11:42 -0400
In-Reply-To: <57421634.5050607@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/22/2016 10:27 PM, Patrick Menschel wrote:
>>> I remember a K-Line implementation for Linux where we had a MPC5200 UART
>>> which we programmed with bit-banging of some control line to do the
>>> 5bit/s opening pattern.
>>> After that we went to 10400 bit/s and did some K-Line communication.
>>> All this was done by a user space application on /dev/ttyS0.
>>
>> Yes, and this does make perfect sense until you start dealing with
>> faster modes and need more precise timing. The K-Line is limited by
>> 250kBaud/s bus speed.
>>
> 
> Hello Marek,

Hi!

> Afaik there is no ECU left that actually needs the "5 Baud INIT".
> Most ECUs use the "FAST INIT" procedure, means 25ms low, 25ms high, then
> start communication with 10400Baud.

We really do need to support both the slow and fast mode.

> The nasty part are the 25ms low, 25ms high , that is also prior to the 5
> Baud Init pattern.
> 
> After that, everything on the K-Line is pure serial communication.

True

> I've done a few test myself with an FT232RL based KKL-Interface and
> these 25ms low, 25ms high are very hard to realize. No Success at my end.

I wouldn't be surprised if the USB added a lot of non-determinism into
the timing. I use standard 16550 compatible UART core mapped in the CPU
address space.

> From my point of view, the 25ms low, 25ms high are the only reason to
> move into kernel space and possibly switch the Tx Pin to GPIO and pull
> it low/high for 25ms, then switch it back to UART.

That's only part of it, see my previous email in this thread where I
listed some more reasons.

These 25ms low-high might possibly be realized by serial break, no ?

> Regards,
> Patrick
> 
> 


-- 
Best regards,
Marek Vasut
