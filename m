From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: am335x: d_can: rx issue
Date: Tue, 29 Apr 2014 19:50:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404291947280.6261@ionos.tec.linutronix.de>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com> <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de> <CAGm1_ks=xU3tomPy+YhFtACqsbPLSP6D-hocC=pkhdtA5L_cQQ@mail.gmail.com> <alpine.DEB.2.02.1404291102240.6261@ionos.tec.linutronix.de>
 <535FDD04.2050804@hartkopp.net> <alpine.DEB.2.02.1404291911470.6261@ionos.tec.linutronix.de> <535FDFBE.1080007@hartkopp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43125 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbaD2Rtr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 13:49:47 -0400
In-Reply-To: <535FDFBE.1080007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>

On Tue, 29 Apr 2014, Oliver Hartkopp wrote:
> On 29.04.2014 19:13, Thomas Gleixner wrote:
> > On Tue, 29 Apr 2014, Oliver Hartkopp wrote:
> 
> >> Btw. I'm currently running Daves net-tree here and was forced to define 
> >> CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING during 'make oldconfig' ...
> >>
> >> Can this Kconfig option probably be removed in the 3.15-rc phase when
> >> it's not really needed anymore?
> >>
> >> See: http://marc.info/?l=linux-can&m=139746476821294&w=2
> > 
> > If it's not necessary for any of the C/DCAN incarnations we can
> > probably drop it and rip the code out.
> 
> Hm. I don't know. AFAIK only Alexander and you detected and discussed the
> frame re-ordering issue of the C_CAN in length.
> 
> I put Alexander in CC. When you both don't have any objections it's up to your
> opinion to remove this (hopefully) obsolete option.

It's possible in theory and you can "enforce" it by injecting
artificial delays, but I doubt it's a real world issue.

Fine with me to remove it along with the accompanying code cruft.

Thanks,

	tglx
