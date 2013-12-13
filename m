From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Fri, 13 Dec 2013 10:38:49 +0100
Message-ID: <52AAD5A9.5030607@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegge
 r.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com> <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net> <52AA3F16.3070309@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:60774 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3LMJi5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2013 04:38:57 -0500
In-Reply-To: <52AA3F16.3070309@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On 12.12.2013 23:56, Wolfgang Grandegger wrote:

> My impression is that the problem is with counting "irqs_unhandled" and "irqs_count",
> which might not be done atomically. Actually three threads call "note_interrupt".
> Does that make sense? Hope to find some time tomorrow to use atomic_set and friends
> to handle these counters.

To hopefully complete the picture some more traces from yesterday evening:

[ 1117.959986] handlers:
[ 1117.962184] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can8 PITA 0x0001
[ 1117.962190] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can10 PITA 0x0001
[ 1117.962196] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can11 PITA 0x0001
[ 1117.962201] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can9 PITA 0x0001
[ 1117.962202] Disabling IRQ #17

(..)

[ 5995.979307] handlers:
[ 5995.979337] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can0 PITA 0x0042
[ 5995.979342] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can1 PITA 0x0042
[ 5995.979346] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can2 PITA 0x0042
[ 5995.979350] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can3 PITA 0x0042
[ 5995.979354] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can16 PITA 0x0000
[ 5995.979358] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can17 PITA 0x0000
[ 5995.979362] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can18 PITA 0x0000
[ 5995.979365] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can19 PITA 0x0000
[ 5995.979366] Disabling IRQ #19

(..)

[ 7527.712564] handlers:
[ 7527.712606] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can12 PITA 0x0000
[ 7527.712612] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can13 PITA 0x0000
[ 7527.712617] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can14 PITA 0x0000
[ 7527.712623] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can15 PITA 0x0000
[ 7527.712624] Disabling IRQ #18

/proc/interrupts:

 16:          8          9          8          8   IO-APIC-fasteoi   ehci_hcd:usb1, ahci, can4, can5, can6, can7
 17:    1838572    1843233    1845868    1838175   IO-APIC-fasteoi   can8, can10, can11, can9
 18:   12665112   12624875   12641515   12637319   IO-APIC-fasteoi   can12, can13, can14, can15
 19:   10787522   10822954   10803457   10815440   IO-APIC-fasteoi   can0, can1, can2, can3, can16, can17, can18, can19

So after some time all CAN related interrupts have been disabled ...

I wondered if the PITA access for consuming the bit is really working.
Therefore I made the if-statement a while statement here:

--- linux-source-3.10/drivers/net/can/sja1000/peak_pci.c	2013-09-08 07:10:14.000000000 +0200
+++ linux-source-3.10-rt/drivers/net/can/sja1000/peak_pci.c	2013-12-13 08:42:15.850192329 +0100
@@ -539,12 +539,17 @@
 static void peak_pci_post_irq(const struct sja1000_priv *priv)
 {
 	struct peak_pci_chan *chan = priv->priv;
+#if 0
 	u16 icr;
 
 	/* Select and clear in PITA stored interrupt */
 	icr = readw(chan->cfg_base + PITA_ICR);
 	if (icr & chan->icr_mask)
 		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
+#else
+	while (readw(chan->cfg_base + PITA_ICR) & chan->icr_mask)
+		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
+#endif
 }
 
 static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)


This should usually not have any effect, right?
But what happened was a big crash after a pretty short time:

[  760.718091] INFO: rcu_preempt self-detected stall on CPU { 1}  (t=84015 jiffies g=482 c=481 q=2688)
[  760.718092] sending NMI to all CPUs:
[  760.718094] NMI backtrace for cpu 1
[  760.718098] CPU: 1 PID: 3629 Comm: irq/17-can9 Not tainted 3.10.11-rt7-can #6
[  760.718099] Hardware name: xxxxxx
[  760.718100] task: edcdb4e0 ti: ee942000 task.ti: ee942000
[  760.718101] EIP: 0060:[<c118b3a3>] EFLAGS: 00000006 CPU: 1
[  760.718106] EIP is at __const_udelay+0x7/0x17
[  760.718107] EAX: 00418958 EBX: 00002710 ECX: c13ca099 EDX: 009aa184
[  760.718108] ESI: f51bb954 EDI: 00000a80 EBP: ee943ec0 ESP: ee943dbc
[  760.718109]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  760.718111] CR0: 8005003b CR2: 0812a748 CR3: 0156b000 CR4: 000007f0
[  760.718112] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  760.718112] DR6: ffff0ff0 DR7: 00000400
[  760.718113] Stack:
[  760.718117]  c10235ec c146a580 c108dd53 c13d58b6 0001482f 000001e2 000001e1 00000a80
[  760.718120]  00000007 c1037f67 c10382b5 00000001 c146a580 00000001 edcdb4e0 00000000
[  760.718123]  00000001 ee943ec0 c103d5a1 f51bb7f4 ee943ec0 000000b1 c106c73b f51bb7f4
[  760.718124] Call Trace:
[  760.718129]  [<c10235ec>] ? arch_trigger_all_cpu_backtrace+0x57/0x5f
[  760.718132]  [<c108dd53>] ? rcu_check_callbacks+0x17e/0x470
[  760.718135]  [<c1037f67>] ? raise_softirq_irqoff+0x5/0x2a
[  760.718137]  [<c10382b5>] ? raise_softirq+0x17/0x20
[  760.718140]  [<c103d5a1>] ? update_process_times+0x2f/0x39
[  760.718142]  [<c106c73b>] ? tick_sched_handle+0x37/0x43
[  760.718144]  [<c106c91e>] ? tick_sched_timer+0x28/0x4b
[  760.718145]  [<c106c8f6>] ? tick_sched_do_timer+0x2f/0x2f
[  760.718149]  [<c104d3a5>] ? __run_hrtimer+0x8e/0x12e
[  760.718151]  [<c104dc59>] ? hrtimer_interrupt+0x1a8/0x305
[  760.718164]  [<c1022b3a>] ? smp_apic_timer_interrupt+0x55/0x64
[  760.718167]  [<c1310b7c>] ? apic_timer_interrupt+0x34/0x3c
[  760.718171]  [<f8370001>] ? usb_otg_state_string+0x1/0x13 [usb_common]
[  760.718177]  [<c126007b>] ? skb_copy_datagram_const_iovec+0xf/0x196
[  760.718180]  [<f8709078>] ? peak_pci_post_irq+0x12/0x1b [peak_pci]
[  760.718183]  [<f88e7adf>] ? sja1000_interrupt+0x444/0x456 [sja1000]
[  760.718187]  [<c121f27b>] ? add_interrupt_randomness+0x34/0x131
[  760.718191]  [<c1087cf3>] ? irq_thread_fn+0x21/0x21
[  760.718193]  [<c1087d08>] ? irq_forced_thread_fn+0x15/0x38
[  760.718195]  [<c1088494>] ? irq_thread+0x7e/0x169
[  760.718197]  [<c108857f>] ? irq_thread+0x169/0x169
[  760.718198]  [<c1088416>] ? wake_threads_waitq+0x31/0x31
[  760.718200]  [<c104a79e>] ? kthread+0x68/0x6d
[  760.718203]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
[  760.718205]  [<c104a736>] ? __kthread_parkme+0x50/0x50
[  760.718221] Code: 00 8d bc 27 00 00 00 00 eb 0e 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 48 75 fd 48 c3 ff 15 94 17 48 c1 c3 64 8b 15 dc 50 56 c1 <6b> d2 3e c1 e0 02 f7 e2 8d 42 01 e9 e2 ff ff ff 69 c0 c7 10 00
[  760.718223] NMI backtrace for cpu 0
[  760.718225] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 3.10.11-rt7-can #6
[  760.718226] Hardware name: xxxxxx
[  760.718227] task: f4c70bc0 ti: f4c7e000 task.ti: f4c7e000
[  760.718228] EIP: 0060:[<c131063c>] EFLAGS: 00000002 CPU: 0
[  760.718231] EIP is at _raw_spin_unlock_irq+0x3/0x43
[  760.718232] EAX: f51b2640 EBX: ee34de00 ECX: f515a000 EDX: f4c70bc0
[  760.718233] ESI: f51b2640 EDI: 00000000 EBP: 00000000 ESP: f4c7fec0
[  760.718234]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  760.718235] CR0: 8005003b CR2: b7721484 CR3: 2ea77000 CR4: 000007f0
[  760.718237] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  760.718237] DR6: ffff0ff0 DR7: 00000400
[  760.718238] Stack:
[  760.718241]  c1052acd 6b2cb6d6 ef2a3c00 f51b2640 f4c70bc0 c130fa2f ee34de00 000000b1
[  760.718244]  c1565640 1e17e089 000000b1 c1565640 c103461e f4c70bc0 c10546d3 f515d488
[  760.718248]  f4c70bc0 c151043c f4c7ff3c c1037c06 00000000 00000004 f4c70bc0 f4c70bc0
[  760.718248] Call Trace:
[  760.718252]  [<c1052acd>] ? finish_task_switch+0x38/0x9d
[  760.718254]  [<c130fa2f>] ? __schedule+0x385/0x41e
[  760.718257]  [<c103461e>] ? unpin_current_cpu+0xb/0x45
[  760.718259]  [<c10546d3>] ? migrate_enable+0x18f/0x19c
[  760.718261]  [<c1037c06>] ? do_current_softirqs+0x209/0x26e
[  760.718263]  [<c108e2f0>] ? rcu_note_context_switch+0x13b/0x14c
[  760.718265]  [<c130fb84>] ? schedule+0x5e/0x6e
[  760.718267]  [<c10505a6>] ? smpboot_thread_fn+0x233/0x2a5
[  760.718269]  [<c130fb84>] ? schedule+0x5e/0x6e
[  760.718271]  [<c1050373>] ? test_ti_thread_flag+0x7/0x7
[  760.718272]  [<c104a79e>] ? kthread+0x68/0x6d
[  760.718275]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
[  760.718277]  [<c104a736>] ? __kthread_parkme+0x50/0x50
[  760.718293] Code: 85 c0 74 07 e8 ae f4 ff ff eb 15 89 e0 ba 09 00 00 00 25 00 e0 ff ff e8 6e 0c d6 ff 85 c0 75 e4 8b 04 24 e9 c1 76 d2 ff 80 00 01 <fb> 66 66 90 66 90 b8 01 00 00 00 e8 fe 27 00 00 89 e0 ba 03 00
[  760.718294] NMI backtrace for cpu 2
[  760.718296] CPU: 2 PID: 3195 Comm: irq/18-can12 Not tainted 3.10.11-rt7-can #6
[  760.718297] Hardware name: xxxxxx
[  760.718298] task: ee2bb4e0 ti: edd34000 task.ti: edd34000
[  760.718299] EIP: 0060:[<f8709078>] EFLAGS: 00000202 CPU: 2
[  760.718305] EIP is at peak_pci_post_irq+0x12/0x1b [peak_pci]
[  760.718306] EAX: ef66ee1c EBX: ef66e800 ECX: f8590003 EDX: f859a000
[  760.718307] ESI: 00000385 EDI: f864a01c EBP: ef66ed40 ESP: edd35efc
[  760.718308]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  760.718309] CR0: 8005003b CR2: b7749000 CR3: 2eae3000 CR4: 000007f0
[  760.718310] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  760.718311] DR6: ffff0ff0 DR7: 00000400
[  760.718312] Stack:
[  760.718315]  f88e7adf c121f27b ee2bb413 000344d2 edd83748 00000001 ef08d200 edd83748
[  760.718319]  eea248c0 f4e44900 ee2bb4e0 c1087cf3 c1087d08 f4e44900 eea248c0 ee2bb4e0
[  760.718322]  c1088494 eea248e0 ee2bb4e0 2f86ad9c 00000000 00000000 00000000 00000000
[  760.718323] Call Trace:
[  760.718326]  [<f88e7adf>] ? sja1000_interrupt+0x444/0x456 [sja1000]
[  760.718329]  [<c121f27b>] ? add_interrupt_randomness+0x34/0x131
[  760.718332]  [<c1087cf3>] ? irq_thread_fn+0x21/0x21
[  760.718334]  [<c1087d08>] ? irq_forced_thread_fn+0x15/0x38
[  760.718336]  [<c1088494>] ? irq_thread+0x7e/0x169
[  760.718338]  [<c108857f>] ? irq_thread+0x169/0x169
[  760.718340]  [<c1088416>] ? wake_threads_waitq+0x31/0x31
[  760.718342]  [<c104a79e>] ? kthread+0x68/0x6d
[  760.718344]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
[  760.718346]  [<c104a736>] ? __kthread_parkme+0x50/0x50
[  760.718364] Code: c3 8b 80 b8 00 00 00 8d 04 90 8a 00 c3 8b 80 b8 00 00 00 8d 04 90 88 08 c3 8b 80 b0 00 00 00 eb 05 8b 08 66 89 11 8b 10 66 8b 0a <8b> 50 08 66 85 d1 75 ee c3 57 56 89 ce 53 89 c3 83 ec 14 31 c0
[  760.718365] NMI backtrace for cpu 3
[  760.718367] CPU: 3 PID: 2867 Comm: irq/19-can2 Not tainted 3.10.11-rt7-can #6
[  760.718368] Hardware name: xxxxxx
[  760.718369] task: edcdc0a0 ti: edd14000 task.ti: edd14000
[  760.718370] EIP: 0060:[<f8709078>] EFLAGS: 00000202 CPU: 3
[  760.718372] EIP is at peak_pci_post_irq+0x12/0x1b [peak_pci]
[  760.718373] EAX: ef66c61c EBX: ef66c000 ECX: f82700c3 EDX: f8270000
[  760.718375] ESI: 00000127 EDI: f827881c EBP: ef66c540 ESP: edd15efc
[  760.718376]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  760.718377] CR0: 8005003b CR2: b76fc000 CR3: 2eae3000 CR4: 000007f0
[  760.718378] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  760.718379] DR6: ffff0ff0 DR7: 00000400
[  760.718379] Stack:
[  760.718382]  f88e7adf c121f27b edcdc013 000344d2 edcecdc8 00000001 ef127200 edcecdc8
[  760.718386]  edc229c0 f4e449c0 edcdc0a0 c1087cf3 c1087d08 f4e449c0 edc229c0 edcdc0a0
[  760.718389]  c1088494 edc229e0 edcdc0a0 15b2b9b8 00000000 00000000 00000000 00000000
[  760.718389] Call Trace:
[  760.718392]  [<f88e7adf>] ? sja1000_interrupt+0x444/0x456 [sja1000]
[  760.718394]  [<c121f27b>] ? add_interrupt_randomness+0x34/0x131
[  760.718397]  [<c1087cf3>] ? irq_thread_fn+0x21/0x21
[  760.718398]  [<c1087d08>] ? irq_forced_thread_fn+0x15/0x38
[  760.718400]  [<c1088494>] ? irq_thread+0x7e/0x169
[  760.718402]  [<c108857f>] ? irq_thread+0x169/0x169
[  760.718404]  [<c1088416>] ? wake_threads_waitq+0x31/0x31
[  760.718405]  [<c104a79e>] ? kthread+0x68/0x6d
[  760.718408]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
[  760.718409]  [<c104a736>] ? __kthread_parkme+0x50/0x50
[  760.718426] Code: c3 8b 80 b8 00 00 00 8d 04 90 8a 00 c3 8b 80 b8 00 00 00 8d 04 90 88 08 c3 8b 80 b0 00 00 00 eb 05 8b 08 66 89 11 8b 10 66 8b 0a <8b> 50 08 66 85 d1 75 ee c3 57 56 89 ce 53 89 c3 83 ec 14 31 c0

No idea ...

Regards,
Oliver

