From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 09/14] can: raw: use struct sock::sk_bound_dev_if instead
 of struct raw_sock::ifindex
Date: Thu, 24 Aug 2017 16:11:26 +0200
Message-ID: <20170824141126.GD21548@airbook.vandijck-laurijssen.be>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-10-mkl@pengutronix.de>
 <da0c99fe-16ca-6e3a-0249-663b0691c850@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:34331 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHXOL3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 10:11:29 -0400
Content-Disposition: inline
In-Reply-To: <da0c99fe-16ca-6e3a-0249-663b0691c850@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

> >This patch removes the struct raw_sock::ifindex from the CAN raw socket
> >and uses the already existing sock::sk_bound_dev_if instead.
> 
> I would like to omit this patch.
> 
> 1. It does NOT increase the readability ;-)
> 
> ifindex points out that we are handling an interface index.
> sk_bound_dev_if could be anything.

See http://elixir.free-electrons.com/linux/v4.12.8/source/net/core/sock.c#L617
sk_bound_dev_if may be a difficult name, but could not be anything.
It allow to use SO_BINDTODEVICE (man 7 socket) to work properly for can raw sockets too.

> 
> 2. I have bad feelings on using data structures from the general networking
> code as I had various discussions with e.g. iif in struct netdevice so that
> we needed to store our CAN specific incoming interface in a separated space
> before skb->data.

sock::sk_bound_dev_if happens to be semantically identical to raw_sock::ifindex.
The grounds for discussions are IMHO very limited in this matter.
It also helps to check for the net device being a CAN device first.

Kind regards,
Kurt
> 
> Regards,
> Oliver
> 
> >
> >Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >---
> >  net/can/raw.c | 33 +++++++++++++++------------------
> >  1 file changed, 15 insertions(+), 18 deletions(-)
> >
> >diff --git a/net/can/raw.c b/net/can/raw.c
> >index 864c80dbdb72..80a1545bf51a 100644
> >--- a/net/can/raw.c
> >+++ b/net/can/raw.c
> >@@ -83,7 +83,6 @@ struct uniqframe {
> >  struct raw_sock {
> >  	struct sock sk;
> >  	int bound;
> >-	int ifindex;
> >  	struct notifier_block notifier;
> >  	int loopback;
> >  	int recv_own_msgs;
> >@@ -279,7 +278,7 @@ static int raw_notifier(struct notifier_block *nb,
> >  	if (dev->type != ARPHRD_CAN)
> >  		return NOTIFY_DONE;
> >-	if (ro->ifindex != dev->ifindex)
> >+	if (sk->sk_bound_dev_if != dev->ifindex)
> >  		return NOTIFY_DONE;
> >  	switch (msg) {
> >@@ -293,7 +292,7 @@ static int raw_notifier(struct notifier_block *nb,
> >  		if (ro->count > 1)
> >  			kfree(ro->filter);
> >-		ro->ifindex = 0;
> >+		sk->sk_bound_dev_if = 0;
> >  		ro->bound   = 0;
> >  		ro->count   = 0;
> >  		release_sock(sk);
> >@@ -318,7 +317,6 @@ static int raw_init(struct sock *sk)
> >  	struct raw_sock *ro = raw_sk(sk);
> >  	ro->bound            = 0;
> >-	ro->ifindex          = 0;
> >  	/* set default filter to single entry dfilter */
> >  	ro->dfilter.can_id   = 0;
> >@@ -361,10 +359,10 @@ static int raw_release(struct socket *sock)
> >  	/* remove current filters & unregister */
> >  	if (ro->bound) {
> >-		if (ro->ifindex) {
> >+		if (sk->sk_bound_dev_if) {
> >  			struct net_device *dev;
> >-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> >+			dev = dev_get_by_index(sock_net(sk), sk->sk_bound_dev_if);
> >  			if (dev) {
> >  				raw_disable_allfilters(dev_net(dev), dev, sk);
> >  				dev_put(dev);
> >@@ -376,7 +374,7 @@ static int raw_release(struct socket *sock)
> >  	if (ro->count > 1)
> >  		kfree(ro->filter);
> >-	ro->ifindex = 0;
> >+	sk->sk_bound_dev_if = 0;
> >  	ro->bound   = 0;
> >  	ro->count   = 0;
> >  	free_percpu(ro->uniq);
> >@@ -404,7 +402,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> >  	lock_sock(sk);
> >-	if (ro->bound && addr->can_ifindex == ro->ifindex)
> >+	if (ro->bound && addr->can_ifindex == sk->sk_bound_dev_if)
> >  		goto out;
> >  	if (addr->can_ifindex) {
> >@@ -438,11 +436,11 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> >  	if (!err) {
> >  		if (ro->bound) {
> >  			/* unregister old filters */
> >-			if (ro->ifindex) {
> >+			if (sk->sk_bound_dev_if) {
> >  				struct net_device *dev;
> >  				dev = dev_get_by_index(sock_net(sk),
> >-						       ro->ifindex);
> >+						       sk->sk_bound_dev_if);
> >  				if (dev) {
> >  					raw_disable_allfilters(dev_net(dev),
> >  							       dev, sk);
> >@@ -451,7 +449,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> >  			} else
> >  				raw_disable_allfilters(sock_net(sk), NULL, sk);
> >  		}
> >-		ro->ifindex = ifindex;
> >+		sk->sk_bound_dev_if = ifindex;
> >  		ro->bound = 1;
> >  	}
> >@@ -472,14 +470,13 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
> >  {
> >  	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
> >  	struct sock *sk = sock->sk;
> >-	struct raw_sock *ro = raw_sk(sk);
> >  	if (peer)
> >  		return -EOPNOTSUPP;
> >  	memset(addr, 0, sizeof(*addr));
> >  	addr->can_family  = AF_CAN;
> >-	addr->can_ifindex = ro->ifindex;
> >+	addr->can_ifindex = sk->sk_bound_dev_if;
> >  	*len = sizeof(*addr);
> >@@ -524,8 +521,8 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
> >  		lock_sock(sk);
> >-		if (ro->bound && ro->ifindex)
> >-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> >+		if (ro->bound && sk->sk_bound_dev_if)
> >+			dev = dev_get_by_index(sock_net(sk), sk->sk_bound_dev_if);
> >  		if (ro->bound) {
> >  			/* (try to) register the new filters */
> >@@ -578,8 +575,8 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
> >  		lock_sock(sk);
> >-		if (ro->bound && ro->ifindex)
> >-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> >+		if (ro->bound && sk->sk_bound_dev_if)
> >+			dev = dev_get_by_index(sock_net(sk), sk->sk_bound_dev_if);
> >  		/* remove current error mask */
> >  		if (ro->bound) {
> >@@ -743,7 +740,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> >  		ifindex = addr->can_ifindex;
> >  	} else
> >-		ifindex = ro->ifindex;
> >+		ifindex = sk->sk_bound_dev_if;
> >  	if (ro->fd_frames) {
> >  		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
