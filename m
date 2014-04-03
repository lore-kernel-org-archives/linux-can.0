From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 3 Apr 2014 22:28:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404032221350.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533D774C.4050703@pengutronix.de> <alpine.DEB.2.02.1404031703120.14882@ionos.tec.linutronix.de> <1497730.QLQMESBtqQ@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34692 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbaDCU14 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 16:27:56 -0400
In-Reply-To: <1497730.QLQMESBtqQ@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, 3 Apr 2014, Alexander Stein wrote:

> On Thursday 03 April 2014 17:11:18, Thomas Gleixner wrote:
> > > > based on tag 'linux-can-fixes-for-3.15-20140401' on repository git://gitorious.org/linux-can/linux-can I have noticed message losts(only one message each time). Interestingly 'candump any,0~0,#FFFFFFFF' didn't show yn error frames.
> > > > From 500000 CAN frames I lost 72 frames.
> > 
> > The split RX buffer handling is causing the hardware to drop frames
> > without giving any notice. We debugged that in the last days and can
> > prove that it is an hardware issue. Fun, isn't it ?
> > 
> > The package drop happens always at the point where the 8th message
> > buffer is read out and all the lower buffers are reenabled. So
> > something confuses the state machine of the message handler here.
> > 
> > If we disable the split buffer handling, then the drop out stops. That
> > might cause packet reordering though. Find below a test patch.
> 
> I had to modify your patch slightly, but It didn't show any

Yeah, I had it on top of other modifications.

> reordering though. Just the lost messages as before.

Hmm. The lost packet issue is gone here when I enable the NO_RX_SPLIT
hack. I'm confused.

Vs. reordering: That's a corner case for which the split RX buffer was
designed to prevent. It's hard to trigger. I had to enforce it by
inserting artificial delays.

> Regarding http://marc.info/?l=linux-can&m=139403207713987&w=2 it
> seems there is a race, when reenabling the lower buffers, bewteen
> reading current state and hardware inserting new message.

The behaviour you describe is exactly the same as we traced out. While
the lower buffers are reenabled the packet which is coming in at this
point gets swallowed by the hardware.

And it's unrelated to RT. You can see the issue with mainline as
well. I tried both.

Thanks,

	tglx

