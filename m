From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Request-for-testing: j1939
Date: Sun, 8 Oct 2017 15:44:41 +0200
Message-ID: <20171008134441.GA13065@airbook.vandijck-laurijssen.be>
References: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
 <20171008131300.GA24772@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:44097 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdJHNoo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Oct 2017 09:44:44 -0400
Content-Disposition: inline
In-Reply-To: <20171008131300.GA24772@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita Hinds <ecathinds@gmail.com>

Small update: unplugging the hardware produces a problem with open
sockets. I think this is what you tried to solve, and I reverted since
it dealt with iface down ...
You probably needed to tests against 'ENODEV' rather than ENETDOWN to
satisfy my tests :-)
I'll work on this ...

Kurt

> > Hello,
> > 
> > I've worked my way a bit through the lower layers of the j1939 stack.
> > While there I cleaned up the livetime handling of the j1939 object and
> > the bind() and connect() functions. Unplugging a USB network device
> > while a application is running should now be possible.
> > 
> > The patch stack consists of ~100 patches, ~15 of them are cleanups for
> > the af_can. I'm not going to post the patches here for review, testing
> > is much more welcome. Maybe we can put together a testsuite.
> > 
> > The branch is available at my kernel.org linux-can-next repo in the
> > j1939 branch.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
> 
> Marc,
> 
> I completed some tests on your branch.
> I did amend some tiny patches, please find them
> at https://github.com/kurt-vd/linux/tree/can-next-j1939
> 
> I did revert 1 patch which I mentioned already some days ago,
> I did 2 optimizations, eliminating locks, and added 2 fixes.
> 
> I did take the effort to test with 2 CAN adapters this time, since
> Elenita had pointed me to a mistake that wasn't revealed doing tests
> locally using vcan :-)
> 
> The stack seems operational, ready for more tests.
> 
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
