Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738600;
	b=RZES1TsoFWQL6q8nhevYuv00xIjxyUtg6zOLmVw/UcmhMrOrvkA2gbyKWgash8P4W0E9
	 7SPALbcVbq4/QzbcihndJZO2uNWBLx3DSLHXEiobBhLrp0TcIVvIpWieFH8OUjd1C19Va
	 zjzkhgShw73NsxAXlU2FovTCGIzdmcaUswvVio3ml/4cdMRkZXDe5RSiNp5g4c4KTcAvw
	 eyFtePNpFxqqdWW+HMu5DevLzL5Nxpusqj538A/+qo8C/yEgMgMprmtcl+3A5IIV6NUNE
	 FcIAbhCUzrZqrSUJHr5SMJlhOSI32mft6Cg8WLRG21qRVc4Jugco3+bIUN/mqOi3hjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=Lh34ztPxq6EWkrmMCRot21M3dDou0d6vbS+Kv5uYZm2WyH43VHJurZ8AHeL6Z7plkl4p
	 e0R800LZsJE6PfUVtrpo+S5qGB2fB94q12x2GmAneuomP2KDaeeLzzk4wH5RurL9vx9PJ
	 K42ceKMCNErqsyJ/Ep0N/7w7ubIVcYshYtlxRtqUZQue8fxoRvBk+p8NiKx4XU3DPQ+/N
	 HRbAWPm4xuIPAIxPZ1W2/T1NNdwzyb6yIQ5jU96W5TH+RudzxBButcwvRi3VJZC+yp27g
	 uPUGNDZetcIRwpo3j0aZPvEB7xPbL6B50nFK/fwptttAP3jAzsg4AMKM4Df9aB2nlUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=URs2o7qC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70C606A330;
	Tue,  3 Nov 2026 20:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F70C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=URs2o7qC
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DFAA7201BAB;
	Tue, 03 Nov 2026 21:43:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=URs2o7qCuzxoVzokgJq182oaU0spHcyoXQjaGWwACFgXGcyWtx3S5JXR2awzimcz43A7Hp
	F4qjRz5qksPSIIb9JefQqZL/FLmAMmqi8J15Yx3bNlbH6KbxhtSsYAPS6YH0n89TtWNm59
	dS4QXQmPk3hGpf137rSkn3ZmgLzTU8FehxT2PsTNtqUrjABSNWUMRvasSTN6fuFqhPQpPO
	o0FoWWB01Bv78GpijlLVZB4mX64yxmpTpNrA90rIgbDQ/AbQ19evmVhWzduus4fp4M1+b1
	z9IDm+HrvC7oQigIXMrCkBSgYOKhNVaFpQ7SgwzgioXi4AeoClgFs8GMyXMH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=VmWG9Mtr61bKjG2z2R/JgfpqfGv/wC535JSavUEBz+SU7HFJKOtq2QkZS55apLH83NBzvE
	eBBmuiDQ5/OQlZVHqykjBaaoMgq6i4XxZvZYacbsefpFgNgPXq+aRQ9mWH//cOfOnS26G2
	C1Gop+qT0aK89mMweK/TGZMlgznZkmgjbpL2oD7+Edv42rI23chp2pKDVtqWRh9FM/w5QE
	6Sufr5kOuAuuzYduIt2Knzvzq5C5f7l4ywMmkgBbxZ3LN4XkWR/9sSv0Uq3Hi1vlIy9x+O
	LzwEvF8odYYv9r2ogpSrkDMbUY4Je9ww6Ba4697sk6vkpzuF95YgGw5IsaCCcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738593; a=rsa-sha256;
	cv=none;
	b=DO425sJobCvFHecIK4ZoVyCU3VlZiFbyX7BQWTF0CeS9rCFy9J5YXZFZVKPnF4N0F0+Ihq
	jk1BIR8YPU4CNEJ3lFx2lIAl2U21HqOee21ah3NJ6SE6FTOut0Ets9IBrTum0kwJPQban+
	mVFoHg2TpWd1+KLA4r4PkyoEwJX8cWOO4xvN6PD7WprJ84C95pDwxO3ulRnebLDOCRkz2K
	bsnrqNDy4FkRaVYm0uvIs0Ar9wuP/R1u4GW//3Qiwe1NXAy+dHm8bGrFg3rw8PCM8fkR/O
	4drqqFqw+Z6bmPnwqugtrGo5uXNL3bEvvk9CZ8BGA2n4GGPdjwCtaPo9jfRfZQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLd-002V8M-2V;
	Tue, 03 Nov 2026 21:43:13 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 792DC5DDEBA;
	Tue, 03 Nov 2026 20:43:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/15] can: skb: make echo skb freeing safe in any IRQ context
Date: Tue,  3 Nov 2026 21:30:24 +0100
Message-ID: <20261103204305.3211144-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() can be called with hardware interrupts disabled. Its
direct drop paths use kfree_skb(), while can_create_echo_skb() uses
kfree_skb() when cloning fails and consume_skb() after a successful clone.
None of these helpers is safe in every IRQ context.

Use dev_kfree_skb_any() for all drop paths and dev_consume_skb_any() when
consuming a successfully cloned skb. This preserves the respective skb drop
and consumed semantics regardless of the caller IRQ context.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com
Cc: stable@kernel.org
Fixes: ae64438be192 ("can: dev: fix skb drop check")
Fixes: 0ae89beb283a ("can: add destructor for self generated skbs")
Fixes: 3ccd4c6167d3 ("can: Unify droping of invalid tx skbs and netdev stats")
Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
[mkl: also convert can_dropped_invalid_skb(), can_dev_dropped_skb()]
[mkl: add stable on Cc + add Fixes tags]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: What about the comment in drivers/net/can/virtio_can.c
   virtio_can_start_xmit()? The error handling for virtqueue_add_sgs()
   mentions that can_put_echo_skb() consumes the skb via consume_skb().

A: The comment in virtio_can.c will be updated in a separate series, to
   ease backporting of this patch.

[mkl: add FAQ section]
---
 drivers/net/can/dev/skb.c | 6 +++---
 include/linux/can/dev.h   | 2 +-
 include/linux/can/skb.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index bc0787535b52..46c151eece8f 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -63,7 +63,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD) &&
 	     skb->protocol != htons(ETH_P_CANXL))) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return 0;
 	}
 
@@ -91,7 +91,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
 		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return -EBUSY;
 	}
 
@@ -403,7 +403,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 	return false;
 
 inval_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571..346faddee02e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -176,7 +176,7 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 5d27843862fc..87ace09c0d8b 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -78,12 +78,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (unlikely(!nskb)) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
 	can_skb_set_owner(nskb, skb->sk);
-	consume_skb(skb);
+	dev_consume_skb_any(skb);
 	return nskb;
 }
 
-- 
2.53.0

