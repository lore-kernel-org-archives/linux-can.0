From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH v2 1/3] can: kvaser_usb: Fix tx queue start/stop race
 conditions
Date: Wed, 11 Mar 2015 11:57:36 -0400
Message-ID: <20150311155736.GA12396@linux>
References: <20150226152011.GA6075@linux>
 <20150311152353.GA12260@linux>
 <55006114.8030702@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33387 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbCKP5k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Mar 2015 11:57:40 -0400
Content-Disposition: inline
In-Reply-To: <55006114.8030702@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Mar 11, 2015 at 04:36:52PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2015 04:23 PM, Ahmed S. Darwish wrote:
> > From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> > 
> > A number of tx queue wake-up events went missing due to the
> > outlined scenario below. Start state is a pool of 16 tx URBs,
> > active tx_urbs count = 15, with the netdev tx queue open.
> > 
> > start_xmit()                             tx_acknowledge()
> > ............                             ................
> > atomic_inc(&tx_urbs);
> > if (atomic_read(&tx_urbs) >= 16) {
> >                         URB completion IRQ!
> >                         -->
> >                                          atomic_dec(&tx_urbs);
> >                                          netif_wake_queue();
> >                                          return;
> >                         <--
> >                         end of IRQ!
> >     netif_stop_queue();
> > }
> > 
> > At the end, the correct state expected is a 15 tx_urbs count
> > value with the tx queue state _open_. Due to the race, we get
> > the same tx_urbs value but with the tx queue state _stopped_.
> > The wake-up event is completely lost.
> > 
> > Thus avoid hand-rolled concurrency mechanisms and use a proper
> > lock for contexts protection.
> 
> I'm missing a spin_lock_init(), right? Please compile and test your code
> with everything switch on in Kernel hacking -> Lock Debugging.
> 

Ouch... that passed through it seems since __ARCH_SPIN_LOCK_UNLOCKED
is always zero on x86. Recompiling the kernel and re-iterating another
patch series.

Thanks,
Darwish
