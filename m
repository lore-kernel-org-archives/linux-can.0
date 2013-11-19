From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH] can: fix sja1000 pre_irq/post_irq handling
Date: Tue, 19 Nov 2013 01:05:04 +0100
Message-ID: <201311190105.04542.pisa@cmp.felk.cvut.cz>
References: <5288CFEF.3060701@hartkopp.net> <5289B0EF.3070507@hartkopp.net> <20131118194833.GC1268@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:56699 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3KSAFw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Nov 2013 19:05:52 -0500
In-Reply-To: <20131118194833.GC1268@vandijck-laurijssen.be>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>, Thomas Gleixner <tglx@linutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

On Monday 18 of November 2013 20:48:33 Kurt Van Dijck wrote:
> Oliver,
>
> just 2 small remarks below.
>
> On Mon, Nov 18, 2013 at 07:17:19AM +0100, Oliver Hartkopp wrote:
> > On 17.11.2013 21:51, Wolfgang Grandegger wrote:
> > So what's the error here?
>
> The accuracy of reading register SJA1000_IR remains unbeaten when
> deciding if an SJA1000 has interrupts pending.
> Any pre_irq() return value is close approximation.
>
> > Btw. by now there's no user of priv->pre_irq() anyway.
>

The use of some PCI to local-bus bridge register to check
SJA1000 interrupt signal/pin state can be much much faster
then SJA1000 IR register access for some hardware. SJA1000 has multiplexed
bus and quite low maximal allowed frequency when compared to today
PCI/PCIe connection (even that PCIe has quite some overhead and latencies
for single register read too - it is optimized for stream/net/video data,
but that is different story).

I have found some while to go through kernel interrupt handling
to refresh my memory and state is as I have it in memory from years ago.

There could be present pathological situation of more edge triggered interrupt 
sources which do not provide way to read actual state of interrupt
line behind bridge read through some interrupt controller/bridge register.
(if the register can be read after interrupts handling then it can be
used to start next loop through handles) But if such (considered broken)
local bus is connected through local bus to PCI bridge then there
are significant problems. Default PCI interrupts behavior is/expect
level triggered logic. It may be possible to reconfigure given
PCI interrupt to IRQ_TYPE_EDGE_RISING or FAILING type, there was even
some set of kernel parameters options for that. But I expect that it
is not possible to request from CAN board driver easily or at all
on x86 PC architecture.

Anyway, even if IRQ_TYPE_EDGE_FAILING type of IRQ is selected then
there is probably problem in

linux-devel/kernel/irq/chip.c:
       handle_edge_irq()

Because it calls handle_irq_event() only once if there is present
next sequence of events

  - chip B signals IRQ
  - handle_irq_event() is called
  - chip A resturns IRQ_NONE
  - chip A event arrives and A signals IRQ but line is held
    by B so no edge appears and IRQS_PENDING is not set
  - chip B is handled stops signalling, returns IRQ_HANDLED,
    but IRQ line is still held by chip A

loop condition in handle_edge_irq() is false and returns even that
hidden IRQ line is active still. The safe handling for such case is
to call handle_irq_event() as long as it does not return IRQ_NONE
(or do as many iterations through action next as one cycle with IRQ_NONE
is reached).
But that such change in handle_edge_irq() or handle_irq_event_percpu()
cannot be done even for testing because last call to handle_irq_event()
would finish with IRQ_NONE and that triggers spurious interrupt handling

linux-devel/kernel/irq/spurious.c:
       note_interrupt()

after couple of IRQs arrival. So even more changes would be required
to support that corner case.

Concussion:

My understanding is that if there is no register which allows to read
actual interrupt signal state behind bridge then there is no clean
kernel level solution and local loop in the driver over sibling
chips behind bridge with spin-locking etc. is required.

If the register to read actual wire-ored or all line states is present
then option is to register IRQ chip for given PCI-localbus bridge
and connect SJA1000 IRQs handling to this IRQ chip node.

I am sending copy to Thomas Gleixner because he can find most quickly
if I am wrong and generic IRQ infrastructure has solution for this
problem or my analysis is wrong (which would be win for solution
of the initially reported problem).

Best wishes,

             Pavel

