From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 23:00:15 +0100
Message-ID: <5283F66F.9060801@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5654b3a33cce286efc0ef2729ca33f03@grandegger.com> <5283C7F6.6000004@hartkopp.net> <5283D32F.3080808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:60251 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3KMWAS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 17:00:18 -0500
In-Reply-To: <5283D32F.3080808@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Stephane Grosjean <s.grosjean@peak-system.com>, Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org



On 13.11.2013 20:29, Wolfgang Grandegger wrote:
> Hi Oliver,
> 
> On 11/13/2013 07:41 PM, Oliver Hartkopp wrote:
>> On 13.11.2013 10:52, Wolfgang Grandegger wrote:
>>
>>>
>>> In Linux-CAN we have something similar:
>>>
>>> http://lxr.linux.no/#linux/drivers/net/can/sja1000/ems_pcmcia.c#L90
>>>
>>
>> Indeed.
>>
>> I think reworking the sja1000.c driver (as suggested by Kurt) won't make it.
>> It only touches the generic irq handling.
>>
>> The peak_pci driver creates (depending on the number of channels) e.g.
>> two/four AFAICS pretty *independent* sja1000 netdevices.
>>
>> Currently at the end of the generic sja1000 interrupt handling the according
>> irq bit in the PITA is cleared. This is not necessarily at the end of the
>> interrupt chain.
>>
>> What we would need to set up a similar handling as we have in EMS PCMCIA or
>> the EMS PCI (referenced by Pavel) is a "group of sja1000 netdevices" which is
>> placed on a single PEAK PCI adapter.
> 
> Why? Normally we do not have such problems with level sensitive
> interrupts. Also so far it's pure speculation that this might be the
> cause of the problem.

Yes it is speculation.

I just wanted to point out what are the differences from the EMS PCMCIA
implementation to the current peak_pci driver.

I'm using a system with many PEAK cPCI four channel cards without any issues
with a mainline kernel. No idea why it fails like this in the -rt system.

Regards,
Oliver

> 
>> Indeed there is already a chain of sja1000 netdevices:
>>
>> http://lxr.linux.no/#linux+v3.12/drivers/net/can/sja1000/peak_pci.c#L645
>>
>> BUT this is only used to clean up all channels when the PCI device is removed
>> or some errors occur at creation time.
>>
>> IMO the existing chain of netdevices is not only needed for the device removal
>> but also for the interrupt handling.
>>
>> When ever the interrupt for the PCI adapter occurs all channels have to be
>> handled (in a private peak_pci_interrupt() function) and finally the PITA has
>> to be cleared there too.
>>
>> That change won't make use of the possibility to clear single IRQ bits in the
>> PITA anymore. And the PITA has to be checked first (e.g. to check if we have a
>> new interrupt somewhere later in the interrupt chain) to skip the irq handling
>> when it's obsolete.
>>
>> Any thoughts?
> 
> See my comments above. If the PEAK PCI hardware is setting the levels
> correctly, there is no problem with the current interrupt handling.
> 
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
