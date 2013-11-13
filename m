From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 19:41:58 +0100
Message-ID: <5283C7F6.6000004@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5654b3a33cce286efc0ef2729ca33f03@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:10756 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab3KMSmB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 13:42:01 -0500
In-Reply-To: <5654b3a33cce286efc0ef2729ca33f03@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

On 13.11.2013 10:52, Wolfgang Grandegger wrote:

> 
> In Linux-CAN we have something similar:
> 
> http://lxr.linux.no/#linux/drivers/net/can/sja1000/ems_pcmcia.c#L90
> 

Indeed.

I think reworking the sja1000.c driver (as suggested by Kurt) won't make it.
It only touches the generic irq handling.

The peak_pci driver creates (depending on the number of channels) e.g.
two/four AFAICS pretty *independent* sja1000 netdevices.

Currently at the end of the generic sja1000 interrupt handling the according
irq bit in the PITA is cleared. This is not necessarily at the end of the
interrupt chain.

What we would need to set up a similar handling as we have in EMS PCMCIA or
the EMS PCI (referenced by Pavel) is a "group of sja1000 netdevices" which is
placed on a single PEAK PCI adapter.

Indeed there is already a chain of sja1000 netdevices:

http://lxr.linux.no/#linux+v3.12/drivers/net/can/sja1000/peak_pci.c#L645

BUT this is only used to clean up all channels when the PCI device is removed
or some errors occur at creation time.

IMO the existing chain of netdevices is not only needed for the device removal
but also for the interrupt handling.

When ever the interrupt for the PCI adapter occurs all channels have to be
handled (in a private peak_pci_interrupt() function) and finally the PITA has
to be cleared there too.

That change won't make use of the possibility to clear single IRQ bits in the
PITA anymore. And the PITA has to be checked first (e.g. to check if we have a
new interrupt somewhere later in the interrupt chain) to skip the irq handling
when it's obsolete.

Any thoughts?

Regards,
Oliver
