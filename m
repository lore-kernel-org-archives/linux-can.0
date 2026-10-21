Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624301;
	b=eRZd/GfhbV77Dizbk7RAaIpNvddYzmZpV9D/FW0ZV0CuCkVUgy34YYT5/QhZBpFydp5J
	 j35Zw8AGKWoaQvw1iqrloNydAgSKaRZrhp5Ib3wMoKJAXGlDbvHpIIJKmUDax3pG3EFD0
	 MltDvTIz+Vgh/WpNEOXbqrYXiLtzAQpHFVJV48lFKqD49fOqAKpnSCeYJLrk6AZ7cBO6W
	 Bo5it6lCkM++oCtX5fDu3zNrbEcbHmA1IOfHz5o2kBb8e1At8Z+fczOe/sYYTLtnVwsF1
	 RmE3zlFHvOdVL5bvX1ufYxIa9Z71TxO2XZhgoM5y2QVcjGge+NW+gN6zS/razpNJhdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=EB4KT0D/LlpmqDoibbRixm2sZiHMXgjar76I21FtH63vEkBDsIqYYPxsQ9otdj18li46
	 u45VE4BfV+SUoYeWL69d0qLp6XZKdYz/MJWEpUwgBLojxIJYyXYWCo9oy1cDErm4U0dBK
	 3xANdB7+mAeVQxyIjEayMFgNbLD1YNhkSryojl2/8+3QLn8gBDoM1jrGQbUmvtPdS91bi
	 uu4OWx/IWU7Z5UbI8A3WLENPz0Vf2W6eJFpnGEXJv21qpTmqrLjkkkckamq/fKZVl/ZWN
	 zZQ/YIaOQ+GQaE9SpJALMkQYiaWxh1syi5l5CbIRnjtmN+WTNo5JITpa3p69qn/22KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eAcaOeF1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0E606A31B;
	Wed, 21 Oct 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A0E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eAcaOeF1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 32EBB2019D1;
	Thu, 22 Oct 2026 01:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=eAcaOeF1c5+ATQNPvQifo6v/Oe/Eid+sOLSNKjaa4DuMV5yzHLcEPwnivPx0D3wx5cGZ2j
	8MWZOfsg5Mm9V/zGM9UR2Rm9HYjaqtawNwBr3pVY2qdWiPOlSb+7ZjTiXXuNhst4ZluKim
	7GwaO3AegSNpFNctu8OEsUNg8obgPea471RbcReprBZyH79QXVRafAsdcbvegdsy0Nkm8/
	4esa6kQS7ZM9C3YsyH6LVo83AMZP2IlV9Mnb2sotwrqmmfKXKTXTaA4DlyRG4iZxmvm6W7
	odzVDZRYZ651WIl6D0nvaxiWlCHzd3OY/Dx/S5afDb7j/vycVRcllOjoSdexzQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624294; a=rsa-sha256;
	cv=none;
	b=a7j0/BexBzgQNj8nabxcvltUbGkN4clYhyddKEHykZPxXfNgRgTTVXv7JQIFRrnISYz+Ct
	OgGbX1pcN10mEXNixzKL0/JTqSXF88bLfZoHS3hsxcFV8hxJpN/QoBFhvMeuD8zEJ0TQPZ
	AiSENFQdQAqWvYE6k4CQnhmlt38lD0HgsOH82eos+9AOP2HaTBlulyVV0UIUxMQQH3rqsV
	uADzjXaXmuMpoHIoKfp5HTTE0nga0IlkYVZ/jLGiG1ljEVBa6zVLy2goMRcmGdeBDEONmg
	ITdYtTHPhdqoBuHVcKdPWPdM/7dp298ZXWXvamZCIa6PZhohxw5+jp9Bm1532w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=R7Ju4Mn3Gi8vvDCm7ADmQ1cfOB28uQjgv7rdhTeVdT2eJQFKb9mouRRmQ96BM2+SpGlTiA
	MzEA7BUedk5TFb7RhDLv46swppnnE3X4FQcHIuAjKJTTwuI169foJICQ68OURz8U0AD5OF
	YoIb84k8KX1mv6Qtx6s6CktsbxxlaiYW6oqkcFUn4d4HuBADKIyisJTTahScwk/Pmh++Xu
	F6WQZ5w52dMQydc5CinOTBpOS56yIxI1M0JUjaFTU/AqHmojLxi4HbWboIrDIPt4D7pGVt
	owYgpOdVcQAZO/jE45UC7AJctQI3QTU0Bort1JgThreXpoVHfnb0Ty3q5UcJ3A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT4-000cWB-0F;
	Thu, 22 Oct 2026 01:11:34 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 775DE5D06D7;
	Wed, 21 Oct 2026 23:11:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/11] can: skb: make echo skb freeing safe in any IRQ context
Date: Thu, 22 Oct 2026 01:07:49 +0200
Message-ID: <20261021231130.2085690-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
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

