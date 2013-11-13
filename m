From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 10:52:59 +0100
Message-ID: <5654b3a33cce286efc0ef2729ca33f03@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <52831FC7.3040509@hartkopp.net>
 <f323c29b9730c877729322453b9e4ec9@grandegger.com>
 <201311131008.55018.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:52053 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758999Ab3KMJxB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 13 Nov 2013 04:53:01 -0500
In-Reply-To: <201311131008.55018.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

Hi Pavel,



On Wed, 13 Nov 2013 10:08:54 +0100, Pavel Pisa <pisa@cmp.felk.cvut.cz>

wrote:

> Hello all,

> 

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

> 

> Please, check what kind of the PCI to local-bus bridge

> is on the card if my explanation applies. If it is Infineon

> PSB4610 PITA-2  or some similar chip than it is possible

> that there can be present above described problem I have

> fight remotely for EMS-WUENSCHE CPC-PCI cards at Universita'

> degli Studi di Parma years ago with LinCAN. They have donated

> one such board to us so I can retest SocketCAN 

> 

> LinCAN commits

> 

> commit b5ac7e6f7e0d1af9dbb4bdb56921ab04de4e1ade

> Author: ppisa <ppisa>

> Date:   Fri Jul 16 15:44:20 2004 +0000

> 

>     EMS CPC-PCI fix correcting poorly undocumented PITA2 IRQ behavior.

>     This workaround compiles only for 2.6.x kernels now and correct

>     fix compatible with 2.4 requires driver wide changes.

>     That is why CPC-PCI is not enabled by default.

> 

> commit 3a2bb63f0bb8de2aafb346b53b945c59b3f87a41

> Author: ppisa <ppisa>

> Date:   Fri Jul 2 00:26:41 2004 +0000

> 

>     CPC-PCI second chip IRQ corrected. Message timestamp code added.

>     The timestamp code has some time overhead. If it is problem,

>     it can be disabled in the main.h file.

> 

> In the fact, I am not sure if code in

>   linux-devel/drivers/net/can/sja1000/ems_pci.c

> supporting this card is fully correct either even that LinCAN

> is referenced as the part of the code source. I need to analyze

> if the sharing problem is resolved.

> 

> There seems to be code to resolve IRQ flag clearing in peak_pci.c

> peak_pci_post_irq()

> 

> and different for two PITA versions in ems_pci.c 

>   ems_pci_v1_write_reg()

>   ems_pci_v1_post_irq()

> 

> LinCAn code strategy was to loop an the sibling CAN channers

> as long as there was one full cycle without any pending IRQ

> in all chips. This ensured that the shared wire from SJA1000

> chips is low and next IRQ would lead to enge on PITA input.

> That worked quite well.

> 

>  

http://sourceforge.net/p/ortcan/lincan/ci/master/tree/lincan/src/ems_cpcpci.c#l215



In Linux-CAN we have something similar:



http://lxr.linux.no/#linux/drivers/net/can/sja1000/ems_pcmcia.c#L90



> So check exac PITA version and report it. Check, if it is same as one

> supported by SocketCAN EMS driver and if the handling is the same.



@Austin, could you check what is written on the PITA chip?



> If this does not help than try to handle both chips

> from single registered IRQ with loop (or register that IRQ twice

> but do cross channel handling from it somehow if it is not possible

> to do that some other way). Then it is necessary to check that same

> chip is not handled from two IRQ threads concurrently in RT.

> 

> Other option is somehow switch given PCI line processing to

> shared edge triggered mode in kernel PCI core.



Hm, how should that work? Anyway, I'm aware of the problem when using

edge triggered interrupts. I thought it could not happen with level

triggered interrupts but I'm also afraid the hardware is not smart/good

enough. We should ask Peak Systems.



> Generally, RT is more sensitive to this stuck IRQs problem, because

> race window is longer. But problem probably applies to stock kernel

> but with probability many times smaller.



I agree.



Wolfgang.




