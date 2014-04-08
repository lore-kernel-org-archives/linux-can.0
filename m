From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Tue, 08 Apr 2014 16:24:43 +0200
Message-ID: <8083460.0p0S3IB599@ws-stein>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <6189770.Mjp8LixSFl@ws-stein> <alpine.DEB.2.02.1404081613141.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:34698 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756898AbaDHOZ4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 10:25:56 -0400
In-Reply-To: <alpine.DEB.2.02.1404081613141.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tuesday 08 April 2014 16:15:37, Thomas Gleixner wrote:
> On Tue, 8 Apr 2014, Alexander Stein wrote:
> > On Tuesday 08 April 2014 15:07:10, Thomas Gleixner wrote:
> > The problem is that NEWDAT in the crtl register readout is most of the time set, but sometimes not.
> > Adding the delay above it is unset all the time :(
> 
> Now what happens if you disable interrupts across the writes:
> 
>     local_irq_disable()
>     write(COMMSK)
>     write(COMREQ)
>     local_irq_enable()

There are still message objects where NEWDAT is unset. Even if the c_can_msg_obj_is_busy check is included.

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

