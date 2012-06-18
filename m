From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 3/6] canfd: add support for CAN FD in CAN_RAW sockets
Date: Mon, 18 Jun 2012 19:39:43 +0200
Message-ID: <4FDF67DF.9000905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:52233 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2FRRjm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:39:42 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

- introduce a new sockopt CAN_RAW_FD_FRAMES to allow CAN FD frames
- handle CAN frames and CAN FD frames simultaneously when enabled

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/raw.h |    3 ++-
 net/can/raw.c           |   50 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index 781f3a3..a814062 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -23,7 +23,8 @@ enum {
 	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
 	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
-	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
+	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
+	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 };
  #endif
diff --git a/net/can/raw.c b/net/can/raw.c
index cde1b4a..44638c5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -82,6 +82,7 @@ struct raw_sock {
 	struct notifier_block notifier;
 	int loopback;
 	int recv_own_msgs;
+	int fd_frames;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
@@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 +	/* do not pass frames with DLC > 8 to a legacy socket */
+	if (!ro->fd_frames) {
+		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
+
+		if (unlikely(cfd->len > CAN_MAX_DLEN))
+			return;
+	}
+
 	/* clone the given skb to be able to enqueue it into the rcv queue */
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (!skb)
@@ -291,6 +300,7 @@ static int raw_init(struct sock *sk)
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
+	ro->fd_frames        = 0;
  	/* set notifier */
 	ro->notifier.notifier_call = raw_notifier;
@@ -569,6 +579,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
  		break;
 +	case CAN_RAW_FD_FRAMES:
+		if (optlen != sizeof(ro->fd_frames))
+			return -EINVAL;
+
+		if (copy_from_user(&ro->fd_frames, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -627,6 +646,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->recv_own_msgs;
 		break;
 +	case CAN_RAW_FD_FRAMES:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->fd_frames;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -662,8 +687,13 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 	} else
 		ifindex = ro->ifindex;
 -	if (size != sizeof(struct can_frame))
-		return -EINVAL;
+	if (ro->fd_frames) {
+		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
+			return -EINVAL;
+	} else {
+		if (unlikely(size != CAN_MTU))
+			return -EINVAL;
+	}
  	dev = dev_get_by_index(&init_net, ifindex);
 	if (!dev)
@@ -708,7 +738,9 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 		       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct sk_buff *skb;
+	int rxmtu;
 	int err = 0;
 	int noblock;
 @@ -719,10 +751,20 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (!skb)
 		return err;
 -	if (size < skb->len)
+	/*
+	 * when serving a legacy socket the DLC <= 8 is already checked inside
+	 * raw_rcv(). Now check if we need to pass a canfd_frame to a legacy
+	 * socket and cut the possible CANFD_MTU/CAN_MTU length to CAN_MTU
+	 */
+	if (!ro->fd_frames)
+		rxmtu = CAN_MTU;
+	else
+		rxmtu = skb->len;
+
+	if (size < rxmtu)
 		msg->msg_flags |= MSG_TRUNC;
 	else
-		size = skb->len;
+		size = rxmtu;
  	err = memcpy_toiovec(msg->msg_iov, skb->data, size);
 	if (err < 0) {
-- 
1.7.10.4

