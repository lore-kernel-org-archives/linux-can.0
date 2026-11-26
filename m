Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=0fjoGnK4gqywclYBOjBKN0fwupsN0SNMFsIg27ZrxrkcQb4K3xLeJd0gzaHxgzvbH21D
	 P5hBS6lmG1G2OGWuLQH/DtUvm40JEiaEj8XOdd0heShk+L6+JTX/AtQe+xj9ZgfiDNVSn
	 xtxey/8LaN1XGGfp8brkZZmkEcegr1tp6GZdI8PiomBFg2tseH2wnAzG+Om0wC6ASpsVy
	 41dD4GmcH7kavztNVuXsM1Rtscmn83Xv4punJ1AWlX4Gwp45I7Iqyjtc01TEllKfY0Qgg
	 aFTVd1D66qBvAtxWhaAt347gjiRK4hJtzq+fNlXzVx7O0dGwFIzkQVOjVVXTtXCP35Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=H0G29LsxxAiyW2AtC8cyfpT3eyLOuJdbWi76VfpcCt4=;
	b=P/8MTee+L+DC+7AC2BgSfQc3+V419z/2mUiw/+UIfewAekIJC9ZYln5JtkI57fRtTZwQ
	 QxmguoxcXd76k3IQLdzQ3UFOQB4jnpTblUAh4JzOnHwnLyciH7czxQlod5Nc8RNFeupt3
	 Npitlfksx5hqn7iAJuE6jvJ+12T9t7qENFO0d3pc/pVdXfKX6j2lN7fRRKI8QqWhXUelh
	 qCnTgY17m3y257XohedijqILTn8zLgVMDhpVr24pvTLGNC/A3kpuU+10CYCCDJ+bA/slX
	 Coza3CkGIcK9SFrktgE0tiECwhQNCW0mNq4mdoF7Tsnqg7OggHh2Vby37ZW90DfSmgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oBFmdsID;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0A8NGa+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8A606A326
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC8A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oBFmdsID;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0A8NGa+F
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kEWhEsexfsS4jAAQMzYz90j3n0Dej/KRmNMabjIbk3h+477OXZB8oHaqjjijPSUk1m
    tjx1+OhVIqQ6Kl4XEj0wtzMCShDuPjH8+L53NfQTljxjvIVY7oKhHalaA874MzQC20pY
    aNUBbI3hj4h7lJ2Y7NRJQq8rbQfRDvIFgo8pVbc9dHmYO35xoaRILuSoSAhnkly0T03X
    TQ+gLJIDLGHCaH6U+HHrVKxH6Fl781FYPXmMRC8BWfbN7+MnqPNC9xfkNnhhtAfdj8QT
    3PkbPUP9ZiHBQw7pfKvSetaEXh6/FIXiBPrj28+p8BB+368ei7R8M3D4bdbs7EgmmE/r
    2wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=H0G29LsxxAiyW2AtC8cyfpT3eyLOuJdbWi76VfpcCt4=;
    b=MABC63QzUQQWxAaIe4o8YjZsQWfTPUGeGDcx0bhYHy2Vt7zHMEzZ0KtPWToy+jOPoJ
    qROcGp8e3XIxjwd5lFjWDaXI6NZmAi8B1+Xtl+R4tbEjmlnx1KmOX9rBMxtMEiVctZ8y
    A/WQ8t1YcsYU5ZxRmXom6Z7rIZFF4rEDnrmfxn/VPwuXl61I7KLv3Q0X1ZVsjBRkqLUI
    Mlsj8/5rCJXno4zFXa6W38yPpYQklEottsBt0ODjmInLl4EXsFX7Ed51xnL2xPR/aCNN
    imsvDrcIMpV7xSzmN11UYGlkSMjOoi/ad1tOknoAB+ZbTU/Xn/tLzmIYjPEriwDI4wLW
    yGEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=H0G29LsxxAiyW2AtC8cyfpT3eyLOuJdbWi76VfpcCt4=;
    b=oBFmdsIDmGO+Ob5sO+2ynADIIRA517lTVr1ZRKMw8MPTQ7gZcLpwrQDZvbHSjYDGOX
    qcBsySx6CpKYQ1qFydfCL189zQwJk8i2bamKeyD0EDedu/5qe0Das2RbtPv8nESBgfGm
    WGTlCuMXRNf/FbKg19MOBwGGxwBIJ9IZVUq+jXwIILhA3kcsxTwNAcXYDrFMoQPFqjMw
    prNOdnujYfbKyqFKPaYDtUwDzypf4f6fms0EZX8sgt4ATdSPEZvVBQL2H+yb8WF25HNK
    owii6puAxKbfJn8Yb8zMn9IzwcxLtnOhULyyEHT5OFGL71KzyP8AkmPdLSnCgxfAoUlf
    Z2NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=H0G29LsxxAiyW2AtC8cyfpT3eyLOuJdbWi76VfpcCt4=;
    b=0A8NGa+FexlESscga0R6h7F4mwjmEUCgqwBtVMbrWJYdI5Ro27KL+QyJQUoIkCZNHA
    BNxlcQ7XzOyca9ooySBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:55 +0100
Subject: [PATCH can-next 13/22] can: isotp: do not send FC.OVFLW in listen
 mode
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-13-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=2000;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+kqdJwPFWFMNy/YuCtSo8wNnpSQvx5euX3Jn8OnWlgI=;
 b=pRlD1/KEDw2Sr+xZOsikZb1XxFtTBb5K2EQmkkve9DO+2HqxOBP3PU3Ostr1OPa0QxMR/Wp5M
 KuOFJKcWYbGChYhQayKF1Zdagp2nqsxlp3nvEHPsiWwNbBAxr1HIpwP
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_rcv_ff() sends a FC with overflow status when the FF_DL exceeds
the receive buffer without checking CAN_ISOTP_LISTEN_MODE. So a
listening socket sends a FC on the bus, which can abort the transfer
between other nodes using the same CAN IDs.

Move the listen mode check from the callers into isotp_send_fc() before
any state changes to cover all FC frames.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8ae314fe68d2..f6801c18172c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -293,10 +293,14 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
+	/* no creation of flow control frames in listen mode */
+	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
+		return 0;
+
 	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
 		return 1;
 
 	csx = can_skb_ext_add(nskb);
@@ -650,14 +654,10 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 
 	/* start rx timeout, isotp_send_fc() restarts it */
 	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
-	/* no creation of flow control frames */
-	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-		return 0;
-
 	/* send our first FC frame */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
 	return 0;
 }
 
@@ -753,14 +753,10 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
 		return 0;
 
-	/* no creation of flow control frames */
-	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-		return 0;
-
 	/* we reached the specified blocksize so->rxfc.bs */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
 	return 0;
 }
 

-- 
2.53.0

