From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Mon, 11 Nov 2013 18:59:12 -0800
Message-ID: <CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
	<5254608B.4080208@grandegger.com>
	<CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
	<be0d6725fff5298d3fb8417e4800348b@grandegger.com>
	<CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
	<84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
	<CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
	<527E44EB.9020605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45364 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3KLC7M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2013 21:59:12 -0500
Received: by mail-ie0-f170.google.com with SMTP id to1so3762850ieb.15
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2013 18:59:12 -0800 (PST)
In-Reply-To: <527E44EB.9020605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hi Oliver,

On Sat, Nov 9, 2013 at 6:21 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Austin,
>
> from the trace I assume that you connected the two CAN interfaces which each
> other and you get the tx-complete interrupt very close to the rx interrupt.
>
> (1) Is this assumed setup correct?

Correct, it is.

> From the trace it is pretty hard to know which CAN interface is in charge.
> (2) Can you please add the output of dev->ifindex in the pr_info() calls?

Gladly.  See the updated logs.

[  556.019246] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
[  556.019268] Unhandled IRQ 18... stop tracing...
[  556.019280] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
[  556.019289] peak_pci 0000:05:00.0 can1: Received packet.
[  556.019299] peak_pci 0000:05:00.0 can1: sja1000_rx
[  556.019307] peak_pci 0000:05:00.0 can0: TX complete.
[  556.019318] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
[  556.019362] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED

[  785.760244] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
[  785.760249] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
[  785.760266] Unhandled IRQ 18... stop tracing...
[  785.760271] peak_pci 0000:05:00.0 can1: Received packet.
[  785.760286] peak_pci 0000:05:00.0 can1: sja1000_rx
[  785.760303] peak_pci 0000:05:00.0 can0: TX complete.
[  785.760317] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
[  785.760354] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED

[  805.392135] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
[  805.392176] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
[  805.392181] peak_pci 0000:05:00.0 can1: Received packet.
[  805.392195] peak_pci 0000:05:00.0 can1: sja1000_rx
[  805.392210] Unhandled IRQ 18... stop tracing...
[  805.392248] peak_pci 0000:05:00.0 can0: TX complete.
[  805.392268] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
[  805.392271] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED

> From your first post I was able to read your current kernel as:
>> $ uname -a
>> Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1
>> (2013-09-10) x86_64 GNU/Linux
>
> (3) Is it possible to use a standard (non-RT) kernel on your system to confirm
> this issue on a unmodified system?

It will be a bit of time before I can schedule enough time on the PC
in question with a non-realtime kernel.  I'll see what I can do.

Thanks!
    Austin
