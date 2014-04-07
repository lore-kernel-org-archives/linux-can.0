From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 15:31:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404071524550.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <3160314.uNhSqa4Py1@ws-stein> <alpine.DEB.2.02.1404071455240.14882@ionos.tec.linutronix.de> <8704553.bJQG1oassy@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51439 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaDGNbJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 09:31:09 -0400
In-Reply-To: <8704553.bJQG1oassy@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 14:56:19, Thomas Gleixner wrote:
> > On Mon, 7 Apr 2014, Alexander Stein wrote:
> > 
> > > Hello Thomas,
> > > 
> > > On Monday 07 April 2014 14:34:17, Thomas Gleixner wrote:
> > > > > I'm currently trying to locate problem causes. Using your new set of patches on the tag linux-can-fixes-for-3.15-20140401 I lot of lost messages.
> > > > > Using bisect it seems that c0a9f4d39 "can: c_can: Reduce register access" introduced this problem on my hardware. Before that I only see switched messages occasionally.
> > > > > 
> > > > 
> > > > Does the last patch which disables the RX buffer split still have that
> > > > issue?
> > > 
> > > Regardless of CAN_C_CAN_STRICT_FRAME_ORDERING I'm still losing messages.
> > > BTW: I need the following patch to be able to use CAN_C_CAN_STRICT_FRAME_ORDERING:
> > 
> > Grr. True.
> > 
> > So if you disable CAN_C_CAN_STRICT_FRAME_ORDERING you still lose frames?
> 
> Yep, even on the commits before. But not from commit c0a9f4d39 on backwards.

That's weird. With c0a9f4d39 and the CAN_C_CAN_STRICT_FRAME_ORDERING=n
we use the message buffers as recommended by the C_CAN spec. i.e.:

We transfer the message object to the buffer and clear intpnd/newdat
right away.

What other patches do you have applied?

Thanks,

	tglx
