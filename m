From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 22:03:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404072158350.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de> <10077840.fz9L5lnEL0@ws-stein> <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
 <5342D1DE.6070107@grandegger.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53424 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948AbaDGUDW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 16:03:22 -0400
In-Reply-To: <5342D1DE.6070107@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Wolfgang Grandegger wrote:
> On 04/07/2014 05:53 PM, Thomas Gleixner wrote:
> > On Mon, 7 Apr 2014, Alexander Stein wrote:
> >> On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> >>> It'd be odd, because we get the buffers with the NEWDAT pending bits
> >>> from the NEWDATA1 register.
> >>
> >  
> >> Using the following patch the warning raises about every 5ms. With
> >> and without your last patchset.
> > 
> >> but reverting c0a9f4d39 this does _NOT_ arise.
> > 
> > So the NEWDAT register is telling us that the newdat bit of that
> > buffer is set. But when we retrieve the message, it's not set.
> 
> 
> Not sure if it matters. There was a strange write-readback problem
> reported with the PCH CAN. I digged out:
> 
> http://marc.info/?l=linux-can&m=135525750319741&w=2
> http://marc.info/?l=linux-can&m=135525729919672&w=2
> http://marc.info/?t=135296394900001&r=1&w=2
> 
> It got worse with concurrent activity of I2C on some eg20t system which
> smells of a weired hardware problem (and could maybe explain the 5ms
> period).

Well, looking at the report:

> I cannot say if any (small) I2C transfer at all raises the
> problem. I run 'cangen -I 0x300 can0' on my PC connected to my test
> board. A I2C connected LED is triggered by heartbeat thus there is a
> small I2C traffic each second. I couldn't see any errors in dmesg in
> about 10 minutes. But even with that small CAN traffic (next to
> nothing) a 'watch sensors' (which queries several I2C sensors every
> 2s) caused errors in dmesg. It seems the problem isn't related to
> CAN bus load at all.

I2C connected LED? How is that supposed to work? You cannot run I2C
traffic from softirq context. 

Thanks,

	tglx


