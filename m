Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933364;
	b=YlmCmyD/z/tEaavzYYVO3pN1mw2gDxpWj54SpjERwpGKFrUipl13YGIjPca2g5RizKbx
	 XykWD+C7LKdxW8WEgK/zGp0FtDi/dhXgaPxaSR/VF/ZFGpUL7fV9ZOUSjYZy6kRVMtD+/
	 6Xvf7H19DbpaUmQ923VrtktnGi4n3XFRlA17/+zbVc3VLDn3HEEz0AxDwLUG2FbbVugyM
	 qdJrBSJ6nnUnNuzOGeEIQyUUSa9Qe5e6qQ+VUhKoXGAfb0T2SQ4YR+xFkfn+IKWlsvEVw
	 2ezhn9jo/RmlhprlJtAPk/H6ylR0lAy0kSm0pqRzvpMBssPAFxg12T1wYwFIbkw9sBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933364;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qFaZtaTx3I+S2AwZkvSfpDI5Wp+cj82esp5Zb8XDMFw=;
	b=w4axjRp85qzn4x2ylsmDGNgDQmq+fBXDSXKoGcHBoi7LfoB2KcYZLQnqOvbfiAjKxIDJ
	 eB42wy4cRJVnnDh308iUd8EafFIjrzgof6H7fx80CHOxOw7qlxtu9SPmavoGzWAjAEHIK
	 JUxye+cCe6JSjzG32SmxsBE3oFxZYs+fjBTclQivQyJcq/wxTwiqt/W8S196jrKIkswnI
	 wh7lllcOoOSwsrCff4+0TA+k162A/Vay9/3BhD0qR3yYLSIiP+6ZKnjQ4DpTh+NWyMvVM
	 0De7AhYSy5YwtnZP7WvpFeRDD69i0rkLV1nUKhXONapIRXydYZIL1ee3Ybtl/Wj6n0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WSGfFDLY;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=WdPRNurj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D9606A331
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3D9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WSGfFDLY;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=WdPRNurj
ARC-Seal: i=1; a=rsa-sha256; t=1794933348; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cQH5q8rI7lToQaoFqVmiRR2VgQN/2lHUTUXSYyjV/Auxs1TS6K49BTfu+abP2J+eDA
    i58wEcKzbHrHVdsEzBO7XqIlzVEHhcLlSOPMKPKt6tsjCY7NxLMV1LISHKZ5usHt9/gL
    pmwu0cPqwJFDo1zbrGi84bxM/LyO5ZeA7r8n+3/qD5NPVJ8sJB1l6OEpvMvbvbM2Fv71
    PykFlWbg/OIz1iniwUClU6BYP0fH42UMz9Hca88AWucFuHNLY/A35bl15AY5yWw4LLrG
    BdcPjORjbLElQa8/jnW1l1OaWZAo9FFzu057BcLtOVKEgesKfPPaGjRBTxi6gi/c9rzq
    d1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFaZtaTx3I+S2AwZkvSfpDI5Wp+cj82esp5Zb8XDMFw=;
    b=qaQ1bEBJYizxogULtihkbTF31Ffj0s4GaHBjHmDo2cJDm70CCGuLb8Gi+jjaJ2LWtv
    Led7Z77+UrBd5Nmd+hZS2MGiGPsv5zQTlBgvJbNu3u3SSX+N44myKxtIJo/9H8XI4nSg
    RiKakinyhFRdjTTekUmJGIBnBasrB2ysmkmmaoKDzRW90d0ZXQseziWgZHGUBxoT++gV
    E5asFE3IOpZ072E3Dem985HCuLcoAdcT2Y3iNz70TfF807XSpfnGlRCPkNb/xpHSXsBI
    R7tCArAUAYafEblEzA3EK+jHVTUfuETTkroVD9aBiA8914Rb5ujJAV1ySdOD0Ux30Xiu
    wv9g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFaZtaTx3I+S2AwZkvSfpDI5Wp+cj82esp5Zb8XDMFw=;
    b=WSGfFDLYpbmYxqrqtypproR1KPbfItmHVvyFV0928w0mKMvtYp/Aws2sTXOOq/ZsKs
    mm+Mrzv4KKBZ/wuVzLgInNw7lUfDMaPFNeZ0Ac6TDoQx9umpUcqA2Ch9zyVRZQrd826P
    +rd87I0C8mXQc1k5HS09I2FZvwD/r9nRy5SBStS1NI9C8/fR3Q92pZhrGcBUuCmdjfQL
    J5Fx55x3z2C8yE8Fdag+5KCj3j3cMfXye5iXJxUFyzUZtjsFeB1m7Kh2ziJtr5PSwlDp
    sX/tyBoznRbTLaQ614eP68QBz6ilHe2aT0bK/uNFh9w737cWHhlaek3Q4nTS7h1QGG2s
    I3Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFaZtaTx3I+S2AwZkvSfpDI5Wp+cj82esp5Zb8XDMFw=;
    b=WdPRNurjeYHDhqYr41gPhQgTQ5d3Xl+m9Rd6DrDm4i/v1Zeox01063VrF8TkNGWIOO
    PZRnEboAKRDcMTFk0EDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZmcee
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:47 +0100
Subject: [PATCH v6 6/8] can: isotp: always start the rx timeout in
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
Message-Id: <20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=3068;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=nOnAknM8gO/4TOQpTZV5r1xhTQol9ScA2AjYvJmAM5M=;
 b=2TRl7k4xsf+0+1mwiVS0K1h6sgLCKWZqNQ3UkzjeJTDgLwCQEA2W/p2IRn4kDSiGSvy/VBhWb
 NsKrFyotlZpBeQ7Bk/7n4N2cKTuGATVoEFgwBj77dD3KdSryYV4WRyZ
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

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8229b6a69ecd..0293d590186c 100644
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
@@ -724,17 +728,17 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
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

