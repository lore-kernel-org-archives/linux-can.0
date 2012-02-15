From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 20:46:06 +0100
Message-ID: <4F3C0B7E.1060806@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net> <4F3B58D1.1040804@grandegger.com> <4F3B9C86.8030105@peak-system.com> <4F3BC9DB.6040604@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:57466 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab2BOTqO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 14:46:14 -0500
In-Reply-To: <4F3BC9DB.6040604@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>


>> I would also have say that before, but I checked that IRQ_NONE may be
>> processed as spurious, so I don't even know, for the moment. LDD3
>> chapter 10 also says:
>>
>>> Interrupt handlers should return a value indicating whether there was
>>> actually an
>>> interrupt to handle. If the handler found that its device did, indeed,
>>> need attention, it
>>> should return IRQ_HANDLED; otherwise the return value should be IRQ_NONE.
>>
>> So, what does this "need attention" stands for? Since the device is
>> unplugged, we could say that it didn't need any attention anymore...
>> But, on the other hand, the ems_pcmcia driver does return IRQ_HANDLED
>> when its private check fails to detect the card and it has been
>> approved, so, where is the truth? Near the perfection? ;-)
> 
> From http://lxr.linux.no/#linux+v3.2.6/include/linux/irqreturn.h:
> 
>   IRQ_NONE            interrupt was not from this device


See:

http://lxr.linux.no/#linux+v3.2.6/kernel/irq/spurious.c#L178

I think at plug-out we get very little IRQ_NONE return values that should be
ok not to damage the entire handling of that specific irq line ...

Regards,
Oliver
