Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5E382F27
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563306; cv=pass; b=JElvCtZWMpGBDwbi1aDWLFTeLYWsoFsHjkQXz6Bo/D1UT7e0xq2ZV/fYqZ46fLNPWDyM/2XqD05em3ZOEfBMfaiEnLtmQxUARak1lNttrZaQs9QGWBsgzu9pbhA7SwdKBhykiAknJiBGa7phKR5M4Kl/eMz4xLgKt+gSMbwgWlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563306; c=relaxed/simple;
	bh=F39vAohy4oftq9xv5/sqTYATmNrSUOf7yHaKcK60J2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdNjghHxCcdSGZN2tfIQeBA/3h0ey7kxeSJP5/scn9ai/wW5894gD2W4UwSsZEecHrSgEv28sR5QO+k0ms4PAa9IBIs9IQb9kZJEauNWUQG1h8s4zgC91ItlY/Wmg+ERb+pYyvsPgCFK33HwpjnVBTRBFWDSmul44tvoOeRMj8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LkBD2lEl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sqspmCAD; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LkBD2lEl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sqspmCAD"
ARC-Seal: i=1; a=rsa-sha256; t=1784563285; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HusWRJTcynp1bg1LOIgSsYV1ZyUVfKBgk1PyiVd4hJJeMWcxWYfuUHJLWKiaCbxP70
    u/n46k5vpDDae0s5RpSKPf2bmQHqfjniOR7TqGQ9ErBMXcj+CmGaCdzFr1QB8xUNxiM2
    +gp2Yabpr+WHebVchm0500fs7f+Q8CfrdZKtW00doq1Goth57+nGouy4P4OxmgOIw9pL
    6mImD6VULBgNWfh3KBUzq9AtSWFvjNN1SieClRv8iKodufWcOdqpERm776lpj2yTJhvH
    a2R1OeI9qkjgRGj8G9mbTBQVmdWVu3agX0o7BDnOGvushJZ8I2bw4XUhD/hKNHu1hiK5
    8h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784563285;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=XXk2+Iq9pXV7SJlWJC0xxEhQcROsy8xRQIYy+2FYdds=;
    b=icQexdrodMSi9BF1Pv3nOooNoWTcPnvTtIzJ4MwUo/7k3mqsC4C8StwGXsKW23/+Gs
    shZPVmXh1YxypN4W63p/xteNtQ3C3mJ8xpr9Ijx0RGETk4oWRXd86F5vqLr4F+bEBcr+
    1u8j8k2WyfAquwtaCmUvngWHSvnNAAHzNhusSqpOTSocEgKTYDvQC5UWdiJvT1vhlj9+
    jkkIm71PoptgG+jVSyP1RWyjAksSdk/kqnVZtGs6dI8M1ajb31DMSUqvrghW3XhOhdeD
    uQRGX+w7HTlPC/ofPzquTj+9KWeYqK2UAqCyAOo524irV1oCbeoADa59/HNsmxNwHiY1
    6PuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784563285;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=XXk2+Iq9pXV7SJlWJC0xxEhQcROsy8xRQIYy+2FYdds=;
    b=LkBD2lElXvcPz+zyXfEWDSUI+fLokPdzmr2FJxlTF/pUGSGCMv2YdXVf0Hm84DMs2y
    xqYrowNc8aNFKpSkqfAWcPs0cVqEDohh6t+kU70SYbPeXD5L7bfvD6B6F9/s37+oCOjv
    i3iIBITEWeNQyIeaYkUV4RL7OQ07N1EdhaKD0snH3YIKHwXutYfhg+RYiu41PidzmBfh
    0o5mYH28QwtRmGXMw+4wbiHAPKL+O7Aom0/Ioc3/BefuG0ReJiXCzxrpObegn6h6WxJI
    XY3PtIk2HH6ZpTLNfck8ZCdrvchSGxXHk9esik0uHINyqHztwzGUag7rleJKyNZQvDSk
    IUQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784563285;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=XXk2+Iq9pXV7SJlWJC0xxEhQcROsy8xRQIYy+2FYdds=;
    b=sqspmCADOshU1jldBQW88A26+XVd99lQnTYJJkQ1Yp1Ym1DPgEig3KXFURSR47XCBj
    VjurfwbBt4uNYCHeVXAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281926KG1P2Wt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 20 Jul 2026 18:01:25 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3] can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
Date: Mon, 20 Jul 2026 18:01:15 +0200
Message-ID: <20260720160115.130306-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This patch is a follow-up to commit cf070fe33bfb ("can: isotp: serialize
TX state transitions under so->rx_lock") which addresses following
sashiko-bot findings:

- isotp_sendmsg(): drain so->txfrtimer first so a stale callback can't
  re-arm echotimer after the claim

- isotp_release(): wake so->wait after forcing ISOTP_SHUTDOWN so a
  sleeping sendmsg() claim isn't stranded

- isotp_sendmsg(): have both wait_event_interruptible() calls in
  isotp_sendmsg() also wake on ISOTP_SHUTDOWN and do not return claim to
  IDLE to avoid corrupting a concurrent isotp_release() process.

- isotp_sendmsg(): handle potential claim of a new transfer when
  the wait_event_interruptible() call returns in CAN_ISOTP_WAIT_TX_DONE
  mode. Don't touch timers and states of the new transfer if a new thread
  incremented so->tx_gen before getting the lock at err_event_drop.

- isotp_sendmsg(): order the so->tx_gen increment before so->tx.state so
  isotp_tx_timeout() can't stamp ECOMM on a fresh transfer via a stale,
  pre-incrementation generation read on weakly ordered CPUs - the race
  that can instead suppress a valid ECOMM for the transfer that actually
  timed out is intentionally left for a later change.

Also align the remaining lock-free so->tx.state/rx.state/cfecho accesses
and use skb->hash as unique loopback echo frame indicator.

Fixes: cf070fe33bfb ("can: isotp: serialize TX state transitions under so->rx_lock")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 186 +++++++++++++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 73 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 54becaf6898f..3e5800f44057 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -197,20 +197,20 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     rxtimer);
 	struct sock *sk = &so->sk;
 
-	if (so->rx.state == ISOTP_WAIT_DATA) {
+	if (READ_ONCE(so->rx.state) == ISOTP_WAIT_DATA) {
 		/* we did not get new data frames in time */
 
 		/* report 'connection timed out' */
 		sk->sk_err = ETIMEDOUT;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 	}
 
 	return HRTIMER_NORESTART;
 }
 
@@ -371,40 +371,38 @@ static void isotp_send_cframe(struct isotp_sock *so);
 
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
 
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
 	/* isotp_tx_timeout() may have given up on this job while
-	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
-	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
-	 * so a plain recheck is enough here.
+	 * hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 1;
 
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
-		so->tx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		return 1;
 	}
 
 	/* get static/dynamic communication params from first/every FC frame */
-	if (so->tx.state == ISOTP_WAIT_FIRST_FC ||
+	if (READ_ONCE(so->tx.state) == ISOTP_WAIT_FIRST_FC ||
 	    so->opt.flags & CAN_ISOTP_DYN_FC_PARMS) {
 		so->txfc.bs = cf->data[ae + 1];
 		so->txfc.stmin = cf->data[ae + 2];
 
 		/* fix wrong STmin values according spec */
@@ -424,17 +422,17 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 						  so->txfc.stmin * 1000000);
 		else
 			so->tx_gap = ktime_add_ns(so->tx_gap,
 						  (so->txfc.stmin - 0xF0)
 						  * 100000);
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 	}
 
 	switch (cf->data[ae] & 0x0F) {
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
-		so->tx.state = ISOTP_SENDING;
+		WRITE_ONCE(so->tx.state, ISOTP_SENDING);
 		/* send CF frame and enable echo timeout handling */
 		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
 		break;
@@ -452,11 +450,11 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 			sk_error_report(sk);
 		fallthrough;
 
 	default:
 		/* stop this tx job */
-		so->tx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 	}
 	return 0;
 }
 
@@ -465,11 +463,11 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	if (!len || len > cf->len - pcilen)
 		return 1;
 
 	if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
@@ -499,11 +497,11 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	int i;
 	int off;
 	int ff_pci_sz;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	/* get the used sender LL_DL from the (first) CAN frame data length */
 	so->rx.ll_dl = padlen(cf->len);
 
 	/* the first frame has to use the entire frame up to LL_DL length */
@@ -553,11 +551,11 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	for (i = ae + ff_pci_sz; i < so->rx.ll_dl; i++)
 		so->rx.buf[so->rx.idx++] = cf->data[i];
 
 	/* initial setup for this pdu reception */
 	so->rx.sn = 1;
-	so->rx.state = ISOTP_WAIT_DATA;
+	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
 		return 0;
 
@@ -571,11 +569,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 	int i;
 
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;
 
 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
 	if (so->opt.flags & CAN_ISOTP_FORCE_RXSTMIN) {
 		if (ktime_to_ns(ktime_sub(skb->tstamp, so->lastrxcf_tstamp)) <
@@ -586,15 +584,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	}
 
 	hrtimer_cancel(&so->rxtimer);
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
-	 * while hrtimer_cancel() above waited for it to finish, already
-	 * reporting ETIMEDOUT and resetting the reception; don't process
-	 * this CF into a reassembly that has already been given up on.
+	 * while hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 1;
 
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
 		return 1;
@@ -611,11 +607,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		sk->sk_err = EILSEQ;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 		return 1;
 	}
 	so->rx.sn++;
 	so->rx.sn %= 16;
 
@@ -625,11 +621,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 			break;
 	}
 
 	if (so->rx.idx >= so->rx.len) {
 		/* we are done */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 		if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 		    check_pad(so, cf, i + 1, so->opt.rxpad_content)) {
 			/* malformed PDU - report 'not a data message' */
 			sk->sk_err = EBADMSG;
@@ -696,12 +692,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 	 */
 	spin_lock(&so->rx_lock);
 
 	if (so->opt.flags & CAN_ISOTP_HALF_DUPLEX) {
 		/* check rx/tx path half duplex expectations */
-		if ((so->tx.state != ISOTP_IDLE && n_pci_type != N_PCI_FC) ||
-		    (so->rx.state != ISOTP_IDLE && n_pci_type == N_PCI_FC))
+		if ((READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+		     n_pci_type != N_PCI_FC) ||
+		    (READ_ONCE(so->rx.state) != ISOTP_IDLE &&
+		     n_pci_type == N_PCI_FC))
 			goto out_unlock;
 	}
 
 	switch (n_pci_type) {
 	case N_PCI_FC:
@@ -792,10 +790,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int can_send_ret;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	u32 old_cfecho;
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
 		return;
 
@@ -812,10 +811,13 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	csx->can_iif = dev->ifindex;
 
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
+
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
 	isotp_fill_dataframe(cf, so, ae, 0);
@@ -828,16 +830,19 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	cf->flags = so->ll.tx_flags;
 
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 
-	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+	/* zero'ed by init/isotp_rcv_echo(); reached lock-free via
+	 * isotp_txfr_timer_handler() too, so use READ_ONCE()/WRITE_ONCE()
+	 */
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	so->cfecho = *(u32 *)cf->data;
+	WRITE_ONCE(so->cfecho, skb->hash);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
 	if (can_send_ret) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
@@ -885,11 +890,10 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 
 static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
-	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk)
 		return;
 
@@ -897,36 +901,36 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	 * (no isotp_rcv() caller here), so take it ourselves
 	 */
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (so->cfecho != *(u32 *)cf->data)
+	if (READ_ONCE(so->cfecho) != skb->hash)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* claiming a transfer also takes so->rx_lock, so a plain recheck
 	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
 	 * a new claim while we're still in here
 	 */
-	if (so->tx.state != ISOTP_SENDING)
+	if (READ_ONCE(so->tx.state) != ISOTP_SENDING)
 		goto out_unlock;
 
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
-		so->tx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
 		/* stop and wait for FC with timeout */
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		goto out_unlock;
 	}
 
@@ -944,14 +948,19 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 
 out_unlock:
 	spin_unlock(&so->rx_lock);
 }
 
-/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
- * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
- * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
- * a new transfer with an error from the one that just timed out.
+/* isotp_tx_timeout: we did not get any flow control or echo frame in time
+ *
+ * Shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free.
+ * Use so->tx_gen to avoid tainting a new transfer with an error from the
+ * one that just timed out.
+ *
+ * so->tx_gen is incremented before so->tx.state in isotp_sendmsg(), paired
+ * with smp_wmb() - cmpxchg()'s full ordering makes the re-read below safe.
  */
 static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
 	struct sock *sk = &so->sk;
 	u32 gen = READ_ONCE(so->tx_gen);
@@ -963,14 +972,12 @@ static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 
 	/* only claim the timeout if the state is still unchanged */
 	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
-	/* we did not get any flow control or echo frame in time */
-
+	/* detected timeout: report 'communication error on send' */
 	if (READ_ONCE(so->tx_gen) == gen) {
-		/* report 'communication error on send' */
 		sk->sk_err = ECOMM;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
@@ -1005,11 +1012,11 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 	/* start echo timeout handling and cover below protocol error */
 	hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
-	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+	if (READ_ONCE(so->tx.state) == ISOTP_SENDING && !READ_ONCE(so->cfecho))
 		isotp_send_cframe(so);
 
 	return HRTIMER_NORESTART;
 }
 
@@ -1024,14 +1031,16 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	struct hrtimer *tx_hrt = &so->echotimer;
 	u32 new_state = ISOTP_SENDING;
+	u32 my_gen;
+	u32 old_cfecho;
 	int off;
 	int err;
 
-	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
+	if (!so->bound || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	/* claim the socket under so->rx_lock: this serializes the claim
 	 * with the RX path and with sendmsg()'s own error paths below, so
 	 * none of them can ever see a transfer mid-claim
@@ -1044,33 +1053,36 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 		/* we do not support multiple buffers - for now */
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
 
-		if (so->tx.state == ISOTP_SHUTDOWN)
+		if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait,
-					       so->tx.state == ISOTP_IDLE);
+					       READ_ONCE(so->tx.state) == ISOTP_IDLE ||
+					       READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN);
 		if (err)
 			return err;
 	}
 
-	/* new transfer: bump so->tx_gen and drain the old one's timers,
-	 * still under the so->rx_lock we just claimed the socket with
-	 */
-	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
-	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
+	/* txfrtimer's callback re-arms echotimer lock-free: drain it first */
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
-	hrtimer_cancel(&so->txfrtimer);
-	so->cfecho = 0;
+
+	/* new transfer: increment so->tx_gen and set tx.state after barrier */
+	my_gen = READ_ONCE(so->tx_gen) + 1;
+	WRITE_ONCE(so->tx_gen, my_gen);
+	smp_wmb(); /* pairs with the cmpxchg() in isotp_tx_timeout() */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->cfecho, 0);
 	spin_unlock_bh(&so->rx_lock);
 
 	/* so->bound is only checked once above - a wakeup may have
-	 * unbound/rebound the socket meanwhile, so re-validate it
+	 * unbound/rebound the socket meanwhile => recheck
 	 */
 	if (!so->bound) {
 		err = -EADDRNOTAVAIL;
 		goto err_out_drop;
 	}
@@ -1125,19 +1137,23 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	csx->can_iif = dev->ifindex;
 
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
+
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", old_cfecho);
 
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
 		 *
@@ -1161,11 +1177,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[SF_PCI_SZ4 + ae] = size;
 		else
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		so->cfecho = *(u32 *)cf->data;
+		WRITE_ONCE(so->cfecho, skb->hash);
 	} else {
 		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
@@ -1178,37 +1194,37 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 			/* disable wait for FCs due to activated block size */
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			so->cfecho = *(u32 *)cf->data;
+			WRITE_ONCE(so->cfecho, skb->hash);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
 			hrtimer_sec = ISOTP_FC_TIMEOUT;
 			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
-			so->cfecho = 0;
+			WRITE_ONCE(so->cfecho, 0);
 		}
 	}
 
 	spin_lock_bh(&so->rx_lock);
-	if (so->tx.state == ISOTP_SHUTDOWN) {
+	if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN) {
 		/* isotp_release() has since taken over and already drained
 		 * our timers - don't send into a socket that's going away
 		 */
 		spin_unlock_bh(&so->rx_lock);
 		kfree_skb(skb);
 		dev_put(dev);
 		wake_up_interruptible(&so->wait);
 		return -EADDRNOTAVAIL;
 	}
 	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
-	so->tx.state = new_state;
+	WRITE_ONCE(so->tx.state, new_state);
 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
 	spin_unlock_bh(&so->rx_lock);
 
 	/* send the first or only CAN frame */
@@ -1228,14 +1244,22 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait,
+					       READ_ONCE(so->tx.state) == ISOTP_IDLE ||
+					       READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN);
 		if (err)
 			goto err_event_drop;
 
+		if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN) {
+			/* isotp_release() has taken over the claim */
+			err = -EADDRNOTAVAIL;
+			goto err_event_drop;
+		}
+
 		err = sock_error(sk);
 		if (err)
 			return err;
 	}
 
@@ -1244,19 +1268,30 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 err_out_drop:
 	/* claimed but nothing sent yet - no timer to cancel */
 	spin_lock_bh(&so->rx_lock);
 	goto err_out_drop_locked;
 err_event_drop:
-	/* interrupted waiting on our own transfer - drain its timers */
+	/* interrupted or shut down while waiting on our own transfer */
 	spin_lock_bh(&so->rx_lock);
+
+	/* new transfer already started by concurrent sendmsg()? */
+	if (READ_ONCE(so->tx_gen) != my_gen) {
+		/* don't touch timers and states of the new transfer */
+		spin_unlock_bh(&so->rx_lock);
+		return err;
+	}
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
 err_out_drop_locked:
 	/* release the claim; so->rx_lock still held from above */
-	so->cfecho = 0;
-	so->tx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->cfecho, 0);
+
+	/* only claim to IDLE if isotp_release() has not taken over */
+	if (READ_ONCE(so->tx.state) != ISOTP_SHUTDOWN)
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
 }
@@ -1318,22 +1353,26 @@ static int isotp_release(struct socket *sock)
 	net = sock_net(sk);
 
 	/* best-effort: wait for a running pdu to finish, but don't block on
 	 * it forever - give up after the first signal
 	 */
-	while (so->tx.state != ISOTP_IDLE &&
-	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
+	while (READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait,
+					READ_ONCE(so->tx.state) == ISOTP_IDLE) == 0)
 		;
 
 	/* claim the socket under so->rx_lock like sendmsg() does, so its
 	 * claim can't race the forced ISOTP_SHUTDOWN below; force it
 	 * unconditionally, even when a signal cut the wait above short
 	 */
 	spin_lock_bh(&so->rx_lock);
-	so->tx.state = ISOTP_SHUTDOWN;
+	WRITE_ONCE(so->tx.state, ISOTP_SHUTDOWN);
 	spin_unlock_bh(&so->rx_lock);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
+
+	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
+	wake_up_interruptible(&so->wait);
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
 		schedule_timeout_uninterruptible(1);
@@ -1445,11 +1484,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
 	 * and RX watchdog timers bound how long this takes. Checked together
 	 * with so->bound in the same lock_sock() section above, so there is
 	 * no window in which a concurrent isotp_notify() could be missed.
 	 */
-	if (so->tx.state != ISOTP_IDLE || so->rx.state != ISOTP_IDLE) {
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
 		err = -EAGAIN;
 		goto out;
 	}
 
 	/* ensure different CAN IDs when the rx_id is to be registered */
@@ -1479,11 +1519,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
 	/* no consecutive frame echo skb in flight */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 			isotp_rcv_echo, sk, "isotpe", sk);
 
@@ -1845,11 +1885,11 @@ static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *w
 
 	__poll_t mask = datagram_poll(file, sock, wait);
 	poll_wait(file, &so->wait, wait);
 
 	/* Check for false positives due to TX state */
-	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
+	if ((mask & EPOLLWRNORM) && (READ_ONCE(so->tx.state) != ISOTP_IDLE))
 		mask &= ~(EPOLLOUT | EPOLLWRNORM);
 
 	return mask;
 }
 
-- 
2.53.0

