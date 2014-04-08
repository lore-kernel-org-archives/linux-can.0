From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Tue, 8 Apr 2014 16:15:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404081613141.14882@ionos.tec.linutronix.de>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <alpine.DEB.2.02.1404081421140.14882@ionos.tec.linutronix.de> <6189770.Mjp8LixSFl@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57899 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874AbaDHOP0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 10:15:26 -0400
In-Reply-To: <6189770.Mjp8LixSFl@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 8 Apr 2014, Alexander Stein wrote:
> On Tuesday 08 April 2014 15:07:10, Thomas Gleixner wrote:
> The problem is that NEWDAT in the crtl register readout is most of the time set, but sometimes not.
> Adding the delay above it is unset all the time :(

Now what happens if you disable interrupts across the writes:

    local_irq_disable()
    write(COMMSK)
    write(COMREQ)
    local_irq_enable()

Thanks,

	tglx
