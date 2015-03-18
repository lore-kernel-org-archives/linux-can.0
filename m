From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 1/2] can: fix multiple delivery of a single CAN frame for overlapping CAN filters
Date: Wed, 18 Mar 2015 07:10:34 +0100
Message-ID: <1426659036-4628-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:33059 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbbCRGKq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Mar 2015 02:10:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The CAN_RAW socket can set multiple CAN identifier specific filters that lead
to multiple filters in the af_can.c filter processing. These filters are
indenpendent from each other which leads to logical OR'ed filters when applied.

This patch makes sure that every CAN frame which is filtered for a specific
socket is only delivered once to the user space. This is independent from the
number of matching CAN filters of this socket.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: move simple check to be processed first

 net/can/raw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/can/raw.c b/net/can/raw.c
index 00c13ef..0a6abf1 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -86,6 +86,8 @@ struct raw_sock {
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
+	struct sk_buff *uniq_skb;
+	ktime_t uniq_tstamp;
 };
 
 /*
@@ -123,6 +125,15 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->fd_frames && oskb->len != CAN_MTU)
 		return;
 
+	/* eliminate multiple filter matches for the same skb */
+	if (ro->uniq_skb == oskb &&
+	    ktime_equal(ro->uniq_tstamp, oskb->tstamp)){
+		return;
+	} else {
+		ro->uniq_skb = oskb;
+		ro->uniq_tstamp = oskb->tstamp;
+	}
+
 	/* clone the given skb to be able to enqueue it into the rcv queue */
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (!skb)
@@ -296,6 +307,8 @@ static int raw_init(struct sock *sk)
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->uniq_skb         = NULL;
+	ro->uniq_tstamp      = ktime_set(0, 0);
 
 	/* set notifier */
 	ro->notifier.notifier_call = raw_notifier;
-- 
2.1.4

