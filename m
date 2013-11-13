From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 12 Nov 2013 19:41:28 -0800
Message-ID: <CANGgnMaCvb=B2r997e+H9UjVquX66HJ+OtftL0EyGP7MKcy0tQ@mail.gmail.com>
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
	<CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
	<52829CF1.4010902@hartkopp.net>
	<CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:65321 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab3KMDl3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 22:41:29 -0500
Received: by mail-ie0-f171.google.com with SMTP id at1so5565208iec.30
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2013 19:41:28 -0800 (PST)
In-Reply-To: <CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Tue, Nov 12, 2013 at 3:22 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> On Tue, Nov 12, 2013 at 1:26 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 12.11.2013 03:59, Austin Schuh wrote:
>>
>>>> From the trace it is pretty hard to know which CAN interface is in charge.
>>>> (2) Can you please add the output of dev->ifindex in the pr_info() calls?
>>>
>>> Gladly.  See the updated logs.
>>>
>>> [  556.019246] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
>>> [  556.019268] Unhandled IRQ 18... stop tracing...
>>> [  556.019280] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
>>> [  556.019289] peak_pci 0000:05:00.0 can1: Received packet.
>>> [  556.019299] peak_pci 0000:05:00.0 can1: sja1000_rx
>>> [  556.019307] peak_pci 0000:05:00.0 can0: TX complete.
>>> [  556.019318] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
>>> [  556.019362] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
>>>
>>
>> This looks pretty broken regarding the IRQ handling.
>> Maybe the IRQ thread handling has a real problem in the -rt kernel ?!?
>
> Sounds pretty plausible right now.

Ok, I spent a good chunk of today reading the IRQ handling code in the
kernel, and I think I get what is happening and have a plausible
explanation for why the interrupt is getting disabled.  Not sure how
to test it.

Here is what it looks like is happening.  The hardware triggers an
interrupt.  The handler is called, and then the registered action for
each of the devices is to notify their threads that an IRQ occurred,
and to have them handle it.  Each of the handling threads then calls
the sja1000_interrupt function, or the equivalent ata_generic
interrupt function.  2 of the 3 interrupt functions then return
IRQ_NONE, and one of them returns IRQ_HANDLED.  note_interrupt is then
called in each of the threads (instead of being called once in the
non-rt case), resulting in 2 unhanded calls, and 1 handled call.  So
far, so good.  The kernel operates as expected, since less than 99.9 %
of the interrupts are handled.  (There is a note_interrupt call in the
handler, but since the threaded handlers are notified, this doesn't
get counted.

Since the IRQ handlers are now all in threads, if the thread that
actually receives data doesn't process the interrupts either because
something goes wrong, or because it doesn't get scheduled, there will
be a bunch of unhanded interrupts noted, and no handled interrupts
noted.  This will cause the IRQ to be disabled.

I guess the next interesting thing to do is to trigger when it
disables the IRQ and take a look at what is happening.  I have a test
running on one machine with tracing enabled which will disable tracing
when the IRQ is disabled.  That should provide some interesting
results.  I think I also know how to bypass it for now by setting
"noirqdebug", but I'd like to fix it for real as well.

Austin
