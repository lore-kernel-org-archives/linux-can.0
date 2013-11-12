From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Tue, 12 Nov 2013 22:26:09 +0100
Message-ID: <52829CF1.4010902@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com> <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com> <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com> <5254608B.4080208@grandegger.com> <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com> <be0d6725fff5298d3fb8417e4800348b@grandegger.com> <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com> <84ba410d04a85a783d1c1994f98d1f31@grandegger.com> <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com> <527E44EB.9020605@hartkopp.net> <CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:21133 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab3KLV0N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 16:26:13 -0500
In-Reply-To: <CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On 12.11.2013 03:59, Austin Schuh wrote:

>> From the trace it is pretty hard to know which CAN interface is in charge.
>> (2) Can you please add the output of dev->ifindex in the pr_info() calls?
> 
> Gladly.  See the updated logs.
> 
> [  556.019246] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> [  556.019268] Unhandled IRQ 18... stop tracing...
> [  556.019280] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> [  556.019289] peak_pci 0000:05:00.0 can1: Received packet.
> [  556.019299] peak_pci 0000:05:00.0 can1: sja1000_rx
> [  556.019307] peak_pci 0000:05:00.0 can0: TX complete.
> [  556.019318] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
> [  556.019362] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
> 

This looks pretty broken regarding the IRQ handling.
Maybe the IRQ thread handling has a real problem in the -rt kernel ?!?

>> (3) Is it possible to use a standard (non-RT) kernel on your system to confirm
>> this issue on a unmodified system?
> 
> It will be a bit of time before I can schedule enough time on the PC
> in question with a non-realtime kernel.  I'll see what I can do.

That would be a valuable information to go deeper into this problem.

Thanks,
Oliver
