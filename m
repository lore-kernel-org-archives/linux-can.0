From: David Jander <david@protonic.nl>
Subject: Re: j1939: bind() and connect()
Date: Wed, 16 Aug 2017 12:29:27 +0200
Message-ID: <20170816122927.02b362af@erd980>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
        <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
        <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4951 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdHPK33 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 06:29:29 -0400
In-Reply-To: <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On Wed, 16 Aug 2017 12:06:50 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 08/16/2017 11:34 AM, Kurt Van Dijck wrote:
> >> Hello Kurt,
> >>
> >> I've a few questions about the j1939 socket model:
> >>
> >> - Should bind() be allowed to any interface, i.e. with can_ifindex == 0?
> >>
> >> I don't think so, but it's never checked for this.  
> > 
> > I'll explain a bit what I tried to accomplish:
> > * allow bind to any interface, for receive packets only (obviously)
> > * for rx/tx, only bind to 1 interface.  
> 
> Have you tested this? If I understand the code correctly
> j1939_ifindex_start() will not be called. So you will only receive
> packages from interfaces someone has other socket has bind() to, thus
> called j1939_ifindex_start(). And you'll stop receiving packages once
> the last socket on that interfaces is closed.
> 
> >> - Should a connect() without a previous bind() be allowed?
> >>
> >> It's not checked for, but the error handling in sk_connect doesn't take
> >> that into account.  
> > 
> > Like UDP will auto-bind to the first known local address ...
> > Then an application would not need to know the local address to use.  
> 
> Which will be:
> 
> > static int j1939sk_init(struct sock *sk)
> > {  
> [...]
> > 	jsk->addr.sa = J1939_NO_ADDR;
> > 	jsk->addr.da = J1939_NO_ADDR;
> > 	jsk->addr.pgn = J1939_NO_PGN;  
> [...]
> > }  
> 
> > static int j1939sk_connect(struct socket *sock, struct sockaddr *uaddr,
> > 			   int len, int flags)  
> [...]
> > 		j1939_name_local_get(priv, jsk->addr.src);
> > 		j1939_addr_local_get(priv, jsk->addr.sa);  
> 
> right? Does this work, as sendmsg tests:
> 
> > static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> > {  
> [...]
> > 	if (jsk->addr.sa == J1939_NO_ADDR && !jsk->addr.src)
> > 		/* no address assigned yet */
> > 		return -EBADFD;
> >   
> 
> >> - Should a second bind() be allowed on a previously bind() socket?  
> > 
> > Yes, definitely.
> > This is required to support dynamic addressing without possible losing
> > relevant messages.  
> 
> With changing the interface or not?
> 
> >> As far as I understand the code, there's some support, but when the
> >> interface is switched, j1939_ifindex_stop() is not called.
> >>
> >> - Should a second conect() be allowed on a previously connect() socket?  
> > 
> > Never thought on that. This would equally be necessary when the remote
> > changes SA, but I consider this not a core requirement, since changing
> > SA implies possible glitches in the upper applications anyway.
> > closing socket and reopening a new one is allowed in that case.  
> 
> So I'll add a check against a re-connect().

Hmmm... in theory, any node can change SA at any time due to a re-claim. I
always try to make this as transparent as possible to applications. The worst
that I would deem acceptable to happen is that a transport session times-out
and is transparently re-started, or a single message gets lost due to the
inherent race of switching address. Why is a re-connect necessary if one
connects to the NAME instead of the SA?

Best regards,

-- 
David Jander
Protonic Holland.
