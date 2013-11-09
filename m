From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Sat, 09 Nov 2013 15:21:31 +0100
Message-ID: <527E44EB.9020605@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com> <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com> <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com> <5254608B.4080208@grandegger.com> <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com> <be0d6725fff5298d3fb8417e4800348b@grandegger.com> <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com> <84ba410d04a85a783d1c1994f98d1f31@grandegger.com> <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:63856 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab3KIOVe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 9 Nov 2013 09:21:34 -0500
In-Reply-To: <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hello Austin,

from the trace I assume that you connected the two CAN interfaces which each
other and you get the tx-complete interrupt very close to the rx interrupt.

(1) Is this assumed setup correct?

From the trace it is pretty hard to know which CAN interface is in charge.
(2) Can you please add the output of dev->ifindex in the pr_info() calls?

From your first post I was able to read your current kernel as:
> $ uname -a
> Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1
> (2013-09-10) x86_64 GNU/Linux

(3) Is it possible to use a standard (non-RT) kernel on your system to confirm
this issue on a unmodified system?

On 08.11.2013 00:43, Austin Schuh wrote:

> I added some pr_info prints at the front of sja1000_rx and
> sja1000_interrupt.  For each packet sent and then received, I see the
> following.  The following lines are from me sending 4 packets.
> 
> Nov  7 15:35:52 vpc5 kernel: [   75.136107] Got an sja1000 interrupt.
(which interface?)

> Nov  7 15:35:52 vpc5 kernel: [   75.136123] Unhandled IRQ 18... stop tracing...
> Nov  7 15:35:52 vpc5 kernel: [   75.136130] Got an sja1000 interrupt.
(which interface?)

> Nov  7 15:35:52 vpc5 kernel: [   75.136139] Received packet.
(which interface?)

> Nov  7 15:35:52 vpc5 kernel: [   75.136146] sja1000_rx
(which interface?)

> Nov  7 15:35:52 vpc5 kernel: [   75.136155] TX complete.
(which interface?)

> Nov  7 15:35:52 vpc5 kernel: [   75.136174] Returning IRQ_HANDLED
> Nov  7 15:35:52 vpc5 kernel: [   75.136207] Returning IRQ_HANDLED
(which interface?)

Thanks,
Oliver

