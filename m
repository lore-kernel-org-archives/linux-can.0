Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D634252AE;
	Thu, 16 Jul 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217414; cv=none; b=A/ZHXfiyTsYeFJe/zqbC1OHclDLK5Ji8U108+FBb1q4lUjnGGCSNGF1HKWm9T4JxeCJ3O9VQNM+c8IQDyp3X9RnTDySMspDx3QwmWvj/5hVimbsar2CY+YtqCYc2pWnMzjHb82/+vWMh93tZvSurKA6l8LtMu9042OYpXxGTZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217414; c=relaxed/simple;
	bh=copdcjHpcX4vWAJ5nIPPW32yQCVXR/nrLxUyGCQn5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJJTzODF+iMtjht30bweRIF0TKUouBsm/lVjy/Nxj73suRXwnV+HmnsZQQPfWyHxlzctwB2U3ckFnOMcjricG+gdTc6SWX/ZU2Exo0M+ULHhOJ34hqsyb+AT3MhOp1DP5rVzZCrBskdI3ImCvfMRmG9PnhLyPf4RRonDJMNgmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9F02520228B;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORk-0027p1-19;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB3D656C3DF;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/19] can: bcm: add locking when updating filter and timer values
Date: Thu, 16 Jul 2026 17:47:33 +0200
Message-ID: <20260716155528.809908-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup() when updating timer and filter content
while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
run concurrently on incoming CAN traffic.

Protect the timer (ival1/ival2/kt_ival1/kt_ival2/kt_lastmsg) and filter
(nframes/flags/frames/last_frames) updates in bcm_rx_setup() with a new
per-op bcm_rx_update_lock, taken with the matching scope in the RX
handlers. memcpy_from_msg() is staged into a temporary buffer before the
lock is taken, since it can sleep and must not run under a spinlock.

hrtimer_cancel() is always called without bcm_rx_update_lock held, since
bcm_rx_timeout_handler()/bcm_rx_thr_handler() take the same lock and a
running callback would otherwise deadlock against the canceller.

Also close a related race: bcm_rx_setup() cleared the RTR flag in the
stored reply frame's can_id as a separate, unprotected step after the
frame content was already installed, so a concurrent bcm_rx_handler()
could transmit a stale reply with CAN_RTR_FLAG still set. Fold that
normalization into the initial frame preparation instead (on the staged
buffer for updates, directly on op->frames pre-registration for new
ops), so the installed frame is always atomically self-consistent.

bcm_rx_handler()'s RX_RTR_FRAME check now takes a lock-protected
snapshot of op->flags before deciding whether to call bcm_can_tx(),
but does not hold the lock across that call.

Also take a lock-protected snapshot of the currframe in bcm_can_tx()
to avoid partly overwrites by content updates in bcm_tx_setup().
Finally check if a TX_RESET_MULTI_IDX/SETTIMER might have reset
op->currframe between the two locked sections in bcm_can_tx().

Omit calling hrtimer_forward() with zero interval in bcm_rx_thr_handler().
kt_ival2 may have been concurrently cleared by bcm_rx_setup() before it
cancels this timer, so check kt_ival2 inside the bcm_rx_update_lock.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-3-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 180 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 135 insertions(+), 45 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b612135b017d..1e5f8d65d351 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -129,6 +129,7 @@ struct bcm_op {
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
@@ -293,22 +294,28 @@ static int bcm_proc_show(struct seq_file *m, void *v)
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
-static void bcm_can_tx(struct bcm_op *op)
+static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct net_device *dev;
-	struct canfd_frame *cf;
+	struct canfd_frame cframe;
+	bool cyclic = !cf;
+	unsigned int idx = 0;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
-	/* read currframe under lock protection */
-	spin_lock_bh(&op->bcm_tx_lock);
-	cf = op->frames + op->cfsiz * op->currframe;
-	spin_unlock_bh(&op->bcm_tx_lock);
+	if (cyclic) {
+		/* read currframe under lock protection */
+		spin_lock_bh(&op->bcm_tx_lock);
+		idx = op->currframe;
+		memcpy(&cframe, op->frames + op->cfsiz * idx, op->cfsiz);
+		cf = &cframe;
+		spin_unlock_bh(&op->bcm_tx_lock);
+	}
 
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
@@ -341,14 +348,20 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!err)
 		op->frames_abs++;
 
-	op->currframe++;
+	/* only advance the cyclic sequence if nothing reset currframe while
+	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
+	 * frame's bookkeeping belongs to a sequence that no longer exists
+	 */
+	if (!cyclic || op->currframe == idx) {
+		op->currframe++;
 
-	/* reached last frame? */
-	if (op->currframe >= op->nframes)
-		op->currframe = 0;
+		/* reached last frame? */
+		if (op->currframe >= op->nframes)
+			op->currframe = 0;
 
-	if (op->count > 0)
-		op->count--;
+		if (op->count > 0)
+			op->count--;
+	}
 
 	spin_unlock_bh(&op->bcm_tx_lock);
 out:
@@ -461,7 +474,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -478,7 +491,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 		}
 
 	} else if (op->kt_ival2) {
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 	}
 
 	return bcm_tx_set_expiry(op, &op->timer) ?
@@ -622,6 +635,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	/* if user wants to be informed, when cyclic CAN-Messages come back */
 	if ((op->flags & RX_ANNOUNCE_RESUME) && op->last_frames) {
 		/* clear received CAN frames to indicate 'nothing received' */
@@ -638,6 +653,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
@@ -686,15 +703,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
 static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, thrtimer);
+	enum hrtimer_restart ret;
 
-	if (bcm_rx_thr_flush(op)) {
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
+	/* kt_ival2 may have been concurrently cleared by bcm_rx_setup()
+	 * before it cancels this timer - never forward with a zero
+	 * interval in that case.
+	 */
+	if (bcm_rx_thr_flush(op) && op->kt_ival2) {
 		hrtimer_forward_now(hrtimer, op->kt_ival2);
-		return HRTIMER_RESTART;
+		ret = HRTIMER_RESTART;
 	} else {
 		/* rearm throttle handling */
 		op->kt_lastmsg = 0;
-		return HRTIMER_NORESTART;
+		ret = HRTIMER_NORESTART;
 	}
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	return ret;
 }
 
 /*
@@ -704,8 +732,10 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
+	struct canfd_frame rtrframe;
 	unsigned int i;
 	unsigned char traffic_flags;
+	bool rtr_frame;
 
 	if (op->can_id != rxframe->can_id)
 		return;
@@ -729,9 +759,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* update statistics */
 	op->frames_abs++;
 
-	if (op->flags & RX_RTR_FRAME) {
+	/* snapshot the flag under lock: op->flags/op->frames may be updated
+	 * concurrently by bcm_rx_setup().
+	 */
+	spin_lock_bh(&op->bcm_rx_update_lock);
+	rtr_frame = op->flags & RX_RTR_FRAME;
+	if (rtr_frame)
+		memcpy(&rtrframe, op->frames, op->cfsiz);
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	if (rtr_frame) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
-		bcm_can_tx(op);
+		bcm_can_tx(op, &rtrframe);
 		return;
 	}
 
@@ -743,6 +782,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
@@ -778,6 +819,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 rx_starttimer:
 	bcm_rx_starttimer(op);
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
 }
 
 /*
@@ -1116,7 +1159,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	}
 
 	if (op->flags & TX_ANNOUNCE)
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1130,6 +1173,24 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	return err;
 }
 
+static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				   struct bcm_op *op, void *new_frames)
+{
+	/* funny feature in RX(!)_SETUP only for RTR-mode:
+	 * copy can_id into frame BUT without RTR-flag to
+	 * prevent a full-load-loopback-test ... ;-]
+	 * normalize this on the staged buffer, before it is
+	 * ever installed into op->frames.
+	 */
+	if (msg_head->flags & RX_RTR_FRAME) {
+		struct canfd_frame *frame0 = new_frames;
+
+		if ((msg_head->flags & TX_CP_CAN_ID) ||
+		    frame0->can_id == op->can_id)
+			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
+	}
+}
+
 /*
  * bcm_rx_setup - create or update a bcm rx op (for bcm_sendmsg)
  */
@@ -1164,6 +1225,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames = NULL;
+
 		/* update existing BCM operation */
 
 		/*
@@ -1175,19 +1238,48 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -E2BIG;
 
 		if (msg_head->nframes) {
-			/* update CAN frames content */
-			err = memcpy_from_msg(op->frames, msg,
-					      msg_head->nframes * op->cfsiz);
-			if (err < 0)
-				return err;
+			/* get new CAN frames content before locking */
+			new_frames = kmalloc(msg_head->nframes * op->cfsiz,
+					     GFP_KERNEL);
+			if (!new_frames)
+				return -ENOMEM;
 
-			/* clear last_frames to indicate 'nothing received' */
-			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
+			err = memcpy_from_msg(new_frames, msg,
+					      msg_head->nframes * op->cfsiz);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
+
+			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
 		}
 
+		spin_lock_bh(&op->bcm_rx_update_lock);
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
 
+		if (msg_head->nframes) {
+			/* update CAN frames content */
+			memcpy(op->frames, new_frames,
+			       msg_head->nframes * op->cfsiz);
+
+			/* clear last_frames to indicate 'nothing received' */
+			memset(op->last_frames, 0,
+			       msg_head->nframes * op->cfsiz);
+		}
+
+		if (msg_head->flags & SETTIMER) {
+			op->ival1 = msg_head->ival1;
+			op->ival2 = msg_head->ival2;
+			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			op->kt_lastmsg = 0;
+		}
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+
+		/* free temporary frames / kfree(NULL) is safe */
+		kfree(new_frames);
+
 		/* Only an update -> do not call can_rx_register() */
 		do_rx_register = 0;
 
@@ -1198,6 +1290,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
+		spin_lock_init(&op->bcm_rx_update_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
@@ -1239,6 +1332,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				kfree(op);
 				return err;
 			}
+
+			bcm_rx_setup_rtr_check(msg_head, op, op->frames);
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
@@ -1266,29 +1361,22 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check flags */
 
 	if (op->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = op->frames;
-
 		/* no timers in RTR-mode */
 		hrtimer_cancel(&op->thrtimer);
 		hrtimer_cancel(&op->timer);
-
-		/*
-		 * funny feature in RX(!)_SETUP only for RTR-mode:
-		 * copy can_id into frame BUT without RTR-flag to
-		 * prevent a full-load-loopback-test ... ;-]
-		 */
-		if ((op->flags & TX_CP_CAN_ID) ||
-		    (frame0->can_id == op->can_id))
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-
 	} else {
 		if (op->flags & SETTIMER) {
 
-			/* set timer value */
-			op->ival1 = msg_head->ival1;
-			op->ival2 = msg_head->ival2;
-			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
-			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			/* set timers (locked) for newly created op */
+			if (do_rx_register) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				op->ival1 = msg_head->ival1;
+				op->ival2 = msg_head->ival2;
+				op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+				op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+				op->kt_lastmsg = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
@@ -1298,9 +1386,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			 * In any case cancel the throttle timer, flush
 			 * potentially blocked msgs and reset throttle handling
 			 */
-			op->kt_lastmsg = 0;
 			hrtimer_cancel(&op->thrtimer);
+
+			spin_lock_bh(&op->bcm_rx_update_lock);
 			bcm_rx_thr_flush(op);
+			spin_unlock_bh(&op->bcm_rx_update_lock);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)
-- 
2.53.0

