Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727155;
	b=NEBhNjhTGH8LMiM4+wSuzmJ3qlCgYxPtSYHH4iN7xaHOTNFgvJrCesBt1n2RFt2EdhGx
	 7mvxHRHFCEvro2ZzR06GrFojP8NhxylgKmqCO+V5EXulU+iTYo16lAwbUXwdWFDBwp30s
	 fPlAbsxZNllJNmO+OlRuBJ9gmcSFQjnWoEtLp2QtcacB75deg51HeEfoHyiBlLvGMA9p3
	 YUx5WsPQ8sz9vrJAgMgDxJv2/jC6y27rO/7UZ/JoBcg7UOyfIWPP7bNjOgvPQt4kCuhsh
	 QzpbLRMCguaj+A8hgZOws16Gl9os4lCJ3VV7kjSFcAwkl4Rv2fXrptvHEiXdYZvBRlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727155;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JJVdAvhH49BM2rGDtOmY079blHJAWxRmqmXIovnwsZ0=;
	b=KUjtwRs4A6jxUdbl1RpumOhfei+KVi4rEtUBbNayRpiK9iHQfPvRpvEz21qKWDzOphtc
	 SvCWvXQTfL30FHkM8wrDIJD5d0h1USLl4THqYAX977qObP45MDpILzm0HD6bPE846DHAL
	 ueicTvXt41yww2s6qhvBhNZyVwxlcsCnr0ghKrCJLB7jHKDNl0kl/YM9DLlm5KasJTGA/
	 RHkuoOErRhJjdpPOQ6oP1jzcJIetp8mpNI3xkE9uNv96DAV/wTGx7kbjNSy/aMP+56raW
	 wL76Zeh7tosDjD6FAE8EmAlInX0qB6Hckz4HARg0KSGN+8m+60E6p+11cPbiZnXMSuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=X1U1WkVs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vqWGt8rR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AA606A323
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA8AA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=X1U1WkVs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vqWGt8rR
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XAFMj9WviK/YpCWvYKcsnGgyYZpINUXC1S0eS4A1mGDFpgFnsPam+YeYbPLo1Eklpq
    dAPjL1SOoEtipmKQAMgtc+XXUD+RVTUKwEFSH88Uy/59nhNBhZLR3/VeotHK/fQTuYAW
    ZTB6vrHjMDqT99+0uZu0tWP1rvxx2VHnX/2WtYBDkA7z7YY7N4sCMWJbEfLxCc6Rc08j
    GNVqim0rRF2itsxQhaCmD2K+j8L2nWmGFAy+TBhhjIEcqms9+W//jFS9beIFJAAfIFGq
    UY1zOX3QOFD3lICSlRiJfEp4OKxkVkdXWV8gChJwLC9Np3M70QIX9jRPUFM0cshEaVXc
    LAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JJVdAvhH49BM2rGDtOmY079blHJAWxRmqmXIovnwsZ0=;
    b=YzyF0fnZ6bt35bp22O0NCZt23mBJ1p1wo8IlJURaHi/CtTSi0n/xsyOfZDyC/9tXKX
    slpi0y4RRi3V/DR4yx+42tD3nwTC6y7jXe7U1zNS13/HsHnN9BA6ItH4l2gNDZSwYYLA
    sZuwvhaHy2PHN2/cB8hTHE5WqMTLzrpz0drwV5nfqm7p0LOydmP1mzMc9gj0qlUsiVxE
    KxMcxe+7ctma26xvbWcfOa2Np1S7goQ7Sqe2PgZijhcRX6AVfljj/BDpovSb3/Xve40i
    eEf3hDgJ4Y7FoiWsXzRnPMuXD961ybs+8blPfX4vfYNx/TGt2zOlJ/Ocv9m/bIx5Gtnh
    de4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JJVdAvhH49BM2rGDtOmY079blHJAWxRmqmXIovnwsZ0=;
    b=X1U1WkVsJd/27VrpguXW/lRM+RyDRF428z74oo5wR9UykyRPDjWSzoRXym3IUNjk0B
    WHrwt1QOM6JhYw4kI2Mk/2VN9UFelJW3Terko0OwXs/0l2STcfpaxxqkBPQhlWBaZqaK
    kJD8DERoBdLR0u16C7ZGAcMmKuH7ArZ6KWSujuv1gWWgheHBY7boHVc5s6pslr/+arm2
    js1nVr2B4mR8XsjAiFc0NhUYRSs4Hy6LuxLrUct4PG/T1/Mofp2en+Fxb3C3WkGglw6c
    n80fUkccce5h1TlJgX7Ri49ZVB5pfJf8RFFheSZq6viVTjznSHtSI7oxM0XCdiJz9Jmt
    kcTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JJVdAvhH49BM2rGDtOmY079blHJAWxRmqmXIovnwsZ0=;
    b=vqWGt8rRWXw3Tpx14R2SIigmJmsY237ac2Vze/hcmcxdWVnF79+bSK+0qDiHgMCbeS
    00qFgm5VgLdGSwrGZNBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:59 +0100
Subject: [PATCH can-next 17/22] can: isotp: introduce isotp_invalid_canid()
 to verify proper CAN-IDs
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-17-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=2258;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=dzxZ4glyinasHyh9/z4wfrhOE/7OuYSVCzz+hOzqDZs=;
 b=uNagK+Wo4LBCpOGopxulvrH/4hDU3EONqHrb+EbZjoRdViOuPkkecvVeBHoRJnt7eEHz/5nRw
 1T2t6c5KZsnBqQPb5f8yPoUVfOSjWS4Mht3SyJ2j2VktOwErjwhkXDq
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Move duplicated code into a separate function as preparation for the
CAN XL support which will need this functionality too.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8e8f838160af..1f8d767b603d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1573,10 +1573,27 @@ static int isotp_release(struct socket *sock)
 	sock_put(sk);
 
 	return 0;
 }
 
+static bool isotp_invalid_canid(canid_t canid)
+{
+	canid_t sanitized_id = canid;
+
+	/* sanitize CAN identifier */
+	if (sanitized_id & CAN_EFF_FLAG)
+		sanitized_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+	else
+		sanitized_id &= CAN_SFF_MASK;
+
+	/* give feedback on wrong CAN-ID value */
+	if (sanitized_id != canid)
+		return true;
+
+	return false;
+}
+
 static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1591,31 +1608,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		return -EINVAL;
 
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	/* sanitize tx CAN identifier */
-	if (tx_id & CAN_EFF_FLAG)
-		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
-	else
-		tx_id &= CAN_SFF_MASK;
-
-	/* give feedback on wrong CAN-ID value */
-	if (tx_id != addr->can_addr.tp.tx_id)
+	/* check for correct tx CAN identifier */
+	if (isotp_invalid_canid(tx_id))
 		return -EINVAL;
 
-	/* sanitize rx CAN identifier (if needed) */
-	if (isotp_register_rxid(so)) {
-		if (rx_id & CAN_EFF_FLAG)
-			rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
-		else
-			rx_id &= CAN_SFF_MASK;
-
-		/* give feedback on wrong CAN-ID value */
-		if (rx_id != addr->can_addr.tp.rx_id)
-			return -EINVAL;
-	}
+	/* check for correct rx CAN identifier (if needed) */
+	if (isotp_register_rxid(so) && isotp_invalid_canid(rx_id))
+		return -EINVAL;
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	/* so->conf_lock serializes the binding with isotp_notify() */

-- 
2.53.0

