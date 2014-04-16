From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] can: sja1000_isa: add locking for indirect register
 access mode
Date: Wed, 16 Apr 2014 10:48:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404161048040.22697@ionos.tec.linutronix.de>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com> <164afc991761b9eeb0eec6902814d00e@grandegger.com> <534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net>
 <534D270D.5060705@pengutronix.de> <534D31EF.6050107@hartkopp.net> <534D3748.6060602@pengutronix.de> <534D6C98.4020109@hartkopp.net> <alpine.DEB.2.02.1404152323500.22697@ionos.tec.linutronix.de> <534DA95D.60506@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35915 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaDPIsK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Apr 2014 04:48:10 -0400
In-Reply-To: <534DA95D.60506@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, khurram gulzar <khurramgulzar@gmail.com>, linux-can@vger.kernel.org

On Tue, 15 Apr 2014, Marc Kleine-Budde wrote:

> On 04/15/2014 11:26 PM, Thomas Gleixner wrote:
> > On Tue, 15 Apr 2014, Oliver Hartkopp wrote:
> > 
> >> When accessing the SJA1000 controller registers in the indirect access mode,
> >> writing the register number and reading/writing the data has to be an atomic
> >> attempt.
> >>
> >> As the sja1000_isa driver is an old style driver with a fixed number of
> >> instances the locking variable depends on the same index like all the other
> >> configuration elements given on the module command line.
> >>
> >> As a positive side effect dev->dev_id is populated by the instance index,
> >> which was missing in 3e66d0138c05d9 ("can: populate netdev::dev_id for udev
> >> discrimination").
> >>
> >> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>
> >> ---
> >>
> >> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
> >> index df136a2..014695d 100644
> >> --- a/drivers/net/can/sja1000/sja1000_isa.c
> >> +++ b/drivers/net/can/sja1000/sja1000_isa.c
> >> @@ -46,6 +46,7 @@ static int clk[MAXDEV];
> >>  static unsigned char cdr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
> >>  static unsigned char ocr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
> >>  static int indirect[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
> >> +static spinlock_t indirect_lock[MAXDEV];  /* lock for indirect access mode */
> > 
> > You need to initialize the spinlock if you want to survive lockdep.
> > 
> > Either use the proper static initializer or do an explicit
> > spin_lock_init() on each of the locks before using them.
> 
> There's a spin_lock_init in the probe function:
> 
> >  static int sja1000_isa_probe(struct platform_device *pdev)
> > @@ -169,6 +177,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
> >  		if (iosize == SJA1000_IOSIZE_INDIRECT) {
> >  			priv->read_reg = sja1000_isa_port_read_reg_indirect;
> >  			priv->write_reg = sja1000_isa_port_write_reg_indirect;
> > +			spin_lock_init(&indirect_lock[idx]);

Ooops, missed that :)
