From: Pavel Machek <pavel@denx.de>
Subject: Re: [patch] Fix CAN on socfpga, for net/master
Date: Mon, 28 Apr 2014 23:15:05 +0200
Message-ID: <20140428211505.GA28242@amd.pavel.ucw.cz>
References: <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
 <20140426093646.GE8730@amd.pavel.ucw.cz>
 <20140426203131.GA21832@amd.pavel.ucw.cz>
 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60628 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaD1VPH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Apr 2014 17:15:07 -0400
Content-Disposition: inline
In-Reply-To: <1398716449.836.4.camel@dinh-ubuntu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer@altera.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, tthayer.linux@gmail.com

Hi!

On Mon 2014-04-28 15:20:49, Thor Thayer wrote:
> On Sun, 2014-04-27 at 14:25 +0200, ZY - pavel wrote:
> > Apparently, socfpga CAN needs 32-bit accesses and different raminit
> > sequence.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > 
> > ---
> > 
> > > 
> > > I'm not in the office (and fighting with my phone's email client) until 5th of May, however please rebase all your patches against the latest net/master from David Miller, as this tree includes all c_can fixes by Thomas.
> > > 
> > 
> > Ok, combined patch is here. Lightly tested using loopback on Arrow
> > SocKit.
> 
> Hi Pavel. 
> 
> Thanks for your help on the SOCFPGA support! I can test this on the
> Altera Development Kit but I'm not able to cleanly apply to the latest
> David Miller net-next branch. Is there a different branch I should
> use?

It should have been against net-next branch... but perhaps I made a
mistake somewhere. I should get some sleep now.

Or ... let me upload my tree so that you can generate the diff.

You should be able to get it using:

git pull git://git.denx.de/linux-denx-pavel.git my_net_master

> I also like your updates to my patch as shown below - much cleaner.

Thanks :-).

Best regards,

								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
