From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Thu, 12 Dec 2013 18:38:25 +0100
Message-ID: <52A9F491.3060406@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.
 net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com> <52A953F3.3000605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:60618 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab3LLRi3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2013 12:38:29 -0500
In-Reply-To: <52A953F3.3000605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On 12.12.2013 07:13, Oliver Hartkopp wrote:
> On 11.12.2013 20:27, Wolfgang Grandegger wrote:

>> BTW, does the problem show up if only one can is active? Austin tests
>> did just RX on can1, but can0 was obviously up (but no traffic).
> 
> There was a case that the IRQ line from can9, can10, can11, can12 failed with
> an error messaged pointing to can10. All four interfaces where up but only
> can9 had traffic at that time.

Hi Wolfgang,

here's my latest investigation result.

The setup still has (only) can9 with traffic and after a modification of
linux/kernel/irq/spurious.c (patch below) I got this:

[ 1117.957651] irq 17: nobody cared (try booting with the "irqpoll" option)
[ 1117.959910] CPU: 0 PID: 3498 Comm: irq/17-can9 Not tainted 3.10.11-rt7-can #6
[ 1117.959913] Hardware name: xxxxxx
[ 1117.959916]  00000000 c1089114 f4e44840 00000001 00000011 c1089490 ee84e780 f4e44840
[ 1117.959924]  ee84e780 ed876fa0 c1087cf3 c10884a9 ee84e7a0 ed876fa0 16edf7d9 00000000
[ 1117.959932]  00000000 00000000 00000000 c108857f eea53de4 ee84e780 c1088416 ef0a1f90
[ 1117.959939] Call Trace:
[ 1117.959949]  [<c1089114>] ? __report_bad_irq+0x18/0xbe
[ 1117.959953]  [<c1089490>] ? note_interrupt+0x118/0x194
[ 1117.959957]  [<c1087cf3>] ? irq_thread_fn+0x21/0x21
[ 1117.959960]  [<c10884a9>] ? irq_thread+0x93/0x169
[ 1117.959964]  [<c108857f>] ? irq_thread+0x169/0x169
[ 1117.959968]  [<c1088416>] ? wake_threads_waitq+0x31/0x31
[ 1117.959973]  [<c104a79e>] ? kthread+0x68/0x6d
[ 1117.959979]  [<c13143b7>] ? ret_from_kernel_thread+0x1b/0x28
[ 1117.959982]  [<c104a736>] ? __kthread_parkme+0x50/0x50
[ 1117.959986] handlers:
[ 1117.962184] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can8 PITA 0x0001
[ 1117.962190] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can10 PITA 0x0001
[ 1117.962196] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can11 PITA 0x0001
[ 1117.962201] [<c1087bdb>] irq_default_primary_handler threaded [<f86b169b>] sja1000_interrupt [sja1000]device can9 PITA 0x0001
[ 1117.962202] Disabling IRQ #17

The value in the PITA register is 0x0001 which is from can9 according to
peak_pci_icr_masks[] (2nd element).

So obviously the flag was set and not consumed correctly ...

Regards,
Oliver

ps. here's the hack to print the PITA register value in spurious.c

As I was sure that I only have SJA1000 devices the dereferencing of the
pointers from dev_id was feasible. 

--- spurious.c-orig	2013-12-12 15:46:03.508063829 +0100
+++ spurious.c	2013-12-12 16:52:32.171719932 +0100
@@ -12,6 +12,8 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/netdevice.h>
+#include <linux/can/dev.h>
 #include <linux/timer.h>
 
 #include "internals.h"
@@ -24,6 +26,36 @@
 static int irq_poll_cpu;
 static atomic_t irq_poll_active;
 
+struct peak_pci_chanx {
+	void __iomem *cfg_base;		/* Common for all channels */
+	struct net_device *prev_dev;	/* Chain of network devices */
+	u16 icr_mask;			/* Interrupt mask for fast ack */
+	void *pciec_card;	/* only for PCIeC LEDs */
+};
+struct sja1000_privx {
+	struct can_priv can;	/* must be the first member */
+	void *echo_skb;
+
+	/* the lower-layer is responsible for appropriate locking */
+	u8 (*read_reg) (const struct sja1000_privx *priv, int reg);
+	void (*write_reg) (const struct sja1000_privx *priv, int reg, u8 val);
+	void (*pre_irq) (const struct sja1000_privx *priv);
+	void (*post_irq) (const struct sja1000_privx *priv);
+
+	void *priv;		/* for board-specific data */
+	struct net_device *dev;
+
+	void __iomem *reg_base;	 /* ioremap'ed address to registers */
+	unsigned long irq_flags; /* for request_irq() */
+	spinlock_t cmdreg_lock;  /* lock for concurrent cmd register writes */
+
+	u16 flags;		/* custom mode flags */
+	u8 ocr;			/* output control register */
+	u8 cdr;			/* clock divider register */
+};
+#define PITA_ICR                0x00    /* Interrupt control register */
+
+
 /*
  * We wait here for a poller to finish.
  *
@@ -189,6 +221,7 @@
 {
 	struct irqaction *action;
 	unsigned long flags;
+	struct net_device *netdev;
 
 	if (bad_action_ret(action_ret)) {
 		printk(KERN_ERR "irq event %d: bogus return value %x\n",
@@ -209,11 +242,23 @@
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	action = desc->action;
 	while (action) {
+
+		struct sja1000_privx *priv;
+		struct peak_pci_chanx *chan;
+
 		printk(KERN_ERR "[<%p>] %pf", action->handler, action->handler);
 		if (action->thread_fn)
 			printk(KERN_CONT " threaded [<%p>] %pf",
 					action->thread_fn, action->thread_fn);
+
+		netdev = (struct net_device *) action->dev_id;
+		priv = netdev_priv(netdev);
+		chan = priv->priv;
+		printk(KERN_CONT "device %s PITA 0x%04X", netdev->name,
+		       readw(chan->cfg_base + PITA_ICR));
+
 		printk(KERN_CONT "\n");
+
 		action = action->next;
 	}
 	raw_spin_unlock_irqrestore(&desc->lock, flags);

