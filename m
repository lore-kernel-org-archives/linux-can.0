From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: bind() and connect()
Date: Wed, 16 Aug 2017 23:08:31 +0200
Message-ID: <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:33924 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbdHPVKT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 17:10:19 -0400
Content-Disposition: inline
In-Reply-To: <20170815122453.3945bead@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

> On Tue, 15 Aug 2017 11:16:44 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
> > On 08/15/2017 11:01 AM, David Jander wrote:
> > > On Tue, 15 Aug 2017 10:14:18 +0200
> > > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >   
> > >> On 08/14/2017 07:37 PM, Marc Kleine-Budde wrote:  
> > >>> - Should a second bind() be allowed on a previously bind() socket?
> > >>>
> > >>> As far as I understand the code, there's some support, but when the
> > >>> interface is switched, j1939_ifindex_stop() is not called.    
> > >>
> > >> Ah, there's a check, that you cannot re-bind() to another interface:
> > >>  
> > >>> 		if (bound_dev_if != addr->can_ifindex)    
> > > 
> > > This makes sense. re-bind() to another interface only would make sense if
> > > bind() to any interface is also permitted, but that would imply separate
> > > address-claims on all different interfaces with potentially different
> > > source-address being claimed on each one.... don't think the stack should take
> > > care of such complex scenarios, at least not at first IMHO.  
> > 
> > Bind to any interface doesn't work, you cannot send anything:
> > 
> > > static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> > > {  
> > [...]
> > > 	ifindex = jsk->ifindex_started;
> > > 	if (!ifindex)
> > > 		return -EBADFD;  
> > 
> > And you will probably not receive anything, as the rx-register, which
> > takes place in j1939_ifindex_start() is not done if you try to bind to
> > any device (bound_dev_if == 0).

which is like calling tcpdump when the interface is down, yep.
That's a stupid thing to do, but not necessarily a bad API.

> > 
> > > 	if (bound_dev_if && bound_dev_if != jsk->ifindex_started) {  
> > [...]
> > > 
> > > 		ret = j1939_ifindex_start(bound_dev_if);  
> > 
> > Then I'll add proper test, that you have to bind to a specific
> > interface. That will make the code much simpler.

I agree that in contrast to my initial goal, binding to any interface
complicates things. Since j1939 is not a routed protocol, you should be
aware of at least which interface you're running on.
Userspace programs can still default to can0 :-)

And it probably simplifies the socket code quite much. That's a good
thing too.

> 
> I agree. Don't know if the case for bind-any will ever be necessary in the
> context of J1939, but we certainly should keep things simple for now.
> I've had cases myself where an ECU would talk J1939 on two interfaces at the
> same time, but not yet something like a Group-Function server exporting the
> same functions on more than one interface. I could think of that use-case
> happening though, but it can also be solved easily in user-space opening more
> than one socket...

Indeed, logical ECU's connected to 2+ j1939 busses cannot take any
advantage by combining multiple interfaces. the 2+ busses will always be
addressed independantly, like David suggests by opening more sockets.

Kind regards,
Kurt
