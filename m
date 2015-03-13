From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: LEDs: documentation
Date: Fri, 13 Mar 2015 14:19:23 +0000
Message-ID: <CABkP77egMA8KEMHfp9VvhYwLAFCe5e2Lk3h-MjGv9d3J=79R4Q@mail.gmail.com>
References: <CAGm1_ktxocqFvQQ9Mrnk+ravrgpq-+RWw3vN0qsS=Qpa+o3WGA@mail.gmail.com>
 <CAGm1_kuKuFaEyj-JicFfiX=qBjOeNLEzdrCQLLrXxE04OL=2Kw@mail.gmail.com>
 <CAJ=nTst7-1KeL3tG9BAB-mc9298K6qeHPB4hdX5RWp12jTqs9Q@mail.gmail.com> <CAJ=nTssOr_JpwbrhJ6Zyi+g=8YrjrUn8nyVBiMH26Zo5zrNjOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45693 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbbCMOTp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Mar 2015 10:19:45 -0400
Received: by lbiz12 with SMTP id z12so23090887lbi.12
        for <linux-can@vger.kernel.org>; Fri, 13 Mar 2015 07:19:43 -0700 (PDT)
In-Reply-To: <CAJ=nTssOr_JpwbrhJ6Zyi+g=8YrjrUn8nyVBiMH26Zo5zrNjOA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Mar 13, 2015 at 1:21 PM, Mirza Krak <mirza.krak@hostmobility.com> wrote:
> Realized now that the ledtrig-netdev driver is not mainline :).
>
> Found it here https://lkml.org/lkml/2010/11/14/116.
>
> Tested it with a CAN device now, and it works great.

I think that that trigger has been developed for dd-wrt or some other
router distro, and it's not going be mainlined since it does not
comply with the sysfs guidelines and no one ever fixed it -- that
would also break compatibility with the existing users so it's not a
trivial issue.

>>> So I got "can0-tx" running. But I have only one LED, that is called
>>> "Data" and it just shows activity. It seems like one cannot combine
>>> two triggers for one LED. Do I see it right? If yes, what about
>>> creating another event called iface-rxtx or iface-activity like LEDs
>>> in network interfaces?

That's correct, the LED subsystem does not have any facility to
combine triggers, and the existing ones are separated and for tx-rx.
If you need a combined version you would either have to hack the
current code to trigger one for both events (which is trivial) or
maybe write some generic combining extension at LED subsystem level...
send patches! :-)

>>> What about errors? We have also "Error" LED. The main purpose is to
>>> indicate "bus off" state.

That would be also easy to implement but since the errors are
propagated through the can netdev and should not be too much traffic
you could probably handle that in userspace (that's what I would do
anyway).

Cheers,
Fabio

-- 
Fabio Baltieri
