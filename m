From: Thor Thayer <tthayer.linux@gmail.com>
Subject: Re: [patch] Fix CAN on socfpga, for net/master
Date: Thu, 1 May 2014 08:15:50 -0500
Message-ID: <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
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
	<20140430215359.GA15148@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:36265 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbaEANPw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 May 2014 09:15:52 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so2823508veb.26
        for <linux-can@vger.kernel.org>; Thu, 01 May 2014 06:15:51 -0700 (PDT)
In-Reply-To: <20140430215359.GA15148@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

On Wed, Apr 30, 2014 at 4:53 PM, Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
>> >>> > Apparently, socfpga CAN needs 32-bit accesses and different raminit
>> >>> > sequence.
>> >>> >
>> >>> > Signed-off-by: Pavel Machek <pavel@denx.de>
>
> ...
>
>> >> Or ... let me upload my tree so that you can generate the diff.
>> >>
>> >> You should be able to get it using:
>> >>
>> >> git pull git://git.denx.de/linux-denx-pavel.git my_net_master
>> >>
>> >>> I also like your updates to my patch as shown below - much cleaner.
>
>> > Since you based this patch on my original code, feel free to add my
>> signed-off.
>
> Will do.
>
>> I pulled in your branch
>> (git://git.denx.de/linux-denx-pavel.gitmy_net_master) and tested it on
>> the Altera Development Kit. It works well -
>> I don't see any issues at a number of different bitrates (80K, 200K, 800K,
>> 1Mb).
>
> Thanks for testing. I'll also add your Tested-by: header, if you don't
> mind.

Hi Pavel. That would be fine.

Thor

>
>> I didn't investigate what the issues were with applying the patch though. I
>> just used your branch.
>
> The way I generated that branch... you picked up some extra code in
> other areas of the kernel, but it should not affect the testing.
>
> Thanks!
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
