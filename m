From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Sat, 16 Nov 2013 22:42:10 +0100
Message-ID: <5287E6B2.8020709@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:44508 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3KPVmN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 16 Nov 2013 16:42:13 -0500
In-Reply-To: <201311131008.55018.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Wolfgang Grandegger <wg@grandegger.com>, Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

Hi all,

I would like to continue the discussion about Austins problem with the -rt kernel.

This problem addressed by Pavel should be handled correctly ...

> I have noticed that you speak about PITA in the thread.
> 
> There can be problem that local bus IRQs are shared
> and sensed as edge triggered on the PITa but PCI
> interrupt processing is selected for level sharing
> between PCI cards/sources. That means, when IRQ
> on the first SJA1000 chip is activated exactly after
> it was checked in ISR and before other chip's IRQ
> is cleared than you receive no more any IRQ until
> forced/polled check of the first chip.

... by this while statement in the current sja1000interrupt() function:

http://lxr.linux.no/#linux+v3.12/drivers/net/can/sja1000/sja1000.c#L503

AFAICS when the interrupt is handled in this manner finally the device
corresponding bit in the PITA is set in peak_pci_post_irq(), see:

http://lxr.linux.no/#linux+v3.12/drivers/net/can/sja1000/peak_pci.c#L538

I doubt that protecting peak_pci_post_irq() would help as it only handles the
device corresponding bit.

I don't know if the -rt kernel with the irq threads is more sensible to
IRQ_NONE return values that the mainline kernel.

Btw. I would try two more things with the sja1000.c driver:

1. Print the corresponding CAN device name and the point in the code before
returning IRQ_NONE to catch the problematic return site.

2. Replace all IRQ_NONE with IRQ_HANDLED for a test ...

Any other ideas?

Regards,
Oliver

