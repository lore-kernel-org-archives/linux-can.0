From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 10:48:48 +0100
Message-ID: <20131113094848.GB14784@vandijck-laurijssen.be>
References: <be0d6725fff5298d3fb8417e4800348b@grandegger.com>
 <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
 <84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
 <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
 <527E44EB.9020605@hartkopp.net>
 <CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
 <52829CF1.4010902@hartkopp.net>
 <CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
 <CANGgnMaCvb=B2r997e+H9UjVquX66HJ+OtftL0EyGP7MKcy0tQ@mail.gmail.com>
 <52832333.9080908@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:38382 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758185Ab3KMJtA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 04:49:00 -0500
Content-Disposition: inline
In-Reply-To: <52832333.9080908@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Austin Schuh <austin@peloton-tech.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hi,

I followed this interesting 'thread'.
I'm not sure this is a contribution, but I share my idea already
since it may help.

It appears that the -rt is affecting the peak_pci driver.
So I started looking into the SJA1000+peak_pci combination.

The peak_pci PITA does not look strange. The channel mask
is used, so I don't suspect a locking problem there.

schematically, the current situation:
1. deal with SJA1000 IRQ
2. handle PITA

I'm not very familiar with the precise function of the PITA.
What I do find strange is that the PITA is handled _after_
processing the SJA1000 IRQ. This means that between processing
the last SJA1000 IRQ and handling PITA, a new event may arrive.
Especially when scheduling takes place in between.

Ideally, I would try:
1. disable SJA1000 IRQ (make sure the hardware returns idle again)
2. handle PITA (the kernel knows it must do something)
3. handle SJA1000 IRQ (do something)
4. enable SJA1000 IRQ

This alternative sequence would effectively get an SJA1000's irq
line idle, and let the PITA know that.
If after handling the IRQ some event happens again, then the
irq line get active again when enabling the SJA1000 IRQ.

To make sure I expressed myself well, I attached a very elementary
patch that shows what I actually mean.

Kurt

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 83ee11e..a235ea0 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -494,15 +494,21 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	if (priv->read_reg(priv, REG_IER) == IRQ_OFF)
 		return IRQ_NONE;
 
+	priv->write_reg(priv, REG_IER, 0);
+
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
+	/* do the post irq as a workaround.
+	   better rework the driver to use pre_irq */
+	if (priv->post_irq)
+		priv->post_irq(priv);
 
 	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
 		n++;
 		status = priv->read_reg(priv, REG_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
-			return IRQ_NONE;
+			goto done;
 
 		if (isrc & IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
@@ -529,7 +535,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				status = priv->read_reg(priv, REG_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
-					return IRQ_NONE;
+					goto done;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
@@ -539,12 +545,13 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 		}
 	}
 
-	if (priv->post_irq)
-		priv->post_irq(priv);
-
 	if (n >= SJA1000_MAX_IRQ)
 		netdev_dbg(dev, "%d messages handled in ISR", n);
 
+done:
+	/* IRQ_ALL should become the same as used in set_normal_mode */
+	priv->write_reg(priv, REG_IER, IRQ_ALL);
+
 	return (n) ? IRQ_HANDLED : IRQ_NONE;
 }
 EXPORT_SYMBOL_GPL(sja1000_interrupt);


On Wed, Nov 13, 2013 at 07:58:59AM +0100, Oliver Hartkopp wrote:
> Hi Austin,
> 
> sorry for checking my mails in sequential order :-)
> I would have been able to shorten the last mail.
> 
> Thanks for your interesting investigation.
> I wonder why this problem did not show up before then. Having shared
> interrupts should be a usual thing.
> 
> This kind of race condition should not be there at all. Do you have a second
> peak_pci hardware? I could be an idea to try to split the IRQs in a way that
> you have two IRQs for two cards - and then connect can0 to can2.
> You would have a pretty fast following RX/TX interrupt but without interrupt
> sharing ...
> 
> Best regards,
> Oliver
> 
> On 13.11.2013 04:41, Austin Schuh wrote:
> > On Tue, Nov 12, 2013 at 3:22 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> >> On Tue, Nov 12, 2013 at 1:26 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>> On 12.11.2013 03:59, Austin Schuh wrote:
> >>>
> >>>>> From the trace it is pretty hard to know which CAN interface is in charge.
> >>>>> (2) Can you please add the output of dev->ifindex in the pr_info() calls?
> >>>>
> >>>> Gladly.  See the updated logs.
> >>>>
> >>>> [  556.019246] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> >>>> [  556.019268] Unhandled IRQ 18... stop tracing...
> >>>> [  556.019280] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> >>>> [  556.019289] peak_pci 0000:05:00.0 can1: Received packet.
> >>>> [  556.019299] peak_pci 0000:05:00.0 can1: sja1000_rx
> >>>> [  556.019307] peak_pci 0000:05:00.0 can0: TX complete.
> >>>> [  556.019318] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
> >>>> [  556.019362] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
> >>>>
> >>>
> >>> This looks pretty broken regarding the IRQ handling.
> >>> Maybe the IRQ thread handling has a real problem in the -rt kernel ?!?
> >>
> >> Sounds pretty plausible right now.
> > 
> > Ok, I spent a good chunk of today reading the IRQ handling code in the
> > kernel, and I think I get what is happening and have a plausible
> > explanation for why the interrupt is getting disabled.  Not sure how
> > to test it.
> > 
> > Here is what it looks like is happening.  The hardware triggers an
> > interrupt.  The handler is called, and then the registered action for
> > each of the devices is to notify their threads that an IRQ occurred,
> > and to have them handle it.  Each of the handling threads then calls
> > the sja1000_interrupt function, or the equivalent ata_generic
> > interrupt function.  2 of the 3 interrupt functions then return
> > IRQ_NONE, and one of them returns IRQ_HANDLED.  note_interrupt is then
> > called in each of the threads (instead of being called once in the
> > non-rt case), resulting in 2 unhanded calls, and 1 handled call.  So
> > far, so good.  The kernel operates as expected, since less than 99.9 %
> > of the interrupts are handled.  (There is a note_interrupt call in the
> > handler, but since the threaded handlers are notified, this doesn't
> > get counted.
> > 
> > Since the IRQ handlers are now all in threads, if the thread that
> > actually receives data doesn't process the interrupts either because
> > something goes wrong, or because it doesn't get scheduled, there will
> > be a bunch of unhanded interrupts noted, and no handled interrupts
> > noted.  This will cause the IRQ to be disabled.
> > 
> > I guess the next interesting thing to do is to trigger when it
> > disables the IRQ and take a look at what is happening.  I have a test
> > running on one machine with tracing enabled which will disable tracing
> > when the IRQ is disabled.  That should provide some interesting
> > results.  I think I also know how to bypass it for now by setting
> > "noirqdebug", but I'd like to fix it for real as well.
> > 
> > Austin
> > 
