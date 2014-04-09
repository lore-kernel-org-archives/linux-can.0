From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Wed, 09 Apr 2014 12:28:50 +0200
Message-ID: <1749126.lLSDJkX5K7@ws-stein>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <alpine.DEB.2.02.1404090232400.14882@ionos.tec.linutronix.de> <155230474.Qal719xsr7@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55248 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784AbaDIKaD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 06:30:03 -0400
In-Reply-To: <155230474.Qal719xsr7@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Wednesday 09 April 2014 09:40:11, Alexander Stein wrote:
> On Wednesday 09 April 2014 02:42:57, Thomas Gleixner wrote:
> > I found the issue after a I got hold of a PCH afflicted system. It
> > might not apply cleanly as I changed a few other things in my patch
> > queue, but you get the idea. Too tired now to write changelogs, run
> > tests ....
> > 
> > W/o that patch I observe the same problems as you. With that applied I
> > did not observe any dropout with a 10 * 1e6 packet run.
> 
> Applying your patch I run my test with 5.000.000 CAN frames where none got lost and only a single one got switched.

Just for completeness: If this test is done while iperf and I2C is ongoing meanwhile there are 24 switched messages.

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

