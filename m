From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: am335x: d_can: rx issue
Date: Tue, 29 Apr 2014 19:13:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404291911470.6261@ionos.tec.linutronix.de>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com> <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de> <CAGm1_ks=xU3tomPy+YhFtACqsbPLSP6D-hocC=pkhdtA5L_cQQ@mail.gmail.com> <alpine.DEB.2.02.1404291102240.6261@ionos.tec.linutronix.de>
 <535FDD04.2050804@hartkopp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42831 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248AbaD2RMu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 13:12:50 -0400
In-Reply-To: <535FDD04.2050804@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Tue, 29 Apr 2014, Oliver Hartkopp wrote:
> On 29.04.2014 11:03, Thomas Gleixner wrote:
> > Marc, can you expedite that one for 3.15 please?
> > 
> 
> Hi Thomas,
> 
> Marc is out of office until May 5th.
> See: http://marc.info/?l=linux-can&m=139855189427393&w=2
> 
> But this requested patch has already been pulled into Dave Millers net-tree:
> 
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=bed11db3d4095e5f818f5e8bf7f43ef2beb36d4e
> 
> So it will hit mainline with the next pull request from Dave to Linus.
> 3.15-rc4 looks therefore really feasible :-)

Thanks for the update !
 
> Btw. I'm currently running Daves net-tree here and was forced to define 
> CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING during 'make oldconfig' ...
> 
> Can this Kconfig option probably be removed in the 3.15-rc phase when
> it's not really needed anymore?
> 
> See: http://marc.info/?l=linux-can&m=139746476821294&w=2

If it's not necessary for any of the C/DCAN incarnations we can
probably drop it and rip the code out.

Thanks,

	tglx
