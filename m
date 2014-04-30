From: Pavel Machek <pavel@denx.de>
Subject: Re: [patch] Fix CAN on socfpga, for net/master
Date: Wed, 30 Apr 2014 23:53:59 +0200
Message-ID: <20140430215359.GA15148@amd.pavel.ucw.cz>
References: <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
 <20140426093646.GE8730@amd.pavel.ucw.cz>
 <20140426203131.GA21832@amd.pavel.ucw.cz>
 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55619 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759042AbaD3VyH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Apr 2014 17:54:07 -0400
Content-Disposition: inline
In-Reply-To: <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

Hi!

> >>> > Apparently, socfpga CAN needs 32-bit accesses and different raminit
> >>> > sequence.
> >>> >
> >>> > Signed-off-by: Pavel Machek <pavel@denx.de>

...

> >> Or ... let me upload my tree so that you can generate the diff.
> >>
> >> You should be able to get it using:
> >>
> >> git pull git://git.denx.de/linux-denx-pavel.git my_net_master
> >>
> >>> I also like your updates to my patch as shown below - much cleaner.

> > Since you based this patch on my original code, feel free to add my
> signed-off.

Will do.

> I pulled in your branch
> (git://git.denx.de/linux-denx-pavel.gitmy_net_master) and tested it on
> the Altera Development Kit. It works well -
> I don't see any issues at a number of different bitrates (80K, 200K, 800K,
> 1Mb).

Thanks for testing. I'll also add your Tested-by: header, if you don't
mind.

> I didn't investigate what the issues were with applying the patch though. I
> just used your branch.

The way I generated that branch... you picked up some extra code in
other areas of the kernel, but it should not affect the testing.

Thanks!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
