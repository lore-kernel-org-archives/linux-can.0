From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE to eliminate duplicate matches
Date: Tue, 17 Mar 2015 13:58:27 +0100
Message-ID: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:36715 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbbCQM6m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 08:58:42 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The CAN_RAW socket can set multiple CAN identifier specific filters that lead
to multiple filters in the af_can.c filter processing. These filters are
indenpendent from each other which leads to logical OR'ed filters when applied.

Especially when the filter is intended to notch single CAN IDs or CAN ID ranges
a problem emerges when using more than just one filter: The notched CAN IDs
will be delivered once while the other CAN IDs will be delivered twice.

This patch implements a new option to make sure that every CAN frame which is
filtered for a specific socket is only delivered once to the user space.
This is independent from the number of matching CAN filters of this socket.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/raw.h |  1 +
 net/can/raw.c                | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 78ec76f..723247a 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -57,6 +57,7 @@ enum {
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
+	CAN_RAW_FILTER_UNIQUE,	/* eliminate multiple filter matches */
 };
 
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index 00c13ef..e593dc7 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,6 +74,12 @@ MODULE_ALIAS("can-proto-1");
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
+/* structure to detect multiple filter matches for the same skb */
+struct unique_can_frame {
+	struct sk_buff *skb;
+	ktime_t tstamp;
+};
+
 struct raw_sock {
 	struct sock sk;
 	int bound;
@@ -82,10 +88,12 @@ struct raw_sock {
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
+	int filter_unique;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
+	struct unique_can_frame uniq_cf;
 };
 
 /*
@@ -119,6 +127,16 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
+	/* eliminate multiple filter matches for the same skb */
+	if (ro->filter_unique) {
+		if (ro->uniq_cf.skb == oskb &&
+		    ktime_equal(ro->uniq_cf.tstamp, oskb->tstamp))
+			return;
+
+		ro->uniq_cf.skb = oskb;
+		ro->uniq_cf.tstamp = oskb->tstamp;
+	}
+
 	/* do not pass non-CAN2.0 frames to a legacy socket */
 	if (!ro->fd_frames && oskb->len != CAN_MTU)
 		return;
@@ -296,6 +314,9 @@ static int raw_init(struct sock *sk)
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->filter_unique    = 0;
+	ro->uniq_cf.skb      = NULL;
+	ro->uniq_cf.tstamp   = ktime_set(0, 0);
 
 	/* set notifier */
 	ro->notifier.notifier_call = raw_notifier;
@@ -583,6 +604,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case CAN_RAW_FILTER_UNIQUE:
+		if (optlen != sizeof(ro->filter_unique))
+			return -EINVAL;
+
+		if (copy_from_user(&ro->filter_unique, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -647,6 +677,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->fd_frames;
 		break;
 
+	case CAN_RAW_FILTER_UNIQUE:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->filter_unique;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.1.4

