From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: am335x: d_can: rx issue
Date: Wed, 30 Apr 2014 08:08:59 +0200
Message-ID: <2457559.6qzT8616qY@ws-stein>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com> <535FDFBE.1080007@hartkopp.net> <alpine.DEB.2.02.1404291947280.6261@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59040 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400AbaD3GKF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Apr 2014 02:10:05 -0400
In-Reply-To: <alpine.DEB.2.02.1404291947280.6261@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Tuesday 29 April 2014 19:50:00, Thomas Gleixner wrote:
> On Tue, 29 Apr 2014, Oliver Hartkopp wrote:
> > On 29.04.2014 19:13, Thomas Gleixner wrote:
> > > On Tue, 29 Apr 2014, Oliver Hartkopp wrote:
> > 
> > >> Btw. I'm currently running Daves net-tree here and was forced to define 
> > >> CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING during 'make oldconfig' ...
> > >>
> > >> Can this Kconfig option probably be removed in the 3.15-rc phase when
> > >> it's not really needed anymore?
> > >>
> > >> See: http://marc.info/?l=linux-can&m=139746476821294&w=2
> > > 
> > > If it's not necessary for any of the C/DCAN incarnations we can
> > > probably drop it and rip the code out.
> > 
> > Hm. I don't know. AFAIK only Alexander and you detected and discussed the
> > frame re-ordering issue of the C_CAN in length.
> > 
> > I put Alexander in CC. When you both don't have any objections it's up to your
> > opinion to remove this (hopefully) obsolete option.
> 
> It's possible in theory and you can "enforce" it by injecting
> artificial delays, but I doubt it's a real world issue.
> 
> Fine with me to remove it along with the accompanying code cruft.

I dont have any objections too removing it.

Regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

