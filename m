From: kbuild test robot <fengguang.wu@intel.com>
Subject: [mkl-can-next:j1939 16/142] net/can/j1939/socket.c:789:20: sparse:
 incorrect type in initializer (incompatible argument 3 (different base
 types))
Date: Thu, 15 Feb 2018 14:40:59 +0800
Message-ID: <201802151457.cPtB0nDc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48187 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbeBOGlL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 15 Feb 2018 01:41:11 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git j1939
head:   3849d25ff0e2c0a6fa5ecfcf649661aa3dc371a2
commit: 434d073b7e77f77c072253b03ab0e6ca3668e8a6 [16/142] can-j1939: Import SAE J1939
reproduce:
        # apt-get install sparse
        git checkout 434d073b7e77f77c072253b03ab0e6ca3668e8a6
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv' in incomplete struct dev_rcv_lists
   net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv' in incomplete struct dev_rcv_lists
   net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv' in incomplete struct dev_rcv_lists
   net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv' in incomplete struct dev_rcv_lists
   net/can/j1939/socket.c:707:32: sparse: incorrect type in argument 2 (different base types) @@ expected unsigned short tsflags @@ got ed] tsflags @@
   net/can/j1939/socket.c:707:32: expected unsigned short tsflags
   net/can/j1939/socket.c:707:32: got unsigned char
   net/can/j1939/socket.c:707:26: sparse: not enough arguments for function sock_tx_timestamp
>> net/can/j1939/socket.c:789:20: sparse: incorrect type in initializer (incompatible argument 3 (different base types)) @@ expected int ( )( ... ) @@ got int ( )( ... ) @@
   net/can/j1939/socket.c:789:20: expected int ( )( ... )
   net/can/j1939/socket.c:789:20: got int ( )( ... )
   net/can/j1939/j1939-priv.h:271:41: sparse: unknown expression (8 46)
   net/can/j1939/j1939-priv.h:271:41: sparse: unknown expression (8 46)
   net/can/j1939/j1939-priv.h:271:41: sparse: unknown expression (8 46)
   net/can/j1939/j1939-priv.h:271:41: sparse: unknown expression (8 46)
   In file included from net/can/j1939/socket.c:24:0:
   net/can/j1939/j1939-priv.h: In function 'dev_j1939_priv':
   net/can/j1939/j1939-priv.h:271:34: error: dereferencing pointer to incomplete type 'struct dev_rcv_lists'
    priv = can_ml_priv can_ml_priv->j1939_priv : NULL;
    ^~
   net/can/j1939/socket.c: In function 'j1939sk_sendmsg':
   net/can/j1939/socket.c:707:24: warning: passing argument 2 of 'sock_tx_timestamp' makes integer from pointer without a cast
    sock_tx_timestamp(sk, &skb_shinfo(skb)->tx_flags);
    ^
   In file included from include/linux/can/skb.h:17:0,
    from net/can/j1939/socket.c:22:
   include/net/sock.h:2279:20: note: expected '__u16 {aka short unsigned int}' but argument is of type '__u8 COPYING CREDITS Documentation Kbuild Kconfig LICENSES MAINTAINERS Makefile README arch block certs crypto drivers firmware fs include init ipc kernel lib mm net samples scripts security sound tools usr virt {aka unsigned char
    static inline void sock_tx_timestamp(const struct sock __u16 tsflags,
    ^~~~~~~~~~~~~~~~~
   net/can/j1939/socket.c:707:2: error: too few arguments to function 'sock_tx_timestamp'
    sock_tx_timestamp(sk, &skb_shinfo(skb)->tx_flags);
    ^~~~~~~~~~~~~~~~~
   In file included from include/linux/can/skb.h:17:0,
    from net/can/j1939/socket.c:22:
   include/net/sock.h:2279:20: note: declared here
    static inline void sock_tx_timestamp(const struct sock __u16 tsflags,
    ^~~~~~~~~~~~~~~~~
   net/can/j1939/socket.c: At top level:
   net/can/j1939/socket.c:789:13: error: initialization from incompatible pointer type
    .getname = j1939sk_getname,
    ^~~~~~~~~~~~~~~
   net/can/j1939/socket.c:789:13: note: (near initialization for 'j1939_ops.getname')
   cc1: some warnings being treated as errors

vim +789 net/can/j1939/socket.c

   657	
   658	static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
   659	{
   660		struct sock *sk = sock->sk;
   661		struct j1939_sock *jsk = j1939_sk(sk);
   662		struct sockaddr_can *addr = msg->msg_name;
   663		struct j1939_sk_buff_cb *skcb;
   664		struct sk_buff *skb;
   665		struct net_device *dev;
   666		int ifindex;
   667		int ret;
   668	
   669		/* various socket state tests */
   670		if (!(jsk->state & JSK_BOUND))
   671			return -EBADFD;
   672	
   673		ifindex = jsk->ifindex_started;
   674		if (!ifindex)
   675			return -EBADFD;
   676	
   677		if (jsk->addr.sa == J1939_NO_ADDR && !jsk->addr.src)
   678			/* no address assigned yet */
   679			return -EBADFD;
   680	
   681		/* deal with provided address info */
   682		if (msg->msg_name) {
   683			if (msg->msg_namelen < J1939_MIN_NAMELEN)
   684				return -EINVAL;
   685			if (addr->can_family != AF_CAN)
   686				return -EINVAL;
   687			if (addr->can_ifindex && (ifindex != addr->can_ifindex))
   688				return -EBADFD;
   689		}
   690	
   691		dev = dev_get_by_index(&init_net, ifindex);
   692		if (!dev)
   693			return -ENXIO;
   694	
   695		skb = sock_alloc_send_skb(sk, size + sizeof(struct can_frame) - sizeof(((struct can_frame*)NULL)->data) + sizeof(struct can_skb_priv),
   696				msg->msg_flags & MSG_DONTWAIT, &ret);
   697		if (!skb)
   698			goto put_dev;
   699	
   700		can_skb_reserve(skb);
   701		can_skb_prv(skb)->ifindex = dev->ifindex;
   702		skb_reserve(skb, offsetof(struct can_frame, data));
   703	
   704		ret = memcpy_from_msg(skb_put(skb, size), msg, size);
   705		if (ret < 0)
   706			goto free_skb;
 > 707		sock_tx_timestamp(sk, &skb_shinfo(skb)->tx_flags);
   708	
   709		skb->dev = dev;
   710	
   711		skcb = (void *)skb->cb;
   712		memset(skcb, 0, sizeof(*skcb));
   713		skcb->msg_flags = msg->msg_flags;
   714		skcb->srcname = jsk->addr.src;
   715		skcb->dstname = jsk->addr.dst;
   716		skcb->pgn = jsk->addr.pgn;
   717		skcb->priority = j1939_prio(jsk->sk.sk_priority);
   718		skcb->srcaddr = jsk->addr.sa;
   719		skcb->dstaddr = jsk->addr.da;
   720	
   721		if (msg->msg_name) {
   722			struct sockaddr_can *addr = msg->msg_name;
   723	
   724			if (addr->can_addr.j1939.name ||
   725					(addr->can_addr.j1939.addr != J1939_NO_ADDR)) {
   726				skcb->dstname = addr->can_addr.j1939.name;
   727				skcb->dstaddr = addr->can_addr.j1939.addr;
   728			}
   729			if (pgn_is_valid(addr->can_addr.j1939.pgn))
   730				skcb->pgn = addr->can_addr.j1939.pgn;
   731		}
   732		if (!pgn_is_valid(skcb->pgn)) {
   733			ret = -EINVAL;
   734			goto free_skb;
   735		}
   736	
   737		if (skcb->msg_flags & J1939_MSG_SYNC) {
   738			if (skcb->msg_flags & MSG_DONTWAIT) {
   739				ret = j1939_sock_pending_add_first(&jsk->sk);
   740				if (ret > 0)
   741					ret = -EAGAIN;
   742			} else {
   743				ret = wait_event_interruptible(jsk->waitq,
   744						j1939_sock_pending_add_first(&jsk->sk));
   745			}
   746			if (ret < 0)
   747				goto free_skb;
   748		} else {
   749			j1939_sock_pending_add(&jsk->sk);
   750		}
   751	
   752		ret = j1939_send(skb);
   753		if (ret < 0)
   754			j1939_sock_pending_del(&jsk->sk);
   755	
   756		dev_put(dev);
   757		return (ret < 0) ? ret : size;
   758	
   759	free_skb:
   760		kfree_skb(skb);
   761	put_dev:
   762		dev_put(dev);
   763		return ret;
   764	}
   765	
   766	void j1939sk_netdev_event(int ifindex, int error_code)
   767	{
   768		struct j1939_sock *jsk;
   769	
   770		spin_lock_bh(&j1939_socks_lock);
   771		list_for_each_entry(jsk, &j1939_socks, list) {
   772			if (jsk->sk.sk_bound_dev_if != ifindex)
   773				continue;
   774			jsk->sk.sk_err = error_code;
   775			if (!sock_flag(&jsk->sk, SOCK_DEAD))
   776				jsk->sk.sk_error_report(&jsk->sk);
   777			/* do not remove filters here */
   778		}
   779		spin_unlock_bh(&j1939_socks_lock);
   780	}
   781	
   782	static const struct proto_ops j1939_ops = {
   783		.family = PF_CAN,
   784		.release = j1939sk_release,
   785		.bind = j1939sk_bind,
   786		.connect = j1939sk_connect,
   787		.socketpair = sock_no_socketpair,
   788		.accept = sock_no_accept,
 > 789		.getname = j1939sk_getname,
   790		.poll = datagram_poll,
   791		.ioctl = can_ioctl,
   792		.listen = sock_no_listen,
   793		.shutdown = sock_no_shutdown,
   794		.setsockopt = j1939sk_setsockopt,
   795		.getsockopt = j1939sk_getsockopt,
   796		.sendmsg = j1939sk_sendmsg,
   797		.recvmsg = j1939sk_recvmsg,
   798		.mmap = sock_no_mmap,
   799		.sendpage = sock_no_sendpage,
   800	};
   801	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
