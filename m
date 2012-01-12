From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Softing Firmware on gitorious
Date: Thu, 12 Jan 2012 09:25:36 +0100
Message-ID: <20120112082536.GA380@e-circ.dyndns.org>
References: <4F0DB66F.50509@hartkopp.net>
 <4F0DBF90.5050906@pengutronix.de>
 <4F0DC8BC.4040704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:42764 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab2ALIZj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Jan 2012 03:25:39 -0500
Content-Disposition: inline
In-Reply-To: <4F0DC8BC.4040704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Jan 11, 2012 at 06:37:00PM +0100, Oliver Hartkopp wrote:
> On 11.01.2012 17:57, Marc Kleine-Budde wrote:
> 
> > On 01/11/2012 05:18 PM, Oliver Hartkopp wrote:
> >> Hello Kurt,
> >>
> >> i just uploaded the Softing firmware from BerliOS to our new 
> >>
> >> https://gitorious.org/linux-can/can-misc
I was thinking to pick this up sooner or later. Thanks for doing this already.

> >>
> >> git repository.
> >>
> >> See at 
> >>
> >> https://gitorious.org/linux-can/can-misc/blobs/master/firmware/softing-fw-4.6-binaries.tar.gz
> >>
> >> Currently the only reference is in the Linux Kernel in the Softing Kconfig:
> >>
> >> config CAN_SOFTING_CS
> >>         tristate "Softing Gmbh CAN pcmcia cards"
> >>         depends on PCMCIA
> >>         depends on CAN_SOFTING
> >>         ---help---
> >>           Support for PCMCIA cards from Softing Gmbh & some cards
> >>           from Vector Gmbh.
> >>           You need firmware for these, which you can get at
> >>           http://developer.berlios.de/projects/socketcan/
> >>           This version of the driver is written against
> >>           firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
> >>           In order to use the card as CAN device, you need the Softing generic
> >>           support too.
> >>
> >>
> >> The question is now:
> >>
> >> 1. change the link in the Kconfig
Yes
> >> 2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
If I read the READMEs well, new firmware should go into a seperate repo? Am I wrong?

I admit that putting the firmware into linux/firmware/*.ihex would solve a distribution
problem ...
> >> 3. 1 & 2
> > 
> > 3.
> > 
> > It would be nice to have a license statement on that files. As these are
> > in binary form, the driver would be removed from the debian kernel.
> > What's the official source of that firmware? Do we have a contact to
> > softing?
The official source is softing. I only repackaged the firmware from 'unsigned char ...[]' in
header files towards seperate blobs to be used with the firmware interface.
> > 
> 
> 
> Yes. See here:
> 
> https://lists.berlios.de/pipermail/socketcan-core/2008-June/001613.html
This convinces me as a developer that they have not problem.
> 
> I'll check the mentioned driver packages for license information which i don't
> have on my current machine here.
I'll look too.
> 
> Regards,
> Oliver
Kurt
