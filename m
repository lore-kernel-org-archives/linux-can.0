From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 17:53:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de> <10077840.fz9L5lnEL0@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52310 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaDGPxs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 11:53:48 -0400
In-Reply-To: <10077840.fz9L5lnEL0@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> > It'd be odd, because we get the buffers with the NEWDAT pending bits
> > from the NEWDATA1 register.
>
 
> Using the following patch the warning raises about every 5ms. With
> and without your last patchset.

> but reverting c0a9f4d39 this does _NOT_ arise.

So the NEWDAT register is telling us that the newdat bit of that
buffer is set. But when we retrieve the message, it's not set.

What's even more confusing: On my D_CAN hardware the NEWDAT is not set
event happens when I revert c0a9f4d39

So it would be interesting to see, whether this event is aligned to
the lost packets you are hunting:

    P1 -> P2 -> WARN -> P4

A few trace printks should tell us pretty fast.

Thanks,

	tglx
