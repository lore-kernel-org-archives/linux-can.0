From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 12:02:05 +0100
Message-ID: <20131113110205.GA4136@vandijck-laurijssen.be>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <52831FC7.3040509@hartkopp.net>
 <f323c29b9730c877729322453b9e4ec9@grandegger.com>
 <201311131008.55018.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:11413 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417Ab3KMLCL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 06:02:11 -0500
Content-Disposition: inline
In-Reply-To: <201311131008.55018.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

Hi Pavel,

Sorry for reading my email out-of-order.

I had similar conclusions, without enough knowledge
of PCI busses.
I just sent a very preliminary patch. Do you think
this would solve the race condition without altering
the PCI-related properties?

Kurt

On Wed, Nov 13, 2013 at 10:08:54AM +0100, Pavel Pisa wrote:
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
>   http://sourceforge.net/p/ortcan/lincan/ci/master/tree/lincan/src/ems_cpcpci.c#l215
> 
> So check exac PITA version and report it. Check, if it is same as one
> supported by SocketCAN EMS driver and if the handling is the same.
> If this does not help than try to handle both chips
> from single registered IRQ with loop (or register that IRQ twice
> but do cross channel handling from it somehow if it is not possible
> to do that some other way). Then it is necessary to check that same
> chip is not handled from two IRQ threads concurrently in RT.
> 
> Other option is somehow switch given PCI line processing to
> shared edge triggered mode in kernel PCI core.
> 
> Generally, RT is more sensitive to this stuck IRQs problem, because
> race window is longer. But problem probably applies to stock kernel
> but with probability many times smaller.
> 
> Best wishes,
> 
>             Pavel
> 
> 
> 
> On Wednesday 13 of November 2013 09:11:58 Wolfgang Grandegger wrote:
> > On Wed, 13 Nov 2013 07:44:23 +0100, Oliver Hartkopp
> >
> > <socketcan@hartkopp.net> wrote:
> > > On 13.11.2013 00:22, Austin Schuh wrote:
> > >> Here is what is in the syslog from the same machine sending to it's
> > >> self with a non-realtime kernel.
> > >>
> > >> # uname -a
> > >> Linux vpc5 3.10-3-amd64 #1 SMP Debian 3.10.11-2 (2013-09-10) x86_64
> > >> GNU/Linux
> > >>
> > >> <6>[  169.993870] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> > >> <6>[  169.993904] peak_pci 0000:05:00.0 can1: Received packet.
> > >> <6>[  169.993923] peak_pci 0000:05:00.0 can1: sja1000_rx
> > >> <6>[  169.993994] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
> > >> <6>[  169.994013] peak_pci 0000:05:00.0 can1: Found can1, disabling
> > >> tracing.
> > >> <6>[  169.994029] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> > >> <6>[  169.994048] peak_pci 0000:05:00.0 can0: TX complete.
> > >> <6>[  169.994061] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
> > >
> > > This looks indeed much better :-)
> >
> > Note that the -rt uses threaded interrupt handlers, which can run on
> > separate
> > CPUs (just have a look to the function traces Austin provide), Looks like
> > vanilla is just less sensitive to races.
> >
> > >> When I attach the CAN device which continually sends, I get the
> > >> following.  (The front might be snipped improperly, not sure.)
> > >>
> > >> <6>[  640.823323] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> > >> <6>[  640.823331] peak_pci 0000:05:00.0 can1: Returning IRQ_NONE
> > >> <6>[  640.823334] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> > >> <6>[  640.823344] peak_pci 0000:05:00.0 can0: Received packet.
> > >> <6>[  640.823346] peak_pci 0000:05:00.0 can0: sja1000_rx
> > >> <6>[  640.823391] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
> > >
> > > This is a correct behaviour too:
> >
> > It is not a requirement that the (shared) handler are called sequentially.
> >
> > > The shared IRQ is handled by can1 (which had nothing to do) and then the
> > > chain
> > > goes to can0 which handles the reception correctly.
> > >
> > > @Wolfgang: Do we need an additional protection for the PITA handling in
> > > peak_pci.c ?
> >
> > Don't know. It depends on the hardware. The interrupt is cleared by
> > writing the
> > relevant bit to the PITA register. Looks save at a first glance but maybe
> > the
> > hardware is not smart enough. Adding spinlock protection would quickly
> > reveal if
> > that is the problem. Anyway, there could be other races as well.
> >
> > I can imaging another problem with the following returns:
> >
> >       /* check for absent controller due to hw unplug */
> >       if (status == 0xFF && sja1000_is_absent(priv))
> >           return IRQ_NONE;
> >
> > Austin, could you please check if they occur.
> >
> > > @Austin:
> > > I have another idea to test, if it just shows up in the mainline driver:
> > >
> > > Can you please download the out-of-tree driver from PEAK (version 7.9):
> > >
> > > http://www.peak-system.com/linux/index.htm
> > >
> > > I wonder if this one actually compiles with a -rt kernel and if it shows
> >
> > up
> >
> > > the same issue then.
> >
> > Well, we should better fix the problem in the Linux CAN driver.
> >
> > Wolfgang.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
