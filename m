From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Thu, 12 Dec 2013 16:07:11 -0800
Message-ID: <CANGgnMaoKnFTwAiZtGB+cO65E_7G3upKjQXHCszFfQfwCHsvOg@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<52831FC7.3040509@hartkopp.net>
	<f323c29b9730c877729322453b9e4ec9@grandegger.com>
	<201311131008.55018.pisa@cmp.felk.cvut.cz>
	<5287E6B2.8020709@hartkopp.net>
	<85256584a266750b1330cfae8bebd55c@grandegger.com>
	<5288D236.403@hartkopp.net>
	<5288FB91.9050703@grandegger.com>
	<52892B21.9000501@grandegger.com>
	<CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>
	<CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
	<333c0fd4238558062478212eb0704b04@grandegger.com>
	<CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>
	<a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>
	<52A71B6C.3050600@hartkopp.net>
	<8e5f03acb59e16a0ebcd31499a533f15@grandegger.com>
	<52A73BB1.7070701@hartkopp.net>
	<52A783B2.5020002@grandegger.com>
	<52A89A0A.7010803@hartkopp.net>
	<52A8BC94.6010805@grandegger.com>
	<52A953F3.3000605@hartkopp.net>
	<52A9F491.3060406@hartkopp.net>
	<52AA3F16.3070309@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35489 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3LMAHM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2013 19:07:12 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so1864800iej.12
        for <linux-can@vger.kernel.org>; Thu, 12 Dec 2013 16:07:11 -0800 (PST)
In-Reply-To: <52AA3F16.3070309@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

I have tried to look around to see if I can find documentation on what
PITA means in this situation so I can be more helpful.  I'm not
finding anything.

I don't see any locking in note_interrupt or around it from the
calling function (irq_thread, if I'm not mistaken).  Good catch, and
that looks wrong for sure.

Austin

On Thu, Dec 12, 2013 at 2:56 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hi Oliver,
>
> I started to analyse Austin's function trace...
>
> On 12/12/2013 06:38 PM, Oliver Hartkopp wrote:
>> On 12.12.2013 07:13, Oliver Hartkopp wrote:
>>> On 11.12.2013 20:27, Wolfgang Grandegger wrote:
>>
>>>> BTW, does the problem show up if only one can is active? Austin tests
>>>> did just RX on can1, but can0 was obviously up (but no traffic).
>>>
>>> There was a case that the IRQ line from can9, can10, can11, can12 failed with
>>> an error messaged pointing to can10. All four interfaces where up but only
>>> can9 had traffic at that time.
>>
>> Hi Wolfgang,
>>
>> here's my latest investigation result.
>>
>> The setup still has (only) can9 with traffic and after a modification of
>> linux/kernel/irq/spurious.c (patch below) I got this:
>>
>> [ 1117.957651] irq 17: nobody cared (try booting with the "irqpoll" option)
>> [ 1117.959910] CPU: 0 PID: 3498 Comm: irq/17-can9 Not tainted 3.10.11-rt7-can #6
>> [ 1117.959913] Hardware name: xxxxxx
>> [ 1117.959916]  00000000 c1089114 f4e44840 00000001 00000011 c1089490 ee84e780 f4e44840
>> [ 1117.959924]  ee84e780 ed876fa0 c1087cf3 c10884a9 ee84e7a0 ed876fa0 16edf7d9 00000000
>> [ 1117.959932]  00000000 00000000 00000000 c108857f eea53de4 ee84e780 c1088416 ef0a1f90
>> [ 1117.959939] Call Trace:
>> [ 1117.959949]  [<c1089114>] ? __report_bad_irq+0x18/0xbe
>> [ 1117.959953]  [<c1089490>] ? note_interrupt+0x118/0x194
>> [ 1117.959957]  [<c1087cf3>] ? irq_thread_fn+0x21/0x21
>> [ 1117.959960]  [<c10884a9>] ? irq_thread+0x93/0x169
>> [ 1117.959964]  [<c108857f>] ? irq_thread+0x169/0x169
>> [ 1117.959968]  [<c1088416>] ? wake_threads_waitq+0x31/0x31
>> [ 1117.959973]  [<c104a79e>] ? kthread+0x68/0x6d
>> [ 1117.959979]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
>> [ 1117.959982]  [<c104a736>] ? __kthread_parkme+0x50/0x50
>> [ 1117.959986] handlers:
>> [ 1117.962184] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can8 PITA 0x0001
>> [ 1117.962190] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can10 PITA 0x0001
>> [ 1117.962196] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can11 PITA 0x0001
>> [ 1117.962201] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can9 PITA 0x0001
>> [ 1117.962202] Disabling IRQ #17
>
> ...ending here as well.
>
>> The value in the PITA register is 0x0001 which is from can9 according to
>> peak_pci_icr_masks[] (2nd element).
>>
>> So obviously the flag was set and not consumed correctly ...
>
> Well, it could also be set after the bug above triggered. If I look to
> Austins trace, I see at the end (with "grep note_interrupt"):
>
>  irq/18-ata_gene-219   [003] ....... 360026.315878: note_interrupt <-irq_thread
>      irq/18-can1-1890  [001] ....... 360026.315984: note_interrupt <-irq_thread
>      irq/18-can0-1863  [002] ....... 360026.316122: note_interrupt <-irq_thread
>  irq/18-ata_gene-219   [003] ....... 360026.316140: note_interrupt <-irq_thread
>      irq/18-can1-1890  [001] ....... 360026.316184: note_interrupt <-irq_thread
>      irq/18-can0-1863  [002] ....... 360026.316358: note_interrupt <-irq_thread
>  irq/18-ata_gene-219   [003] ....... 360026.316361: note_interrupt <-irq_thread
>  irq/18-ata_gene-219   [003] ....... 360026.316361: __report_bad_irq <-note_interrupt
>      irq/18-can1-1890  [001] ....... 360026.316437: note_interrupt <-irq_thread
>      irq/18-can0-1863  [002] ....... 360026.316608: note_interrupt <-irq_thread
>      irq/18-can1-1890  [001] ....... 360026.316714: note_interrupt <-irq_thread
>  irq/18-ata_gene-219   [003] d...1.. 360026.317050: _raw_spin_unlock_irqrestore <-note_interrupt
>  irq/18-ata_gene-219   [003] ....... 360026.317051: printk <-note_interrupt
>  irq/18-ata_gene-219   [003] ....... 360026.317541: irq_disable <-note_interrupt
>  irq/18-ata_gene-219   [003] ....... 360026.317541: mod_timer <-note_interrupt
>
> In Austin's case can1 is doing RX and can0 is up but inactive. The last activity
> in "sja1000_interrupt" is:
>
>      irq/18-can1-1890  [001] .....11 360026.316619: sja1000_interrupt <-irq_forced_thread_fn
>      irq/18-can1-1890  [001] .....11 360026.316619: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316621: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316623: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316626: alloc_can_skb <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316631: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316633: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316637: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316640: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316643: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316645: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316648: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316651: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316654: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316656: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316659: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316662: sja1000_write_cmdreg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....12 360026.316666: migrate_enable <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316667: netif_rx <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316671: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316673: peak_pci_read_reg <-sja1000_interrupt
>      irq/18-can1-1890  [001] .....11 360026.316675: peak_pci_post_irq <-sja1000_interrupt
>
> Which ends with "peak_pci_post_irq" before the interrupt gets disabled.
> Pretty normal! I'm puzzled why the irqs_unhandled counter of the
> interrupt reaches 99900 here:
>
>   http://lxr.free-electrons.com/source/kernel/irq/spurious.c#L30
>
> My impression is that the problem is with counting "irqs_unhandled" and "irqs_count",
> which might not be done atomically. Actually three threads call "note_interrupt".
> Does that make sense? Hope to find some time tomorrow to use atomic_set and friends
> to handle these counters.
>
> Wolfgang.
>
