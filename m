From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 20:15:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404072014360.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <8704553.bJQG1oassy@ws-stein> <alpine.DEB.2.02.1404071524550.14882@ionos.tec.linutronix.de> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de>
 <5342EA52.6080904@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53091 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbaDGSOy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 14:14:54 -0400
In-Reply-To: <5342EA52.6080904@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Marc Kleine-Budde wrote:

> On 04/07/2014 05:24 PM, Thomas Gleixner wrote:
> > On Mon, 7 Apr 2014, Alexander Stein wrote:
> >> On Monday 07 April 2014 15:31:20, Thomas Gleixner wrote:
> >>> What other patches do you have applied?
> >>
> >> I have shrinked them a bit to the absolute necessity. In general
> >> these are patches for the current hardware to make them working.
> > 
> >> 53b385c37e4eb155cf9d515913ddf76750e2ac24 c_can: Add support for eg20t (pch_can)
> > 
> > I can't see anything whats wrong with that one.
> > 
> > Can you check, whether the following check in c_can_read_objects()
> > 
> >                if (!(ctrl & IF_MCONT_NEWDAT))
> >                         continue;
> 
> On TI's D_CAN with all your patches applied and the split buffer
> approach active, I haven't this trigger in a ~4h test run. Athough there
> are regularly missing frames, apart from this, they are in the correct
> order.

If you disable the split buffer is the message loss gone?

Thanks,

	tglx
