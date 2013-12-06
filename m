From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Fri, 6 Dec 2013 10:32:37 +0000 (UTC)
Message-ID: <loom.20131206T112023-62@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <ac6a947c7ec842f67e9d23abd877b884@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53565 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757241Ab3LFKdA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Dec 2013 05:33:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VosiQ-0002Oq-DO
	for linux-can@vger.kernel.org; Fri, 06 Dec 2013 11:32:58 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 11:32:58 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 11:32:58 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
>...
> 
> > I've just studied sja1000.c I do not know yet, if it is healthy.
> 
> This is normally due to hardware/electrical problems. It has nothing to do
> 
> with software. Well, is there *any* relation to the patch mentioned in the
> 
> subject? I mean, does the problem *not* show up without that patch.


Patch solved a problem with unhandled IRQs. The original problem is solved.
CAN arbitration itself is for me a feature, which I as a programmer want to
control and use it as I want. Similar other IRQs.

> 
> > May be something in upper levels will be not anymore well handled. 
> 
> > I've changed a code in a function (see IRQ_ALI part):
> 
> > 
> 
> > static void set_normal_mode(struct net_device *dev)
> 
> > {
> 
> >   ...
> 
> >                if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> 
> >                     priv->write_reg(priv, SJA1000_IER, IRQ_ALL &
> 
> ~IRQ_ALI);
> 
> >                else
> 
> >                     priv->write_reg(priv, SJA1000_IER,
> 
> >                                     IRQ_ALL & ~(IRQ_BEI | IRQ_ALI));
> 
> >   ...
> 
> > }
> 
> > 
> 
> > But I prefare to make some kind of "ioctl" support for that. There are
> 
> > applications, where it shall not happend. Concurrently I've played with
> 
> > taskset and priorities. 
> 
> > 
> 
> > $ ps -e -o pid,rtprio,comm | grep "irq/19"
> 
> >    56     89 irq/19-uhci_hcd
> 
> >  1877     88 irq/19-can0
> 
> >  1922     88 irq/19-can1
> 
> > 
> 
> > I do not still understand, what does it mean "irq/19-uhci_hcd". Which is
> 
> > also active, even I do not have any USB device. Mouse and keyboard are
> 
> > connected through PS2.
> 
> Seem that the interrupts are shared. "$ cat /pric/interrupts" provide
> 
> further
> 
> information.

Yes, it is so.

$ cat /proc/interrupts
           CPU0       CPU1
  0:        127          0   IO-APIC-edge      timer
  1:       5582          0   IO-APIC-edge      i8042
  6:          3          0   IO-APIC-edge      floppy
  7:          1          0   IO-APIC-edge      parport0
  8:          1          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:      30627          0   IO-APIC-edge      i8042
 14:      43351          0   IO-APIC-edge      ata_piix
 15:     286242          0   IO-APIC-edge      ata_piix
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb5
 17:        370          0   IO-APIC-fasteoi   i801_smbus, snd_intel8x0
 18:     102206          0   IO-APIC-fasteoi   uhci_hcd:usb4, eth0
 19:  397673976          0   IO-APIC-fasteoi   uhci_hcd:usb3, can0, can1
 23:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
NMI:          1          1   Non-maskable interrupts
LOC:   15370305   11437013   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:     283821   18429091   Rescheduling interrupts
CAL:       9623       3662   Function call interrupts
TLB:       7408      66943   TLB shootdowns
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          0          0   Machine check polls
ERR:          0
MIS:          0

I prefer to switch off it from a linux side. I will look for that.


> 
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 




