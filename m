From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Request-for-testing: j1939
Date: Tue, 10 Oct 2017 18:44:26 +0200
Message-ID: <20171010164203.GA4297@airbook.vandijck-laurijssen.be>
References: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
 <20171008131300.GA24772@airbook.vandijck-laurijssen.be>
 <20171008134441.GA13065@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:47993 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdJJQod (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Oct 2017 12:44:33 -0400
Content-Disposition: inline
In-Reply-To: <20171008134441.GA13065@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita Hinds <ecathinds@gmail.com>

Marc et al.,

I finalized a working branch (only static addressing tested so far).
Device management behaves well at this point, transport protocol send &
recv, ...

I pushed a new https://github.com/kurt-vd/linux/tree/can-next-j1939
(well, I was a bit supprised I could push this one, without --force
even).
Unfortunately, I must postpone tests with dynamic addressing at least a
week now.

@Marc,
I suppose that when the tiny bits are fixed, then this can easily be
rebased to today's can-next without major impact, isn't it?

Kind regards,
Kurt

--- Original message ---
> Date:   Sun, 8 Oct 2017 15:44:41 +0200
> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
>  <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita
>  Hinds <ecathinds@gmail.com>
> Subject: Re: Request-for-testing: j1939
> User-Agent: Mutt/1.5.22 (2013-10-16)
> 
> Small update: unplugging the hardware produces a problem with open
> sockets. I think this is what you tried to solve, and I reverted since
> it dealt with iface down ...
> You probably needed to tests against 'ENODEV' rather than ENETDOWN to
> satisfy my tests :-)
> I'll work on this ...
> 
> Kurt
> 
> > > Hello,
> > > 
> > > I've worked my way a bit through the lower layers of the j1939 stack.
> > > While there I cleaned up the livetime handling of the j1939 object and
> > > the bind() and connect() functions. Unplugging a USB network device
> > > while a application is running should now be possible.
> > > 
> > > The patch stack consists of ~100 patches, ~15 of them are cleanups for
> > > the af_can. I'm not going to post the patches here for review, testing
> > > is much more welcome. Maybe we can put together a testsuite.
> > > 
> > > The branch is available at my kernel.org linux-can-next repo in the
> > > j1939 branch.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
> > 
> > Marc,
> > 
> > I completed some tests on your branch.
> > I did amend some tiny patches, please find them
> > at https://github.com/kurt-vd/linux/tree/can-next-j1939
> > 
> > I did revert 1 patch which I mentioned already some days ago,
> > I did 2 optimizations, eliminating locks, and added 2 fixes.
> > 
> > I did take the effort to test with 2 CAN adapters this time, since
> > Elenita had pointed me to a mistake that wasn't revealed doing tests
> > locally using vcan :-)
> > 
> > The stack seems operational, ready for more tests.
> > 
> > Kurt
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
