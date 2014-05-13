From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv3] C_CAN: hwinit support for non-TI devices
Date: Tue, 13 May 2014 17:08:58 +0200
Message-ID: <20140513150857.GA11608@amd.pavel.ucw.cz>
References: <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz>
 <5370ED11.4000002@pengutronix.de>
 <20140513130914.GA9806@amd.pavel.ucw.cz>
 <53721FD5.50508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59502 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933299AbaEMPJA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 11:09:00 -0400
Content-Disposition: inline
In-Reply-To: <53721FD5.50508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

Hi!


On Tue 2014-05-13 15:36:21, Marc Kleine-Budde wrote:
> On 05/13/2014 03:09 PM, Pavel Machek wrote:
> > Non-TI chips (including socfpga) needs different raminit
> > sequence. Implement it.
> > 
> > const's in the hwinit prototype forced me to add const to more
> > prototypes. This makes changes bigger but the result is cleaner.
> 
> Why not split into several patches?
> 
> > Unfortunately, testing-c_can does not boot on sockit, but previous
> > version of patch was tested by me and Thor Thayer.
> 
> Have a look at:
> 
>     git@gitorious.org:linux-can/linux-can-next.git
> testing-c_can-based-on-net

git fetch git@gitorious.org:linux-can/linux-can-next.git
testing-c_can-based-on-net:testing-c_can-based-on-net
The authenticity of host 'gitorious.org (87.238.52.168)' can't be
established.
RSA key fingerprint is
7e:af:8d:ec:f0:39:5e:ba:52:16:ce:19:fa:d4:b8:7d.

But I was able to

git fetch git://gitorious.org/linux-can/linux-can-next.git
testing-c_can-based-on-net:testing-c_can-based-on-net 

.

> This branch uses net/master as it's base, I've split your patch into 3,
> and squashed the 32bit-const changes into the 32-bit access patch. The
> remaining patch looks quite clean.

Thanks a lot!

> Can you please test the branch, I hope it boots on sockit.

That one still dies early in boot, but I was able to apply some
changes from my main tree (not CAN related) and get it to boot.

And yes, it seems to work:

[It still does not contain some "interesting" changes from altera
tree, but as I could not get explanation why they are needed -- and
they don't seem to be needed -- maybe it is better that way.]

Thanks,
								Pavel

root@sockit:~# uname -a
Linux sockit 3.15.0-rc4-00470-g4477be8-dirty #99 SMP Tue May 13
17:02:02 CEST 2014 armv7l GNU/Linux
root@sockit:~# ip link set can0 up type can bitrate 125000 loopback on
c_can_platform ffc00000.d_can can0: setting BTR=1c31 BRPE=0000
root@sockit:~# ifconfig can0 up
root@sockit:~# candump can0 &
root@sockit:~# cansend can0 "123#DEADBEEF"
  can0  123   [4]  DE AD BE EF
  can0  123   [4]  DE AD BE EF
root@sockit:~# cansend can0 "123#DEADBEEF"
  can0  123   [4]  DE AD BE EF
  can0  123   [4]  DE AD BE EF

commit 4477be8c9c6070d94b37758a8b35ce60882c2617
Merge: 37e25b8 a64b6a7
Author: Pavel Machek <pavel@denx.de>
Date:   Tue May 13 17:01:30 2014 +0200

    Merge commit 'a64b6a7de2e89f0468ad00066940cfa2d48f886a' into
    testing-c_can-based-on-n
    
    testing-c_can-based-on-net does not boot, this one could.

commit 37e25b8a3432a66027fd3252ec682bd627a929c5


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
