Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727162;
	b=WjK417vblPNW5V5xIhEe/qlCJXZLeDXsP6UKY24ymDTrzR8IA1HHtPXK54YKNlDHiRma
	 4ZvgUVWpe6YIHJF+bW+vW8TDhNDcIRonlIRz5OedStz1fHg9E6Nv9e9a/67Jc3SeiTcrB
	 reA+kRfRqDFamQ+8EwFOCZNcEtcFeG6SBF2yLQn3DAWahOcmrvvVKPEaB22Mp+bRRj30m
	 XQ6GNCUmB4AK/WxrGauCbRuUcW2PEJANsjavDXMBz3sQnLtgo4EeWs1saS2sxKTc+ZH+h
	 eSxXBDIgfSPH96L2CWu7KUA2T3fdH9BfO3eetimRlGLzWpjUHoMEb/SPtJbseQvR+Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727162;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mjBg8TsSUQiudgdkGWcCKBtQEZ+8mwk3bR9Dcd9z69Y=;
	b=5XNVCKmDm6KTEXA3ctHHucUHLFcWx0aLc0DaUzr9uz/XPM825L5gdGlLF7cLRwUmbTmA
	 dIHq5jzIz5d+8Ix9cc4U4HNZ3hN2ikyoBKKmTA8sjR1M/3T8rewIoMlUvbwJNLgm2RL8z
	 M3v0oSco944S/+Ot8IkQ4uuLn/d2fBsPVylTfrTZdUKK9h+705m4aNKNa7+07BtPn8gX8
	 /nIqwRa/CfJRD1jGPmqwoiMqOw8icDe07IVZuyQtiKu6hz+sfC+tPdkon7iJCTiLCWEdX
	 Ce62Fc8frNwwhKNqtKgPlZWTxzlhVp14/jum37JmyHP1Z2HqYVo6Qf70QqmHp8dzXLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Doz6+ndV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=MyKmc9ty;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8E606A32A
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D8E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Doz6+ndV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=MyKmc9ty
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fqGN51HJjsaWjVe65ZpeNDQtUTJHtjWE/YKd3dacab0MO+V62m6egDWkjP0BY6NnD2
    agemcmP5XHApK/tZhr6qupeVwUIXpq22plPuFTtrWkP7bCPH6rCoi/04ssXeCknbP/Uj
    3ehXDs0Q72E7Y2yVkcoWvte3j4QQS9S/ZKbF/nY0nuKNib5NKit+KjJbzMcf2SzjfUxs
    5NA2cqN+3V2931LtVO9hc/35U28sCdBFOtLfsWrG8C7Dc05+JAXV4K24CR02uNuGa3LG
    /GCWisQOzn1c7FAiTkx8ccSQhIHcBUZa35qez55tn9ZwwcvowRxe7vLVHZss9XwPn3xu
    NiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mjBg8TsSUQiudgdkGWcCKBtQEZ+8mwk3bR9Dcd9z69Y=;
    b=pWbI4Yepe8zOFH432rtizpSHG3xNnof3HIaXp2sOzoamiCkvc1VBTAEXbTyZ8V/rfL
    jGYdiXig0OL+RaoR4EiNYDbF84JELnGCGb3RBMhgbtwHideYnZjGdF5t4iQRZrS0LaJp
    weZZg/IoXL1mfm9WLgbHgs3jzufsgNfzjZG+fwRfcl433EZby6u0ySbMjUrSdw1abkLz
    TrYlinf/8AefshKOH3dEp5z3KfjPXIRHlN06kJ6DeCAhLDWuV+ajXJv5Jnr2d1jvxg63
    QPbXbAtrr5CaZD4Tye348L8NzWzI3aSnDak8QS+PFwthWFl9P24aojPwLwOnGHorDlW5
    RDyQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mjBg8TsSUQiudgdkGWcCKBtQEZ+8mwk3bR9Dcd9z69Y=;
    b=Doz6+ndV6KDGBV/RJkg+KQB6l0Hx0QkHRRvyQWPpYLNW3KPE8lB1wD/ZVWuSpGpxQ9
    kHtGwTk0XzfMUabkSO0EQbVoQBw96tz2dp4ZVA5xNsJQIY7ZgwJJYcuBEfYMoROeRTeU
    J9LF3/AulgI4+nXhCypITxU/FvVTy1Rz+FV+S+5Nu5ZwMcWjyUmQyjMpsy4zaXvIaBcy
    tjGjDV5iw7cKvYzLX0GtcJsY7CuaplBb2uduvBXvCp0YEX0TRcf64VNSgr84uZyFTu9G
    FssEwIEQWWZLsrPqF4/5O0+LbPVHH9lxxkxaqhA5PcgynRz2Xru9MMH3qEcOzOBPAX69
    EUNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mjBg8TsSUQiudgdkGWcCKBtQEZ+8mwk3bR9Dcd9z69Y=;
    b=MyKmc9tyc5U35q2rnoMCoZlNdFvLTG6XITQ+e0c4iM5iX8Yw/T45mH6iiCiS0qUutd
    Bebpzas1f6VlnzP+FqDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:06:02 +0100
Subject: [PATCH can-next 20/22] can: isotp: change return type of functions
 to void
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-20-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=9950;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=aBRhKEaSAcTHsXh5mBKAjs08HeeCr1iWOyWrCsyT5cM=;
 b=EmPovh5w2/KooU3/SN8U/gncZYgIhnpZidJ8syEVos2oEtireNnVz16y98G5SZYOHfWttfuIJ
 Prrnxx02oljCmw026f26W+x2XjUI3Xx9snrq6uKUj5Ymhtt7+J2OBU3
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The return values of some functions have never been used and needed.
Make those functions void to remove unused return values.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 77 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 31acff7c33aa..a9182588aeb7 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -284,37 +284,37 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 	}
 
 	return HRTIMER_NORESTART;
 }
 
-static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
+static void isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 {
 	struct net_device *dev;
 	struct sk_buff *nskb;
 	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
 	/* no creation of flow control frames in listen mode */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-		return 0;
+		return;
 
 	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
-		return 1;
+		return;
 
 	csx = can_skb_ext_add(nskb);
 	if (!csx) {
 		kfree_skb(nskb);
-		return 1;
+		return;
 	}
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev) {
 		kfree_skb(nskb);
-		return 1;
+		return;
 	}
 
 	csx->can_iif = dev->ifindex;
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
@@ -355,11 +355,12 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	/* start rx timeout watchdog */
 	hrtimer_start(&so->rxtimer,
 		      ktime_set(ISOTP_FC_TIMEOUT, so->frame_txtime),
 		      HRTIMER_MODE_REL_SOFT);
-	return 0;
+
+	return;
 }
 
 static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)skb->cb;
@@ -445,27 +446,27 @@ static bool chk_pad_fail(struct isotp_sock *so, struct canfd_frame *cf,
 	return false;
 }
 
 static void isotp_send_cframe(struct isotp_sock *so);
 
-static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
+static void isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
 	int tx_err = EBADMSG; /* default for unknown FC status */
 
 	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
 	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
-		return 0;
+		return;
 
 	hrtimer_cancel(&so->txtimer);
 
 	/* isotp_tx_timeout() may have given up on this job while
 	 * hrtimer_cancel() above waited for it to finish => recheck
 	 */
 	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
 	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
-		return 1;
+		return;
 
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     chk_pad_fail(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
 		/* malformed PDU - report 'not a data message' */
@@ -475,11 +476,11 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 		isotp_set_tx_result(so, so->tx_gen, EBADMSG);
 		/* set to IDLE after publishing tx_result */
 		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
-		return 1;
+		return;
 	}
 
 	/* get static/dynamic communication params from first/every FC frame */
 	if (READ_ONCE(so->tx.state) == ISOTP_WAIT_FIRST_FC ||
 	    so->opt.flags & CAN_ISOTP_DYN_FC_PARMS) {
@@ -539,22 +540,23 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		isotp_set_tx_result(so, so->tx_gen, tx_err);
 		/* set to IDLE after publishing tx_result */
 		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 	}
-	return 0;
+
+	return;
 }
 
-static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
-			struct sk_buff *skb, int len)
+static void isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
+			 struct sk_buff *skb, int len)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 
 	/* ignore invalid SFs (ongoing reception is not affected) */
 	if (!len || len > cf->len - pcilen)
-		return 1;
+		return;
 
 	/* terminate a potentially ongoing reception */
 	hrtimer_cancel(&so->rxtimer);
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
@@ -562,26 +564,27 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 	    chk_pad_fail(so, cf, pcilen + len, so->opt.rxpad_content)) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
-		return 1;
+		return;
 	}
 
 	nskb = alloc_skb(len, gfp_any());
 	if (!nskb)
-		return 1;
+		return;
 
 	memcpy(skb_put(nskb, len), &cf->data[pcilen], len);
 
 	nskb->tstamp = skb->tstamp;
 	nskb->dev = skb->dev;
 	isotp_rcv_skb(nskb, sk);
-	return 0;
+
+	return;
 }
 
-static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
+static void isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	unsigned int ll_dl, len, sf_max;
 	int i;
 	int ff_pci_sz;
@@ -589,11 +592,11 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	/* get the used sender LL_DL from the (first) CAN frame data length */
 	ll_dl = padlen(cf->len);
 
 	/* the first frame has to use the entire frame up to LL_DL length */
 	if (cf->len != ll_dl)
-		return 1;
+		return;
 
 	/* get the FF_DL */
 	len = (cf->data[ae] & 0x0F) << 8;
 	len += cf->data[ae + 1];
 
@@ -608,21 +611,21 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 		len += cf->data[ae + 5];
 		ff_pci_sz = FF_PCI_SZ32;
 
 		/* unneeded escape sequence => ignore PDU according to spec */
 		if (len <= MAX_12BIT_PDU_SIZE)
-			return 1;
+			return;
 	}
 
 	/* the PDU must not fit into a SF (FF_DLmin) */
 	if (ll_dl == CAN_MAX_DLEN)
 		sf_max = CAN_MAX_DLEN - SF_PCI_SZ4 - ae;
 	else
 		sf_max = ll_dl - SF_PCI_SZ8 - ae;
 
 	if (len <= sf_max)
-		return 1;
+		return;
 
 	/* valid FF => terminate a potentially ongoing reception */
 	hrtimer_cancel(&so->rxtimer);
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
@@ -645,11 +648,11 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	}
 
 	if (so->rx.len > so->rx.buflen) {
 		/* send FC frame with overflow status */
 		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
-		return 1;
+		return;
 	}
 
 	/* copy the first received data bytes */
 	so->rx.idx = 0;
 	for (i = ae + ff_pci_sz; i < so->rx.ll_dl; i++)
@@ -663,41 +666,42 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* send our first FC frame */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
-	return 0;
+
+	return;
 }
 
-static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
-			struct sk_buff *skb)
+static void isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
+			 struct sk_buff *skb)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 	int i;
 
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
-		return 1;
+		return;
 
 	/* CFs have usually the LL_DL length */
 	if (cf->len < so->rx.ll_dl) {
 		/* only the last CF may be shorter: drop it when the
 		 * missing PDU bytes exceed its possible payload
 		 */
 		if (so->rx.len - so->rx.idx > cf->len - ae - N_PCI_SZ)
-			return 1;
+			return;
 	}
 
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
-		return 0;
+		return;
 
 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
 	if (so->opt.flags & CAN_ISOTP_FORCE_RXSTMIN) {
 		if (ktime_to_ns(ktime_sub(skb->tstamp, so->lastrxcf_tstamp)) <
 		    so->force_rx_stmin)
-			return 0;
+			return;
 
 		so->lastrxcf_tstamp = skb->tstamp;
 	}
 
 	/* stop the rx timeout only for valid CFs (checked above) */
@@ -705,21 +709,21 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
 	 * while hrtimer_cancel() above waited for it to finish => recheck
 	 */
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
-		return 1;
+		return;
 
 	if ((cf->data[ae] & 0x0F) != so->rx.sn) {
 		/* wrong sn detected - report 'illegal byte sequence' */
 		sk->sk_err = EILSEQ;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
 		/* reset rx state */
 		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
-		return 1;
+		return;
 	}
 	so->rx.sn++;
 	so->rx.sn %= 16;
 
 	for (i = ae + N_PCI_SZ; i < cf->len; i++) {
@@ -736,37 +740,38 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		    chk_pad_fail(so, cf, i + 1, so->opt.rxpad_content)) {
 			/* malformed PDU - report 'not a data message' */
 			sk->sk_err = EBADMSG;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
-			return 1;
+			return;
 		}
 
 		nskb = alloc_skb(so->rx.len, gfp_any());
 		if (!nskb)
-			return 1;
+			return;
 
 		memcpy(skb_put(nskb, so->rx.len), so->rx.buf,
 		       so->rx.len);
 
 		nskb->tstamp = skb->tstamp;
 		nskb->dev = skb->dev;
 		isotp_rcv_skb(nskb, sk);
-		return 0;
+		return;
 	}
 
 	/* start rx timeout, isotp_send_fc() restarts it */
 	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
-		return 0;
+		return;
 
 	/* we reached the specified blocksize so->rxfc.bs */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
-	return 0;
+
+	return;
 }
 
 static void isotp_rcv(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;

-- 
2.53.0

