From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] can: introduce new raw socket option to join the given CAN filters
Date: Tue, 17 Mar 2015 20:10:56 +0100
Message-ID: <1426619456-855-2-git-send-email-socketcan@hartkopp.net>
References: <1426619456-855-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:39982 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbbCQTLV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 15:11:21 -0400
In-Reply-To: <1426619456-855-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The CAN_RAW socket can set multiple CAN identifier specific filters that lead
to multiple filters in the af_can.c filter processing. These filters are
indenpendent from each other which leads to logical OR'ed filters when applied.

This socket option joines the given CAN filters in the way that only CAN frames
are passed to user space that matched *all* given CAN filters. The semantic for
the applied filters is therefore changed to a logical AND.

This is useful especially when the filterset is a combination of filters where
the CAN_INV_FILTER flag is set in order to notch single CAN IDs or CAN ID
ranges from the incoming traffic.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 20 ++++++++++++++++++--
 include/uapi/linux/can/raw.h     |  1 +
 net/can/raw.c                    | 28 +++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 0a2859a..5abad1e 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -22,7 +22,8 @@ This file contains
       4.1.3 RAW socket option CAN_RAW_LOOPBACK
       4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
       4.1.5 RAW socket option CAN_RAW_FD_FRAMES
-      4.1.6 RAW socket returned message flags
+      4.1.6 RAW socket option CAN_RAW_JOIN_FILTERS
+      4.1.7 RAW socket returned message flags
     4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
       4.2.1 Broadcast Manager operations
       4.2.2 Broadcast Manager message flags
@@ -601,7 +602,22 @@ solution for a couple of reasons:
   CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
   The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
 
-  4.1.6 RAW socket returned message flags
+  4.1.6 RAW socket option CAN_RAW_JOIN_FILTERS
+
+  The CAN_RAW socket can set multiple CAN identifier specific filters that
+  lead to multiple filters in the af_can.c filter processing. These filters
+  are indenpendent from each other which leads to logical OR'ed filters when
+  applied (see 4.1.1).
+
+  This socket option joines the given CAN filters in the way that only CAN
+  frames are passed to user space that matched *all* given CAN filters. The
+  semantic for the applied filters is therefore changed to a logical AND.
+
+  This is useful especially when the filterset is a combination of filters
+  where the CAN_INV_FILTER flag is set in order to notch single CAN IDs or
+  CAN ID ranges from the incoming traffic.
+
+  4.1.7 RAW socket returned message flags
 
   When using recvmsg() call, the msg->msg_flags may contain following flags:
 
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 78ec76f..8735f108 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -57,6 +57,7 @@ enum {
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
+	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
 };
 
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index 9ecb768..7e46a47 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -82,6 +82,8 @@ struct raw_sock {
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
+	int join_filters;
+	int join_rx_count;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
@@ -124,10 +126,17 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* eliminate multiple filter matches for the same skb */
 	if (ro->uniq_skb == oskb &&
 	    ktime_equal(ro->uniq_tstamp, oskb->tstamp)){
-		return;
+		if (ro->join_filters) {
+			ro->join_rx_count++;
+			/* drop frame until all enabled filters matched */
+			if (ro->join_rx_count < ro->count)
+				return;
+		} else
+			return;
 	} else {
 		ro->uniq_skb = oskb;
 		ro->uniq_tstamp = oskb->tstamp;
+		ro->join_rx_count = 1;
 	}
 
 	/* do not pass non-CAN2.0 frames to a legacy socket */
@@ -307,6 +316,8 @@ static int raw_init(struct sock *sk)
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->join_filters     = 0;
+	ro->join_rx_count    = 0;
 	ro->uniq_skb         = NULL;
 	ro->uniq_tstamp      = ktime_set(0, 0);
 
@@ -596,6 +607,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case CAN_RAW_JOIN_FILTERS:
+		if (optlen != sizeof(ro->join_filters))
+			return -EINVAL;
+
+		if (copy_from_user(&ro->join_filters, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -660,6 +680,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->fd_frames;
 		break;
 
+	case CAN_RAW_JOIN_FILTERS:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->join_filters;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.1.4

