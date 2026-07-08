Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C883F12D6
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524083; cv=none; b=LYvLyucgKkx6Ru/iAe92GkCiqy1xONnIrS/TXOXAsP4usi625+iEFWP80r1CKC239iqrEFSkIXB0rGIZUhrKWJKZfF32HGO6MfwK+VuWSz5L1jUVR80PKJQEBMJgTwdtMHSppyQZBCaZ2FHi1fPe8d2S93qIuDQUXOsJ4FRyY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524083; c=relaxed/simple;
	bh=MuYUid1xVvQoJLvSFmjm5oh3fievMVOo3NepEzJmtZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsjesH45fXzlfjpvkUfvq8CA3vi3RCjDfOL25OG8EsNuT0GFyfQ/Kvp7xf5vxz7POg417EOncUj0TkxM/bSGnba75+fRNm9wJ5/rnJssxVAaQ8cZhxir8Rztys3eqC9DTob3aqZL2L/dCD8GlQXiEwmpa9QAxW6/4zw60/mYdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHc7AbvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHc7AbvC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 792FAC2BCF7;
	Wed,  8 Jul 2026 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783524082;
	bh=MuYUid1xVvQoJLvSFmjm5oh3fievMVOo3NepEzJmtZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vHc7AbvC2hcWlvIyze2X3pVO6Yn4UjM53VKP++SjY6CEG2VveHQjBQFSXn4uT+EKF
	 fZV4KTJQ/HQeve+4CglLFgdarerLkJsbZ+XpRuo1q/gOKjeJYcZcpBVXfInM9oookp
	 TtXjyLfdsKZEJKJI/R/V2dQ80xnzPQeciG3bXeuCkWiHAG+/7C9qlkZxhJYSz+GVrt
	 Kd1Wwa6jEF/lL2q6iSB5yjqTAxbBLHVBuSVxauYeS/hGrh5gTle75ZklBW6d9VeMXj
	 v85mle9DtGzbiVfq6yTZ63HynRZspsWgPllmt6lP6be2rl3F9lYeDMRlEYw9VjPTCJ
	 vXQuT6CFW2N2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A3C43602;
	Wed,  8 Jul 2026 15:21:22 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 08 Jul 2026 17:21:18 +0200
Subject: [PATCH v7 08/10] can: bcm: add missing device refcount for CAN
 filter removal
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bcm_fixes-v7-8-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783524080; l=4807;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=e+4060p0TLpVYJANRm8fMWWwjGdEnSDV8K40Qsp0eoQ=;
 b=MoCX17G655iNxJN3SPIphN7cQtMp9caDaqUy2NOvWv/A6qbWf/X+M9YE+fDZKDMoQC7EOxJFQ
 nDMBLnGGZiFCZkKuAHJosYAvVbC3I+FVKqRx5KSAhmTtOhKO4v9j8WN
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

From: Oliver Hartkopp <socketcan@hartkopp.net>

sashiko-bot remarked a problem with a concurrent device unregistration
in isotp.c which also is present in the bcm.c code. A former fix for raw.c
commit c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
introduced a netdevice_tracker which solves the issue for bcm.c too.

bcm_release(), bcm_delete_rx_op() and bcm_notifier() relied on
dev_get_by_index(ifindex) to re-find the device for an rx_op before
unregistering its filter. If a concurrent NETDEV_UNREGISTER has already
unlisted the device from the ifindex table, that lookup fails and
can_rx_unregister() is silently skipped, leaving a stale CAN filter
pointing at the soon-to-be-freed bcm_op/socket.

Hold a netdev_hold()/netdev_put() tracked reference on op->rx_reg_dev
from the moment the rx filter is registered in bcm_rx_setup() until it
is unregistered in bcm_rx_unreg(), and use that reference directly in
bcm_release() and bcm_delete_rx_op() instead of re-looking the device
up by ifindex.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartkopp.net
Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 300f1f88c4d2..4bdca72f9327 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -126,10 +126,11 @@ struct bcm_op {
 	void *last_frames;
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	netdevice_tracker rx_reg_dev_tracker;
 	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
@@ -904,10 +905,11 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 		can_rx_unregister(dev_net(dev), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		netdev_put(dev, &op->rx_reg_dev_tracker);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
 }
 
@@ -934,21 +936,18 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 			if (op->ifindex) {
 				/*
 				 * Only remove subscriptions that had not
 				 * been removed due to NETDEV_UNREGISTER
 				 * in bcm_notifier()
+				 *
+				 * op->rx_reg_dev is a tracked reference taken
+				 * when the subscription was registered, so it
+				 * stays valid here even if a concurrent
+				 * NETDEV_UNREGISTER already unlisted the dev.
 				 */
-				if (op->rx_reg_dev) {
-					struct net_device *dev;
-
-					dev = dev_get_by_index(sock_net(op->sk),
-							       op->ifindex);
-					if (dev) {
-						bcm_rx_unreg(dev, op);
-						dev_put(dev);
-					}
-				}
+				if (op->rx_reg_dev)
+					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
 						  op->can_id,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
@@ -1453,11 +1452,21 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
-				op->rx_reg_dev = dev;
+				/* keep a tracked reference so that a later
+				 * unregister can safely reach the device even
+				 * if a concurrent NETDEV_UNREGISTER has
+				 * already unlisted it by ifindex
+				 */
+				if (!err) {
+					op->rx_reg_dev = dev;
+					netdev_hold(dev,
+						    &op->rx_reg_dev_tracker,
+						    GFP_KERNEL);
+				}
 				dev_put(dev);
 			} else {
 				/* the requested device is gone - do not
 				 * silently succeed without registering
 				 */
@@ -1830,20 +1839,18 @@ static int bcm_release(struct socket *sock)
 		if (op->ifindex) {
 			/*
 			 * Only remove subscriptions that had not
 			 * been removed due to NETDEV_UNREGISTER
 			 * in bcm_notifier()
+			 *
+			 * op->rx_reg_dev is a tracked reference taken
+			 * when the subscription was registered, so it
+			 * stays valid here even if a concurrent
+			 * NETDEV_UNREGISTER already unlisted the device.
 			 */
-			if (op->rx_reg_dev) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(net, op->ifindex);
-				if (dev) {
-					bcm_rx_unreg(dev, op);
-					dev_put(dev);
-				}
-			}
+			if (op->rx_reg_dev)
+				bcm_rx_unreg(op->rx_reg_dev, op);
 		} else
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
 

-- 
2.53.0


