From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 10 Dec 2013 10:32:02 +0100
Message-ID: <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <52831FC7.3040509@hartkopp.net>
 <f323c29b9730c877729322453b9e4ec9@grandegger.com>
 <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net>
 <85256584a266750b1330cfae8bebd55c@grandegger.com>
 <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com>
 <52892B21.9000501@grandegger.com>
 <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>
 <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
 <333c0fd4238558062478212eb0704b04@grandegger.com>
 <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:53516 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab3LJJcG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Dec 2013 04:32:06 -0500
In-Reply-To: <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On Tue, 10 Dec 2013 00:05:35 -0800, Austin Schuh <austin@peloton-tech.com>

wrote:

> Hi Wolfgang,

> 

> On Mon, Dec 9, 2013 at 11:49 PM, Wolfgang Grandegger <wg@grandegger.com>

> wrote:

>> Hi Austin,

>>

>> On Mon, 9 Dec 2013 13:54:24 -0800, Austin Schuh

<austin@peloton-tech.com>

>> wrote:

>>> Ok.  I succeeded in getting a trace from when the IRQ gets disabled.

>>> It took ~2.5 days to trigger it with tracing enabled, and it takes

>>> much less time (typically under a day) with tracing disabled.  The

>>> trace is at http://98.207.84.11/sja1000_crash.trace.bz2  It is 42 MB

>>> compressed and 1 GB uncompressed.

>>

>> Could you please tell use what trigger you used (how and when did you

>> stop the trace) and what the test scenario was (TX on CAN0, RX on CAN1,

>> etc.).

>>

>> Wolfgang.

> 

> Whoops, forgot that critical detail...

> 

> can0 is connected to a can bus at 250k with a bunch of other can

> devices, but for this test, they are all off and nothing is happening

> on that bus.



Is CAN0 "up"? I ask because I found in the trace:



     irq/18-can0-1863  [002] .....11 360026.316603: peak_pci_post_irq

<-sja1000_interrupt



> 

> can1 is connected to a can bus at 500k with 2 other can devices.  They

> are filling the bus up to about 50% bus load.  I am sending nothing on

> can1 for this test.  There is very little load on the system at the

> time besides running candump on can1 and streaming that back over ssh.



OK, only RX.



> 

> The trigger is in kernel/irq/spurrious.c and triggers when IRQ 18 gets

> disabled.  That is the only modification to the kernel.



You mean here:



  void note_interrupt(unsigned int irq, struct irq_desc *desc,

  		    irqreturn_t action_ret)

  {

	...

	if (unlikely(desc->irqs_unhandled > 99900)) {

		/*

		 * The interrupt is stuck

		 */

 		__report_bad_irq(irq, desc, action_ret);

		/*

  		* Now kill the IRQ

  		*/

  		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);

  		desc->istate |= IRQS_SPURIOUS_DISABLED;

 		desc->depth++;

 		irq_disable(desc);



		mod_timer(&poll_spurious_irq_timer,

		jiffies + POLL_SPURIOUS_IRQ_INTERVAL);

	}

	desc->irqs_unhandled = 0;

  }



I see that note_interrupt() is called at high rate before it gets

disabled:



     irq/18-can1-1890  [001] ....... 360026.315459: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] ....... 360026.315626: note_interrupt

<-irq_thread

     irq/18-can0-1863  [002] ....... 360026.315627: note_interrupt

<-irq_thread

     irq/18-can1-1890  [001] ....... 360026.315683: note_interrupt

<-irq_thread

     irq/18-can0-1863  [002] ....... 360026.315873: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] ....... 360026.315878: note_interrupt

<-irq_thread

     irq/18-can1-1890  [001] ....... 360026.315984: note_interrupt

<-irq_thread

     irq/18-can0-1863  [002] ....... 360026.316122: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] ....... 360026.316140: note_interrupt

<-irq_thread

     irq/18-can1-1890  [001] ....... 360026.316184: note_interrupt

<-irq_thread

     irq/18-can0-1863  [002] ....... 360026.316358: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] ....... 360026.316361: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] ....... 360026.316361: __report_bad_irq

<-note_interrupt

     irq/18-can1-1890  [001] ....... 360026.316437: note_interrupt

<-irq_thread

     irq/18-can0-1863  [002] ....... 360026.316608: note_interrupt

<-irq_thread

     irq/18-can1-1890  [001] ....... 360026.316714: note_interrupt

<-irq_thread

 irq/18-ata_gene-219   [003] d...1.. 360026.317050:

_raw_spin_unlock_irqrestore <-note_interrupt

 irq/18-ata_gene-219   [003] ....... 360026.317051: printk

<-note_interrupt

 irq/18-ata_gene-219   [003] ....... 360026.317541: irq_disable

<-note_interrupt

 irq/18-ata_gene-219   [003] ....... 360026.317541: mod_timer

<-note_interrupt



But it will be difficult to locate what happened 99900 irq before. Anyway,

I will

have a closer look this evening.



Wolfgang.




