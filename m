From: Austin Schuh <austin@peloton-tech.com>
Subject: sja1000 interrupt problem
Date: Mon, 7 Oct 2013 17:47:48 -0700
Message-ID: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:39631 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab3JHArt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 20:47:49 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so17815061ieb.14
        for <linux-can@vger.kernel.org>; Mon, 07 Oct 2013 17:47:48 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am seeing the following problem with my Peak miniPCIe card.  After
being up for a long time and not having any programs listening to the
CAN traffic, I get the following message from dmesg, and then I start
not receiving packets (Some get through, but not all of them.)

Is this a known issue?  Are there any tests that I can run to help
isolate and fix the problem?

Thanks,
    Austin Schuh

$ lspci -v -s 05:00.0
05:00.0 Network controller: PEAK-System Technik GmbH Device 0008 (rev 02)
        Subsystem: PEAK-System Technik GmbH Device 0005
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at e0510000 (32-bit, non-prefetchable) [size=64K]
        Memory at e0500000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 0
        Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [90] Express Endpoint, MSI 00
        Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0
Len=00c <?>
        Kernel driver in use: peak_pci

$ uname -a
Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1
(2013-09-10) x86_64 GNU/Linux

$ dmesg
--- snip ---
[105918.136633] irq 18: nobody cared (try booting with the "irqpoll" option)
[105918.136763] CPU: 1 PID: 202 Comm: irq/18-ata_gene Not tainted
3.10-3-rt-amd64 #1 Debian 3.10.11-1
[105918.136768] Hardware name: CompuLab Intense-PC/Intense-PC, BIOS
CR_2.2.0.377 X64 04/10/2013
[105918.136777]  ffffffff8139f8fc 000000000000003c ffffffff810a2d43
ffff88042a4b5600
[105918.136781]  0000000000000000 ffff88042750ece0 ffffffff810a3182
ffffffff814089d0
[105918.136785]  ffff880426527c80 ffff88042a4b5600 ffff88042750ece0
ffffffff810a13d7
[105918.136791] Call Trace:
[105918.136805]  [<ffffffff8139f8fc>] ? dump_stack+0xd/0x17
[105918.136814]  [<ffffffff810a2d43>] ? __report_bad_irq+0x21/0xc1
[105918.136819]  [<ffffffff810a3182>] ? note_interrupt+0x16d/0x1ff
[105918.136824]  [<ffffffff810a13d7>] ? irq_thread_fn+0x30/0x30
[105918.136828]  [<ffffffff810a1d9c>] ? irq_thread+0xaf/0x190
[105918.136833]  [<ffffffff810a1e7d>] ? irq_thread+0x190/0x190
[105918.136837]  [<ffffffff810a1ced>] ? wake_threads_waitq+0x3a/0x3a
[105918.136843]  [<ffffffff8105a909>] ? kthread+0x81/0x89
[105918.136848]  [<ffffffff8105a888>] ? __kthread_parkme+0x5c/0x5c
[105918.136854]  [<ffffffff813a75fc>] ? ret_from_fork+0x7c/0xb0
[105918.136858]  [<ffffffff8105a888>] ? __kthread_parkme+0x5c/0x5c
[105918.136861] handlers:
[105918.136962] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa00db857>] ata_bmdma_interrupt [libata]
[105918.136972] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[105918.136980] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[105918.136981] Disabling IRQ #18
[202007.935715] irq 18: nobody cared (try booting with the "irqpoll" option)
[202007.935860] CPU: 0 PID: 202 Comm: irq/18-ata_gene Not tainted
3.10-3-rt-amd64 #1 Debian 3.10.11-1
[202007.935865] Hardware name: CompuLab Intense-PC/Intense-PC, BIOS
CR_2.2.0.377 X64 04/10/2013
[202007.935874]  ffffffff8139f8fc 000000000000003c ffffffff810a2d43
ffff88042a4b5600
[202007.935877]  0000000000000000 ffff88042750ece0 ffffffff810a3182
ffffffff814089d0
[202007.935881]  ffff880426527c80 ffff88042a4b5600 ffff88042750ece0
ffffffff810a13d7
[202007.935888] Call Trace:
[202007.935901]  [<ffffffff8139f8fc>] ? dump_stack+0xd/0x17
[202007.935910]  [<ffffffff810a2d43>] ? __report_bad_irq+0x21/0xc1
[202007.935915]  [<ffffffff810a3182>] ? note_interrupt+0x16d/0x1ff
[202007.935920]  [<ffffffff810a13d7>] ? irq_thread_fn+0x30/0x30
[202007.935925]  [<ffffffff810a1d9c>] ? irq_thread+0xaf/0x190
[202007.935930]  [<ffffffff810a1e7d>] ? irq_thread+0x190/0x190
[202007.935936]  [<ffffffff810a1ced>] ? wake_threads_waitq+0x3a/0x3a
[202007.935944]  [<ffffffff8105a909>] ? kthread+0x81/0x89
[202007.935950]  [<ffffffff8105a888>] ? __kthread_parkme+0x5c/0x5c
[202007.935957]  [<ffffffff813a75fc>] ? ret_from_fork+0x7c/0xb0
[202007.935961]  [<ffffffff8105a888>] ? __kthread_parkme+0x5c/0x5c
[202007.935964] handlers:
[202007.936067] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa00db857>] ata_bmdma_interrupt [libata]
[202007.936076] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[202007.936084] [<ffffffff810a126f>] irq_default_primary_handler
threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[202007.936086] Disabling IRQ #18
