From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 14:52:03 +0000 (UTC)
Message-ID: <loom.20121121T153200-305@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54997 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898Ab2KUOwV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Nov 2012 09:52:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbBfA-0000Xp-D0
	for linux-can@vger.kernel.org; Wed, 21 Nov 2012 15:52:28 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 15:52:28 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 15:52:28 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> I'm a bit confused. Where is the application running? On this
> PCH-System? Or does an external node send messages, which are not
> received by the PCH-C_CAN?

The application is running on the PCH-System.  Here are the systems on the bus:

- PCH-System: Runs the application which sends the majority of CAN messages.
- External Node: Sends periodic CAN messages.
- CAN Monitor: Monitors all bus traffic.

The PCH-System sends 16 CAN messages successfully before transmission stops.
The CAN Monitor system successfully receives these messages.
As shown by the "ip" command output, the driver considers these messages
dropped, not transmitted.
The External Node system sends periodic messages, which I can see on the CAN
Monitor system.  The PCH-System does not receive these messages.

> OK, we still have a problem with TX and RX, most likely with interrupts.
> Could you please send a message on the PCH-System executing
> "cansend can0 123#abcdef":
> 
> - Does "candump any,0:0,#FFFFFFFF" report anything.

No, candump reports nothing.

> - Does the message show up on the bus (visiable to another node or
>   analyser)?

Yes, the message shows up on the bus.  The CAN Monitor system receives
the message.

> - Does the interrupt count increase? Check output of /proc/interrupts.

I'm not sure exactly which piece of data you're looking for, so here's
the entirety of /proc/interrupts:

           CPU0       CPU1
  0:   68369230          0   IO-APIC-edge      timer
  8:          1          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 16:      27694          0   IO-APIC-fasteoi   PCIe PME, PCIe PME, PCIe PME, PCI
e PME, ehci_hcd:usb2, ohci_hcd:usb6, ohci_hcd:usb7, ohci_hcd:usb8, gpio_pch, snd
_hda_intel
 18:          0          0   IO-APIC-fasteoi   mmc0, mmc1
 19:      22916          0   IO-APIC-fasteoi   ehci_hcd:usb1, ohci_hcd:usb3, ohc
i_hcd:usb4, ohci_hcd:usb5
 40:      83612          0   PCI-MSI-edge      ahci
 41:          0          0   PCI-MSI-edge      can0
 42:     176385          0   PCI-MSI-edge      eth0
NMI:       4569       4569   Non-maskable interrupts
LOC:    7625157   47016568   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:       4569       4569   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:    4979140    4962335   Rescheduling interrupts
CAL:        137        308   Function call interrupts
TLB:       2670       2578   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:        211        211   Machine check polls
ERR:          0
MIS:          0

Note that this test was run with v3 of the driver.

- Mike


