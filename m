From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 08 Apr 2014 08:17:49 +0200
Message-ID: <1478648.0J5yx6jf7X@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <5342D1DE.6070107@grandegger.com> <alpine.DEB.2.02.1404072158350.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54033 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbaDHGTD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 02:19:03 -0400
In-Reply-To: <alpine.DEB.2.02.1404072158350.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Monday 07 April 2014 22:03:33, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Wolfgang Grandegger wrote:
> > On 04/07/2014 05:53 PM, Thomas Gleixner wrote:
> > > On Mon, 7 Apr 2014, Alexander Stein wrote:
> > >> On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> > >>> It'd be odd, because we get the buffers with the NEWDAT pending bits
> > >>> from the NEWDATA1 register.
> > >>
> > >  
> > >> Using the following patch the warning raises about every 5ms. With
> > >> and without your last patchset.
> > > 
> > >> but reverting c0a9f4d39 this does _NOT_ arise.
> > > 
> > > So the NEWDAT register is telling us that the newdat bit of that
> > > buffer is set. But when we retrieve the message, it's not set.
> > 
> > 
> > Not sure if it matters. There was a strange write-readback problem
> > reported with the PCH CAN. I digged out:
> > 
> > http://marc.info/?l=linux-can&m=135525750319741&w=2
> > http://marc.info/?l=linux-can&m=135525729919672&w=2
> > http://marc.info/?t=135296394900001&r=1&w=2
> > 
> > It got worse with concurrent activity of I2C on some eg20t system which
> > smells of a weired hardware problem (and could maybe explain the 5ms
> > period).
> 
> Well, looking at the report:
> 
> > I cannot say if any (small) I2C transfer at all raises the
> > problem. I run 'cangen -I 0x300 can0' on my PC connected to my test
> > board. A I2C connected LED is triggered by heartbeat thus there is a
> > small I2C traffic each second. I couldn't see any errors in dmesg in
> > about 10 minutes. But even with that small CAN traffic (next to
> > nothing) a 'watch sensors' (which queries several I2C sensors every
> > 2s) caused errors in dmesg. It seems the problem isn't related to
> > CAN bus load at all.
> 
> I2C connected LED? How is that supposed to work? You cannot run I2C
> traffic from softirq context. 

Why not? The led_heartbeat_function function (kernel v3.0.31 in that case) runs at last pca955x_led_set which calls schedule_work.
To my surprise using the current kernel and c_can driver (I used pch_can in v3.0.x) it seems that I2C transfer doesn't affect CAN at all.

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

