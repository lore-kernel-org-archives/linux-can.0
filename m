Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933364;
	b=j+K51NnLmhx4pRWod9Kh1yfNBMlm504y+YF4pyvd3P1QfZDYXRo+p+Hv9R9Wv357zbJI
	 tuPmHVt4yd+W/6TzIwvUdips/2BFDBqbCAJunGTnPk9tCHbDtuWceh/+IqGN5HCGyNL4o
	 e6ZYbxA29LNu2ZEXP3vKjLB3Pd9wwLOZQ06Dk2v5hJKC/dxhcLdvSngXf5EOrfGF3Sd5y
	 HbbWXVeJCdqrBJJH13mVVUeCKRjVjzTdvdfbcAReDOr9CemihhHltvNk40zExyJ8PGCxh
	 bfSXqduvOCCcT7Q4Z0D3Wx3SEPNNNtPXGZIgXCchaJdF1dmOSHIkIu4XYTdvm51X0zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933364;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+h7Nuy0fl5pcqqlmXoJGiMMyP/8pwBH8gg8a4IBlyQM=;
	b=ftAzwqPKx8TjDAoWsF1L1+h552cT7M7RaNbOpXVpl7vsH2WGTuEtl51DgUgfLFOzt2ql
	 nds4ENthWP+1RtRywHJsEYOOmVXmGe2OP0XWl6VfL+xcGPcTieY2TIlsoxLmvGUfzlK9T
	 Kd1yIfJtySV8AgEyyfD8tLEivJSMR2fLgjyoRyxO9fMbLw393S7YUO5QCXY5sAPT2ueJI
	 hLecKfSbC4i3IkAcu5Ih+kG5cyNI7WkRSMcjgVmELQoeXRrwWRIEVlWzjLcFYi8QyamJX
	 XCJCO6ZRLFkYngvhffh4ebxdnxeBynHFL4yHWYYzgCP2akdKzPu3oiDjiDx8HPyi4Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CQSqiKaw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PGrCQh+2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD10606A32F
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD10606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CQSqiKaw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PGrCQh+2
ARC-Seal: i=1; a=rsa-sha256; t=1794933349; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EumoZTY3IHb67fGNKGb6GJDcEJPd8Eqs5T3e874Aw7on+rLqVTTlAZoilPlDuF7Is6
    dylktJcGU1uKc90C6A90cMIm7gNFSxNDAGq6KzbgRumZPGfz9rbjytMa6Eif+ysoy1kV
    LH9WyIm7If+zZWiaACHlsHjeiTQVwo02DHs0Xptfz70HNRjRmpgpsfqTHOXr0kA1V5RB
    a9s57yAilv2Ajmm1BTEH3TPeWRM0g4Pg/GSsKQB06m5zOOmFqMLJZ4foc4gL0xH7NGy8
    jWRsECyIVyWQiWzrxvNYGq2G8Usud18Buhz29IBqESy5/gBqLBavEHv1RLyZdEEsDA2e
    GtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+h7Nuy0fl5pcqqlmXoJGiMMyP/8pwBH8gg8a4IBlyQM=;
    b=RiXKFn5OvInlFI+YoXshm6vYHyfFnQzE3XYQeIiTon7ljxclyGVrMEGVdEd3KFK46t
    nz+V90Nr5nQlzDospi8r7vwCE4YJJ4xjMvoWVbQ5dQe3bCtnB7dSS4zNfjAA4+pJ9N1f
    iP7p2IdvakL++baafzrFszaghCA496EX6EydU2/cASHKrgPce685cSpE/UNYKPd6iQG+
    PsL1P3Qx93hfX/j6ixa5UEX38jVDlVAkPM8qUJ4wA1j1uu4FDxQ1paVW2IcQZftYXioW
    ORdD/+Q0O2oF/T9r+IUS5R3U8OVfvbx1Dm6orxm7WiZoVFgzr8R04tKcr3+Ib47e981K
    //yA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+h7Nuy0fl5pcqqlmXoJGiMMyP/8pwBH8gg8a4IBlyQM=;
    b=CQSqiKawQVF/4KRl+OYl/TS5D0riBhg8RHVh9V1KF+MzoZXcXtZFzl2NLjSxIYjcxP
    v8TH0ErtX2CzKs2SNlSv9emxrL5nVsJVL7BrTUcpy2xXj2TsPb+uCowmGULX3G3C10u4
    l5I9EQKDkaYd1r+zyEELKoxgHTJkZQoZazuo5JF/N+rjasCe0nIoRYm8LGPV6rj2jIcI
    rJKKTbFstKmO6MEvOcQgDWpzWi+kb0cKvlfsUfF1i7NPfJYJKOdEWAnD17yBoMzhx63Z
    6VOBU3pkRXo/L7i2oqUQb+Bkmxw9UJAVAKDRtMcyiWU/gik91KQdbZUmbqIOP7K0yKVq
    Hrig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+h7Nuy0fl5pcqqlmXoJGiMMyP/8pwBH8gg8a4IBlyQM=;
    b=PGrCQh+2wQ1BTLdvtuarmHts6ELoZpQJ9t8u3YJEsHdh5iFo+sLKchkHI6Ea/y5b/c
    kRM7n6GjyNXkgFK38YDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZmceh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:48 +0100
Subject: [PATCH v6 7/8] can: isotp: reject socket options while a transfer
 is active
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
Message-Id: <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Sashiko <sashiko-bot@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=2173;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cxyYakm5ZEMOP7CKuBNKfupIG+xrxlaWjg5iLUXm6Pw=;
 b=BxYI0fmfzoNdf1nsfPP7WK9MDq4rYIDpnoRU2dlK05/F7t4trIngkp8ok7dn7TwwQA/qyaS6O
 YYcEvpRtgboBT3q33XACceKsew3eUvTz5Kf3TMLuzI850Tc2hAC7raW
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_setsockopt_locked() only checks so->bound before it changes the
CAN_ISOTP socket options. When the bound CAN device is unregistered,
isotp_notify() clears so->bound, but a transmission or reception that
is already in progress is not stopped and may still be draining.

isotp_sendmsg() claims so->tx.state and rechecks so->bound. After that
it can block in sock_alloc_send_skb(), while the device is unregistered
and so->bound is cleared. A concurrent setsockopt() can then change
so->opt, so->ll and so->tx.ll_dl, before isotp_sendmsg() reads so->ll.mtu
and so->tx.ll_dl again to build the CAN frame for the skb that has been
allocated with the former so->ll.mtu.

isotp_bind() already rejects a new binding while so->tx.state or
so->rx.state are not ISOTP_IDLE for the same reason. Add this check to
isotp_setsockopt_locked() and return -EAGAIN, so the socket options can
only be changed when no transfer is active. As the transmission and
the reception always end by their timeouts at the latest, this state
is only temporary.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0293d590186c..32c88749d75e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1723,10 +1723,18 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 	int ret = 0;
 
 	if (so->bound)
 		return -EISCONN;
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
+	 * socket options, see isotp_bind().
+	 */
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
+		return -EAGAIN;
+
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		memcpy(&so->opt, val, sizeof(so->opt));
 
 		/* no separate rx_ext_address is given => use ext_address */

-- 
2.53.0

