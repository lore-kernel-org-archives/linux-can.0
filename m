From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Request-for-testing: j1939
Date: Wed, 11 Oct 2017 20:55:05 +0200
Message-ID: <20171011185505.GA14489@airbook.vandijck-laurijssen.be>
References: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
 <20171008131300.GA24772@airbook.vandijck-laurijssen.be>
 <20171008134441.GA13065@airbook.vandijck-laurijssen.be>
 <20171010164203.GA4297@airbook.vandijck-laurijssen.be>
 <D6ADCA1B-58FD-4037-BA08-2219BD96B4B6@climate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:36790 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbdJKSzJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Oct 2017 14:55:09 -0400
Content-Disposition: inline
In-Reply-To: <D6ADCA1B-58FD-4037-BA08-2219BD96B4B6@climate.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <elenita.hinds@climate.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita Hinds <ecathinds@gmail.com>

> Hi Kurt,
> 
> I’ve been testing on my end, including the latest commits below, and here are a couple of feedback:
> 
> 1) [Very minor]  In net/can/j1939/main.c, line 315: I wonder if the ‘printk’ statement is still necessary for a final release.

That line (I think marc added it) must indeed go at some point.
It triggered me to make less use of that function.

> 
> 2) I’m currently encountering a problem where the receiving of packets stops at some point. My test source is still sending the J1939 packets and the device is receiving these packets (verified through an oscilloscope) but both ‘candump’ and ‘testj1939’ tools stop printing data at some point (same packet termination). If I run without the j1939 and just raw CAN using ‘candump', the tool runs infinitely. I’m still digging through the code but I wonder if this is something you’ve seen before and may have some advice.

This sounds bad, but I cannot yet believe it is related to can-j1939
only. The most probable I can think of that adding can-j1939 introduces
more work on the cpu and that may have negative side effects, but again,
that's pure guessing.

I haven't encountered it yet.
I'm not doing long tests anymore lately, so I may have missed it.

This deserves to be investigated: which hardware do you use?

Kurt

> 
> Thanks,
> Elenita
> 
> 
> 
> > On Oct 10, 2017, at 11:44 AM, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> > 
> > Marc et al.,
> > 
> > I finalized a working branch (only static addressing tested so far).
> > Device management behaves well at this point, transport protocol send &
> > recv, ...
> > 
> > I pushed a new https://github.com/kurt-vd/linux/tree/can-next-j1939
> > (well, I was a bit supprised I could push this one, without --force
> > even).
> > Unfortunately, I must postpone tests with dynamic addressing at least a
> > week now.
> > 
> > @Marc,
> > I suppose that when the tiny bits are fixed, then this can easily be
> > rebased to today's can-next without major impact, isn't it?
> > 
> > Kind regards,
> > Kurt
> > 
> > --- Original message ---
> >> Date:   Sun, 8 Oct 2017 15:44:41 +0200
> >> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> >> To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
> >> <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita
> >> Hinds <ecathinds@gmail.com>
> >> Subject: Re: Request-for-testing: j1939
> >> User-Agent: Mutt/1.5.22 (2013-10-16)
> >> 
> >> Small update: unplugging the hardware produces a problem with open
> >> sockets. I think this is what you tried to solve, and I reverted since
> >> it dealt with iface down ...
> >> You probably needed to tests against 'ENODEV' rather than ENETDOWN to
> >> satisfy my tests :-)
> >> I'll work on this ...
> >> 
> >> Kurt
> >> 
> >>>> Hello,
> >>>> 
> >>>> I've worked my way a bit through the lower layers of the j1939 stack.
> >>>> While there I cleaned up the livetime handling of the j1939 object and
> >>>> the bind() and connect() functions. Unplugging a USB network device
> >>>> while a application is running should now be possible.
> >>>> 
> >>>> The patch stack consists of ~100 patches, ~15 of them are cleanups for
> >>>> the af_can. I'm not going to post the patches here for review, testing
> >>>> is much more welcome. Maybe we can put together a testsuite.
> >>>> 
> >>>> The branch is available at my kernel.org linux-can-next repo in the
> >>>> j1939 branch.
> >>>> 
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
> >>> 
> >>> Marc,
> >>> 
> >>> I completed some tests on your branch.
> >>> I did amend some tiny patches, please find them
> >>> at https://github.com/kurt-vd/linux/tree/can-next-j1939
> >>> 
> >>> I did revert 1 patch which I mentioned already some days ago,
> >>> I did 2 optimizations, eliminating locks, and added 2 fixes.
> >>> 
> >>> I did take the effort to test with 2 CAN adapters this time, since
> >>> Elenita had pointed me to a mistake that wasn't revealed doing tests
> >>> locally using vcan :-)
> >>> 
> >>> The stack seems operational, ready for more tests.
> >>> 
> >>> Kurt
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
