Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174153;
	b=WmLaRKHYvK7grnWJRhTp6WlX5Le3BXP8aj9eOVP5NiBpEGZgIncwPDNHAB/ult8RogEo
	 pTSRF2GPO7deMSwcUNWe0EiIsuTS0jvet4+8RpxYX6aQvLxDVWKmvee3Fg1d+aVTuL8/r
	 Uh/hNsYDPIrIV7RvOjqFgeyvspFjytlNme+DuJBykumZ+qPqKwE97ELq9egJsURU4GJ/N
	 bI4cUL0ZyPcvd/85Za5WKEJrxl5vKVPzSQGFbzRPXFSImlwAdiEHJvVI6mrnU55VJc7AU
	 l6VXXVYCwO67/2ZKxd4cWoas1yh+DGOdtfl1We/fIFyCLDZl2zBhd7be2Th2gBxv0KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174153;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RJAxXG/ixXbf7AQs4zJg8l/sxqeicEDTK12+TfNEr6g=;
	b=sZFCfXQpGp33VYEAtwSYzBgIy19iHilxvbrI65DMSQIR/YaptK3y2zKIeOphk5dpcAVp
	 7ZPbk5CA+LEUW57hre9uloRltdv1dlbe4roJaWASeJ47s1RM+YS3g+G0JpDhrjjb5g3+s
	 yn8f0IPv5NjegIfqvoojVcxvcelkvErmBIK8hEDK7/G/UgmZ7f12jVuXKCxQGrnfFWKmq
	 vX+XspxnkVZ35cypXRzDpwaWV0ipmXhxmMLn73s/3VgkE0FDis3LMF8PQVpKy2VhHbuLR
	 XmeawdRj0/QE/HMqweXrYKuHjxP55VCOcu/aRCRjbvJXbd8kdDCUu2ue5nsO9rfT4gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="C/mXkExV";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zNdiQFQm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE1606A320
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AE1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C/mXkExV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zNdiQFQm
ARC-Seal: i=1; a=rsa-sha256; t=1795174142; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z3AGuu424ieA4JJzQ0fD2RvgGrXr3I4Xdk9PhnCUjLTO6Uc39HdsfyUvzkdX9045vU
    uSsiknWAf172GSG4z0eB0Nfr9FFjf/PHNM28u4wAz/mQsxJFRuWKxw78je0orsJx7CtV
    w7c9PgqzGn95GYS4REb5Fr7PFU57+XZulV8gHsEdGp9bgF0/bOXcfemJYFvaCQuuCCTP
    VRmsupqrbSG4n715aQGVZ3iKgBtbv3jAzN0Am1UBQ72WSxuqXiBwsGwAMD29VqEKJBOd
    Ydb3Y3fEkK3qG/UfjTh9NqKPU+0i8MhI7b+51nNNJQWfl7Op0hJZ95ZVVWuPUTe1LBqd
    evdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RJAxXG/ixXbf7AQs4zJg8l/sxqeicEDTK12+TfNEr6g=;
    b=NEy7DmKef3TuI6J2HLQ4Q7sH65eE6Ec27gGFcL7769RfjzORD6JzKLVGdY1xZFCG2Z
    qjf78s1Rc7+DnhypY2ew5D0UjTaaSSAKi+umPvD13KpGbZ9XE+kBsZ/mPb/66HJynVdd
    Jvq9cLoZ99fF2geKvRZQbX4xI7uF4y/SahuZUR8t9cuXihS0rDgir2YYcizfY5onXaqB
    6SHP5Wrr7wMr62IpaiuDmvHb4hvC9WNPQc53wJ3jhc0pbVkWRb9MbvqpcxpjKbHhp0MM
    e9go2O7rc1VOxbhfnh5Ww3GyQypg2S/bOVt43GfPTw/dHLlLGXDK38wLWAol9o/yX4s2
    83kw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RJAxXG/ixXbf7AQs4zJg8l/sxqeicEDTK12+TfNEr6g=;
    b=C/mXkExViAT6mBBD+1GNLLOQrVnp74EDyGfhvJ4tImhluAbBFEech8z1at+DUA3bw5
    PT7Zpji1nq/WO0MS7JAptqNxS2AVJZLn0e9tseI+wL7I9rDbtd1B1PmUNu28o3zqMGNe
    8hCgGSa+VFNOqL5dZmF4IcVdJ1UlS/WK+zAVvHqHf0c/xXIc2LPM80oRYGzAmyfDPjX8
    fsKjhNXUvI4pOFqCsLGCyToCPR5KpBH9LGyuL9w+u5RefqfZbXFHMH32Ft0jcd7qa3e/
    aSE4CgYgJWRDfc2Zw8/Eu4h/v58AbQ0rvRLB4LcnlN3UClcrOcS0ErfnEvGFvc8r5UNx
    QFGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RJAxXG/ixXbf7AQs4zJg8l/sxqeicEDTK12+TfNEr6g=;
    b=zNdiQFQm90hzC0o/cs3JVoEAFmCiQWoFmfyTkcnbKtL1GOxmgMgagd8mK95lP2Dmax
    TcQcAf5XuQ2MJgv3X6Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT2QMC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:02 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:29:00 +0100
Subject: [PATCH v7 6/8] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
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
Message-Id: <20261120-can-bcmlock-memcg-v7-6-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Sashiko <sashiko-bot@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=5327;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=9t/hXjwQ04Aj37vbadUyjP1bscL31TCcCP+d+c7tieo=;
 b=dLbc0p3Os2KovlRP1iws9zz/E0cnZkEF+Fru23aBmEe5JgbZZuok51atEDc0pvfQo5aRGtXDb
 lNF1od3H5oYAhLiOh3yXjfOpMAVbKcZEAaSh2Q917KVHEty228h0z4t
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The rx timeout is only started at the end of isotp_send_fc() and for
consecutive frames inside a block in isotp_rcv_cf(). So so->rx.state
can stay in ISOTP_WAIT_DATA without a running rx timeout:

- isotp_send_fc() returns early, when it can not allocate the skb or
  does not find the CAN device anymore
- isotp_rcv_ff() does not send a flow control frame in listen mode
- isotp_rcv_cf() has stopped the rx timeout and does not restart it at
  the end of a block, when the flow control frame is not sent
- isotp_rcv_cf() has stopped the rx timeout before it drops a
  consecutive frame with an invalid length (reported by Sashiko)

On a bound socket the next first frame or single frame resets the
state. But when the CAN device has been removed, no further CAN frame
is received and so->rx.state remains in ISOTP_WAIT_DATA. isotp_bind()
then rejects a new binding with -EAGAIN until the socket is closed.

Start the rx timeout in isotp_rcv_ff() and isotp_rcv_cf() whenever the
reception continues in ISOTP_WAIT_DATA state, before a flow control
frame is sent. isotp_send_fc() restarts the rx timeout as before. All
this runs under so->rx_lock, so the order of the rx timeout start and
the transmission of the flow control frame does not matter.

In listen mode a first frame that is not followed by consecutive
frames now leads to ETIMEDOUT, like a missing consecutive frame inside
a block already does. So a listening socket reports a missing
consecutive frame consistently, independent of its position in the
PDU.

Check the length of a consecutive frame first in isotp_rcv_cf(), so
that an invalid frame is dropped without stopping the rx timeout. An
invalid frame also no longer updates the timestamp for
CAN_ISOTP_FORCE_RXSTMIN.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-can/179504035916.3136.12986898667697830880@kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v7:
- isotp_rcv_cf(): check the CF length before stopping the rx timeout
  (Sashiko review)
---
 net/can/isotp.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8229b6a69ecd..0b7db1ead7a9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -632,10 +632,14 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 
 	/* initial setup for this pdu reception */
 	so->rx.sn = 1;
 	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
 		return 0;
 
 	/* send our first FC frame */
@@ -648,10 +652,21 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 	int i;
 
+	/* CFs are never longer than the FF */
+	if (cf->len > so->rx.ll_dl)
+		return 1;
+
+	/* CFs have usually the LL_DL length */
+	if (cf->len < so->rx.ll_dl) {
+		/* this is only allowed for the last CF */
+		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
+			return 1;
+	}
+
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;
 
 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
 	if (so->opt.flags & CAN_ISOTP_FORCE_RXSTMIN) {
@@ -660,29 +675,19 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 			return 0;
 
 		so->lastrxcf_tstamp = skb->tstamp;
 	}
 
+	/* stop the rx timeout only for valid CFs (checked above) */
 	hrtimer_cancel(&so->rxtimer);
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
 	 * while hrtimer_cancel() above waited for it to finish => recheck
 	 */
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 1;
 
-	/* CFs are never longer than the FF */
-	if (cf->len > so->rx.ll_dl)
-		return 1;
-
-	/* CFs have usually the LL_DL length */
-	if (cf->len < so->rx.ll_dl) {
-		/* this is only allowed for the last CF */
-		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
-			return 1;
-	}
-
 	if ((cf->data[ae] & 0x0F) != so->rx.sn) {
 		/* wrong sn detected - report 'illegal byte sequence' */
 		sk->sk_err = EILSEQ;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -724,17 +729,17 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		nskb->dev = skb->dev;
 		isotp_rcv_skb(nskb, sk);
 		return 0;
 	}
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* perform blocksize handling, if enabled */
-	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
-		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
-			      HRTIMER_MODE_REL_SOFT);
+	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
 		return 0;
-	}
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
 		return 0;
 

-- 
2.53.0

