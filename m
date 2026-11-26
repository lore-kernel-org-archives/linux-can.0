Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727162;
	b=IvnpdqYB5nf2HhGFAo8qm7il9pAix0GvDoDtQrzTDqlSvQOj82qISpChl4rZZqAkVDxq
	 GueVmSgASrPWokQBl3hX//FVBqBAhw2+PljFe760ihL1SBwXATo/scrYlBx24cz6dsoF7
	 4wF+iMmdATVm5DcgUbepIZsVz0MDzHZmtq0QsJ4Y9W43dfPjdVrgfW8lud+/zogBowYsG
	 gJ1xzOaBEQ1KbVg/cNZ8HfJnbqJfFSOEug10/evnz7AHOfFxTboyIdSLvE3FwgNIoP0EI
	 OBO3T79RCNaZ65QOEjpAi0tKzF2pdgIgNAQ6ShBuXzxnrrL1jamLfcrW/PoLBYsBomQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727162;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YQy5r03jftUMCAjIveGsQLrgcfNco9rk+5vCh6zsmjY=;
	b=WlKT69BbqA/wwSBI8SCVVtzgsv/QHdSfiGDmBGbJViDZaMle7ojs2GjbxurIrufix/AD
	 iWlDPPJPabVH9Fz2M1sQiWZQZan3r3XLyX1ZOdV+XIuhNj4EgIqLXgbxuj3h5Vn+VKVQq
	 GDdEYIJUAVaMkeatOxjIy4bfK4i4K0+AU7nQNQ4J3KZcvjQurodyGwL01aBxEDYXEBXX3
	 ACaqk63vIfXBete7tMNSlxvZQnd9RMTINos5krwR3RAEsES29IogebsKg3ZJL5Wizc+JU
	 BWlh2uck2gK+6D4rcJZA5PBTEuKgiBYhAi1f+a5RF2sxrDW7r5682Fc3Jn7uH+t7qHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=G2oarJOb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7KYFc0Pb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B6606A32C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50B6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=G2oarJOb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7KYFc0Pb
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RZvOFa9UvDN+g7LxeG2tZFwWWklBWGZSX4pBZDpwB7Lmn+y11SJpcszgBG0onUP+ia
    FeZ8RG8K4yZr8HiCfer27gmpSRoiIQY/kKu2RM5ebUZv7/7iPoOdtyAEFrNxZBX4C/H8
    dga9raYjkBJKN28nxgSVDT8IwHl9Rmds6fBqUTxaOo/aCW03mNAWEeKgQ81Q+Ms3nb0m
    JUPQnckm1OM4x6yKdL0VQ463MoLqoEFBSCMTigc/OeoTSFzJJOUXcanKe8JGTLQSMj5V
    peDY4Gxwxj/CI793jfz+0zN1GJ+ZXAVJQ7iedqebEAohpYSvN7G08lo9Hda8GHtbGfs/
    JRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=YQy5r03jftUMCAjIveGsQLrgcfNco9rk+5vCh6zsmjY=;
    b=Las/BGd3rN7tmoAlIiNpo+JLRlDMV+lJoKwamtrtSWQJHZR6m9Jk9F6sNXGHuRhop7
    tUPE789VYwEwEMxND4mgg+tC73xaaC8UqWdxZZUGk7urpq1KuqyHP+iUnbJJcf3rJc4S
    Jk3Vn4iYZqI+nKDlSXYsoRUeyfIgn6je+8lqlJ4wY/2v+2kaFAoofn9OLnbhYHnf7b2H
    uISW0lBwlIJGlTDYNUygEM64DNUKoS71zPB6iPXr4PKsafWIZ6mel7DBUwm6yvoY/gXR
    5aVKHaETulxlY2rbj6SGCVfCzyTUbTVRENAFmKQpFtP9oODE/4dVGv2XktOYZaa4Lnsk
    G4lQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=YQy5r03jftUMCAjIveGsQLrgcfNco9rk+5vCh6zsmjY=;
    b=G2oarJObfZCttUYL/2I7mzgi9N4oDq39kDiMPuMc7ZYZ1SXZc7etem4V1jzWaQmVCq
    bOramfHEWgskfm8cy1y9B5VfL4Px9F84HVDumKEKUc4c5CnWCHpA1rd9+4o0iZBzVP3x
    VGaptzaRtZcsFH7OKDa7ETHmZUaQrxjBJUIiIhUTSpGMNsnb7/X+sHa42RMfHFrr3Xar
    iBM0y/K7ymkxU4nUGODArgOlTTpa70HxmXXOLdUYp2Vx8r32FZ3SD12dauOY+fz6miGm
    swh1cYmMAloR/PinotuHlaim6EB5oHWbpXLiKQzBl5PS7JDDV0aB40kK/d2dOxpGcY7i
    y6sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=YQy5r03jftUMCAjIveGsQLrgcfNco9rk+5vCh6zsmjY=;
    b=7KYFc0PbE2USnwE4VxBj4e0Mitilpwe+9UAQ50vVNnWVykp5yzoN4W+RwDdYmMJ5+3
    qZoYsIl5RprukBiFZhAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:58 +0100
Subject: [PATCH can-next 16/22] can: isotp: rename rx_lock as it has become
 state machine lock
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-16-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=9610;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=WaoP5CI44kpnI2WVwO7VCCDv8ioHrpfQRJCqJvjUubw=;
 b=99ZwvgqjPin9M4FxHa8s1znuTczx8s8tda55yH0ld0g9r/n3rIf1IqBlo1UpkyzUp+rzUheJL
 0fTQ0nIT7dOBC0kyw7TUYxNjIhhJyE7mAkAzhx8v9qVTXHLNPgGybs1
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

rx_lock has been used to lock some receive path functionalities.
With the latest changes the semantic has been extended as a full
state machine locking primitive so give it a proper name sm_lock.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index fc03dedb0c86..8e8f838160af 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -180,11 +180,11 @@ struct isotp_sock {
 	u32 tx_gen; /* transfer generation, increased per new tx transfer */
 	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
-	spinlock_t rx_lock; /* protect single thread state machine */
+	spinlock_t sm_lock; /* protect single thread state machine */
 	struct mutex conf_lock; /* protects bind and sockopts */
 };
 
 static LIST_HEAD(isotp_notifier_list);
 static DEFINE_SPINLOCK(isotp_notifier_lock);
@@ -802,11 +802,11 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 
 	/* Make sure the state changes and data structures stay consistent at
 	 * CAN frame reception time. This locking is not needed in real world
 	 * use cases but the inconsistency can be triggered with syzkaller.
 	 */
-	spin_lock(&so->rx_lock);
+	spin_lock(&so->sm_lock);
 
 	if (so->opt.flags & CAN_ISOTP_HALF_DUPLEX) {
 		/* check rx/tx path half duplex expectations */
 		if ((READ_ONCE(so->tx.state) != ISOTP_IDLE &&
 		     n_pci_type != N_PCI_FC) ||
@@ -861,11 +861,11 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 		isotp_rcv_cf(sk, cf, ae, skb);
 		break;
 	}
 
 out_unlock:
-	spin_unlock(&so->rx_lock);
+	spin_unlock(&so->sm_lock);
 }
 
 static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 				 int ae, int off)
 {
@@ -1013,14 +1013,14 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 		return;
 
 	if (WARN_ON_ONCE(!csx))
 		return;
 
-	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
+	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->sm_lock
 	 * (no isotp_rcv() caller here), so take it ourselves
 	 */
-	spin_lock(&so->rx_lock);
+	spin_lock(&so->sm_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
 	if (READ_ONCE(so->cfecho) != csx->can_skb_uid)
 		goto out_unlock;
 
@@ -1028,11 +1028,11 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	WRITE_ONCE(so->cfecho, 0);
 
-	/* claiming a transfer also takes so->rx_lock, so a plain recheck
+	/* claiming a transfer also takes so->sm_lock, so a plain recheck
 	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
 	 * a new claim while we're still in here
 	 */
 	if (READ_ONCE(so->tx.state) != ISOTP_SENDING)
 		goto out_unlock;
@@ -1066,17 +1066,17 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 
 	/* start timer to send next consecutive frame with correct delay */
 	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
 
 out_unlock:
-	spin_unlock(&so->rx_lock);
+	spin_unlock(&so->sm_lock);
 }
 
 /* isotp_tx_timeout: we did not get any flow control or echo frame in time
  *
  * Shared by so->txtimer's and so->echotimer's callbacks. Both timers get
- * cancelled under so->rx_lock elsewhere, so this must stay lock-free.
+ * cancelled under so->sm_lock elsewhere, so this must stay lock-free.
  *
  * tx.state is acquired before tx_gen. Common sequence in isotp_tx_gen_done().
  * cmpxchg() only orders itself, not the two preceding loads.
  */
 static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
@@ -1161,19 +1161,19 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int err;
 
 	if (!READ_ONCE(so->bound) || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	/* claim the socket under so->rx_lock: this serializes the claim
+	/* claim the socket under so->sm_lock: this serializes the claim
 	 * with the RX path and with sendmsg()'s own error paths below, so
 	 * none of them can ever see a transfer mid-claim
 	 */
 	for (;;) {
-		spin_lock_bh(&so->rx_lock);
+		spin_lock_bh(&so->sm_lock);
 		if (READ_ONCE(so->tx.state) == ISOTP_IDLE)
 			break;
-		spin_unlock_bh(&so->rx_lock);
+		spin_unlock_bh(&so->sm_lock);
 
 		/* we do not support multiple buffers - for now */
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
 
@@ -1198,11 +1198,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	isotp_set_tx_result(so, my_gen, ECOMM); /* prevent stale slot matching */
 	WRITE_ONCE(so->tx_gen, my_gen);
 	smp_wmb(); /* see smp_load_acquire() in isotp_tx_[timeout|gen_done] */
 	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
 	WRITE_ONCE(so->cfecho, 0);
-	spin_unlock_bh(&so->rx_lock);
+	spin_unlock_bh(&so->sm_lock);
 
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile => recheck
 	 */
 	if (!READ_ONCE(so->bound)) {
@@ -1335,26 +1335,26 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
 			WRITE_ONCE(so->cfecho, 0);
 		}
 	}
 
-	spin_lock_bh(&so->rx_lock);
+	spin_lock_bh(&so->sm_lock);
 	if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN) {
 		/* isotp_release() has since taken over and already drained
 		 * our timers - don't send into a socket that's going away
 		 */
-		spin_unlock_bh(&so->rx_lock);
+		spin_unlock_bh(&so->sm_lock);
 		kfree_skb(skb);
 		dev_put(dev);
 		wake_up_interruptible(&so->wait);
 		return -EADDRNOTAVAIL;
 	}
 	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
 	WRITE_ONCE(so->tx.state, new_state);
 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, so->frame_txtime),
 		      HRTIMER_MODE_REL_SOFT);
-	spin_unlock_bh(&so->rx_lock);
+	spin_unlock_bh(&so->sm_lock);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
 	skb->dev = dev;
@@ -1363,18 +1363,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	dev_put(dev);
 	if (err) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
-		spin_lock_bh(&so->rx_lock);
+		spin_lock_bh(&so->sm_lock);
 
 		/* new transfer already claimed by a concurrent completion,
 		 * timeout or sendmsg() while we were stuck in can_send()?
 		 */
 		if (READ_ONCE(so->tx_gen) != my_gen) {
 			/* don't touch timers and state of the new transfer */
-			spin_unlock_bh(&so->rx_lock);
+			spin_unlock_bh(&so->sm_lock);
 			return err;
 		}
 
 		/* no transmission -> no timeout monitoring */
 		hrtimer_cancel(tx_hrt);
@@ -1413,34 +1413,34 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	return size;
 
 err_out_drop:
 	/* claimed but nothing sent yet - no timer to cancel */
-	spin_lock_bh(&so->rx_lock);
+	spin_lock_bh(&so->sm_lock);
 	goto err_out_drop_locked;
 err_event_drop:
 	/* interrupted or shut down while waiting on our own transfer */
-	spin_lock_bh(&so->rx_lock);
+	spin_lock_bh(&so->sm_lock);
 
 	/* new transfer already started by concurrent sendmsg()? */
 	if (READ_ONCE(so->tx_gen) != my_gen) {
 		/* don't touch timers and states of the new transfer */
-		spin_unlock_bh(&so->rx_lock);
+		spin_unlock_bh(&so->sm_lock);
 		return err;
 	}
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
 err_out_drop_locked:
-	/* release the claim; so->rx_lock still held from above */
+	/* release the claim; so->sm_lock still held from above */
 	WRITE_ONCE(so->cfecho, 0);
 
 	/* only claim to IDLE if isotp_release() has not taken over */
 	if (READ_ONCE(so->tx.state) != ISOTP_SHUTDOWN)
 		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
-	spin_unlock_bh(&so->rx_lock);
+	spin_unlock_bh(&so->sm_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 
@@ -1506,17 +1506,17 @@ static int isotp_release(struct socket *sock)
 	while (READ_ONCE(so->tx.state) != ISOTP_IDLE &&
 	       wait_event_interruptible(so->wait,
 					READ_ONCE(so->tx.state) == ISOTP_IDLE) == 0)
 		;
 
-	/* claim the socket under so->rx_lock like sendmsg() does, so its
+	/* claim the socket under so->sm_lock like sendmsg() does, so its
 	 * claim can't race the forced ISOTP_SHUTDOWN below; force it
 	 * unconditionally, even when a signal cut the wait above short
 	 */
-	spin_lock_bh(&so->rx_lock);
+	spin_lock_bh(&so->sm_lock);
 	WRITE_ONCE(so->tx.state, ISOTP_SHUTDOWN);
-	spin_unlock_bh(&so->rx_lock);
+	spin_unlock_bh(&so->sm_lock);
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
 	wake_up_interruptible(&so->wait);
 
@@ -2105,11 +2105,11 @@ static int isotp_init(struct sock *sk)
 		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler,
 		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	init_waitqueue_head(&so->wait);
-	spin_lock_init(&so->rx_lock);
+	spin_lock_init(&so->sm_lock);
 
 	spin_lock(&isotp_notifier_lock);
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 

-- 
2.53.0

