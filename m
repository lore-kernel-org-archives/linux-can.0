From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Request-for-testing: j1939
Date: Thu, 5 Oct 2017 21:01:53 +0200
Message-ID: <20171005190153.GA3226@airbook.vandijck-laurijssen.be>
References: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
 <20170824071519.GA22055@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:50274 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdJETB5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2017 15:01:57 -0400
Content-Disposition: inline
In-Reply-To: <20170824071519.GA22055@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

Marc,

I got to testing your work.

commit 89b45fdafe8c7edbff6c2bd9bb51460732410e21 introduces a problem:
if I do 'ip link set can0 down' when j1939 sockets are open,
then j1939sk_release produces a page fault.

That particular commit decouples name & sa from the (j1939) netdev,
but j1939sk_release will do that too.
I imagined that 'ip link set can0 down; ip link set can0 up' is
something a client program may choose to survive, and so the netdev down
event isn't propagated that way. If a program chose to quit,
j1939sk_release is called which cleans up bound names & addresses.

Any opinions?
I will try with that commit reverted. I don't expect negative side
effects :-)

I did not experiment yet with device removal, something this commit did
not catch either.

Kurt

> --- Original message ---
> > Date: Wed, 23 Aug 2017 17:17:54 +0200
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck
> >  <dev.kurt@vandijck-laurijssen.be>, David Jander <david@protonic.nl>
> > Subject: Request-for-testing: j1939
> > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
> >  Thunderbird/52.2.1
> > 
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
> > 
> > regards,
> > Marc
> > -- 
> > Pengutronix e.K.                  | Marc Kleine-Budde           |
> > Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> > Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> > Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> > 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
