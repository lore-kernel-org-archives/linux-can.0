Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792578482;
	b=QwT6KPgTJmh4TGn31712Vuhpv35dCqOUsl2Q10Tw/eqUIFwJ8zwu65lU/iu4aWqkUumI
	 viu9KW457Wg1bEVa+SdZ9svop/rwCUuDHX1Ff3K6N+Zlkqf5KzZAzdBG4brBhAvXVccy1
	 SHIELA+oUFN24/IysbQMYVzZLcgscKy1IOBXi14HhlN/iuq32BWdAH4j89zWvO2yDxcmH
	 la1GF5j5ZGkKFskhqrTp1j05bee2lJlfJSYUMfIE26AcR6bJ1ck/X2fFSrE6vdXGMB/iX
	 hrt2TKwaxYO3Bg0yBuSj8nLX67qDOgZ9aWvsqWKHHeaLMnyOiC0TbvDxmjrBsItC3OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=4CejPjllyG/X8sSEdZmot0qSI8xkTTb2m13ugQJSHAh3ZSrPiq85UtlMFwTcRYCymfL0
	 OGuQAhpdcig0drncqFd16I1ySsW8N/6UJB6rfL+3VPU2CFISN6LJq8e02KbzT4vFBr3S9
	 SCz9vWpaKam2u6lffPOKBNH4XmiBCEmyWBsCe2/Ietvs9xBucdfnRM4kcDK/EyY3vltrL
	 s9CIht4omiFuGeNbId/DkvF2+Ne3gjh1BiyTtZ1smN441LHxJdM/W6j/+y7lGfvgpDjCO
	 GKR7BEb0Orgp/BlHzV32i4UOWfA3zaW7SZFkGGj0+H84/K+29zf9D2fbIX/NPBbVTSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KYIL244a;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FF606A320;
	Wed, 21 Oct 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4FF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KYIL244a
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4FFCB20291D;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=KYIL244aWfLc/Fygra/QGCll/lB1dXJfLot6+SVY13TeucGeWF+/UxK8femBcbO8CytUTQ
	mCWBsbUFjp1JzQIrpwls9LCIHuY09gjZi/nCb+fjoDtqqUXUH15W6W2R5158Vr9bCyoHk8
	TiZhOxRodbQuB64Fgq7cW7VqT8MAnmddutsqg37fvH2PN1rGH7d3uFNfk0mDrJ97qSgv7o
	WoSnqTU6vtnU1wbgNCHkJ6uMs1ywSvD3Kfs2b7FnNPjGnFjYniKOXCdgrSQ/9hVOMwXJmO
	bppRyQcBxIwy2gWbpUkNiM7YXt+6hcwr76EtpMz7AIX9cO7sj9QUef7XoGzM0Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=GQ8Hxcd7jNEZeBnejQEEi/zjbzS/l+ooHt3mzE+Cf9MXlva6ks4iIRNBaxlFal4CQQYQp/
	eBLXy+9q87Tugsg8NA/to6ZmcS446f/bMo2Au3364d03Ccl0rJbAEqfMHZMS7j2z+aYvTg
	J6DuYmwXm+ZfAEvd4ZV4rfLC5B8UPI+bWKyONc7i6TjxK01vvXJcUu80O7fyfnZXUE5w6+
	mc78JtCUHdsFIdprK3ROUn7FUE9pItSBmvCvykBAC8JIwKAW8PBUROE369MUj+Z3zRgxRH
	Tr+23d+JvnLKjIRizjYVpROgv9HYEXO3ioARs7ZdK0CXQMLxZU/pFJa7y6tvpA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlrfPzT5jQTLXkKxox6WIsAY0BepfJdkXAFH0ccIzwY=;
	b=AFCjUBwl9459eD3DfbEzJlSMLpLaSrYJGV0y+DlscA6lobfddRrAJQOKJVV8c+5cT++TBj
	6pSZyDIsEzrb7lkGBFRM8oELSIr9TgKvit/PjjeboqePC47vFpJCXaAZNI4NXjvnJKdsnN
	rQ4k/lY4u/yoNxerxz2UoBIBx422CH01K0GDMY0ndipMx1A9ct0VNhonQZDM/MtpcVchxc
	FNB7NzcINrh5OPzTuHJKxpeleoo3AytY52cWiKAuykiDLd6lyp+PTEybMcS+hFN1t+4SEA
	VQXo2Pcdwp3tPMS2Kic8Hf9njJ9bBANHI7Zl6en3JBD64MJWYuXZ1WLBiR1g4w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjg-0h;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC0015CAFD9;
	Wed, 21 Oct 2026 10:27:58 +0000 (UTC)
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
Date: Wed, 21 Oct 2026 12:24:33 +0200
Message-ID: <20261021102756.1900679-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
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

