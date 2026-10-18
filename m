Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DB3E866B;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341868; cv=pass; b=qrMmmwtkx7Ee3wXp8d3hkyXT9L7tG0E/6a7vqc/ykAiDmSlwIr4o/yDWIuNGAleXXfTzu7q5NM/VJuJjmvqf42DYeitC8fnTm6NOYSGk/MFU7uDvkp8reB6pyzLfqTbJlD/TW2f5kGdiP+mkzOGTVhkqpcheDj+DWT1VXG2sNHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341868; c=relaxed/simple;
	bh=+sM9ccq50e+3+kR7xjiU7QETQCeo8ekvYMhdPmxCWtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2TyKC0m5gwRp6vmKmNTb0RrfCElmdBLn2fgNHYgn3xpZTuESA95xPirNYFtauXq3UItC74YCLs10wMB8NDv61cA0fsQJd2wnE5B9jkDwcYVCMnOhm9hEB+XfrbMOBHo/H7zmYcQMl778kFkZYcexgdJ9D8NiUJLQGZGrmrjb4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gfAMr0LY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gfAMr0LY"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6AC7A20283D;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbIi++T5I/EY7npkGc0X2Wvuhoby9O/RDkzRPOSp+tc=;
	b=gfAMr0LYKWGS5jygws9WST3wY3K8XDZE30rcucboks1cCHWPJbpXmpMuOxOxBVjoOSqN4m
	UGkPeYZGsDRusjWejRsoF4/QRmd7swKi9JYxhSoCGjhrpNeiX5aupiFsmLBO3TGbakNU2V
	4xXwvp0i9iqPnvf6xIBxhueSjnx+Uh5VCADCxpdpKISwvAO7S6lKK9PCQOgsVuqAylnZXS
	hd/FvFmzyEFtauDxAUjYKCcv+nHP9MR3k9rdL3WQrmD15gAKgRq5vA2IHWbWRZNByU094D
	73vAFda0IptOaNjqW9w5dnftP+u1xv1wWjusLo7m3UqbdSgoHChMV4lSKsCmLQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=fr66DhWdW/nNls3G2QCqYsXTFE6GcDppNYQHtU3+vSKFWJKGjNI/XpLu8QMe7Azl++X59+
	xeXoMeBfFnsktlQ6hecgkuIZdfofWYARcIwB9T9DQlYMzXEVSLUGBf8YyggKGIkhIe2ugU
	MdUq0445Xzt84C+JLrM9xvOcChNJV2HE16TnxrkGa07kHfZWV96VKBfYLXhDK+T/+lT/qr
	crBvNAyhTYZ1XwA07/T/9Vt5U4oEb924Tqb+vPzKMG2QBOdFUUXdPCssnyNnnoig+iOQiC
	18KIe5cx6NmAGOpiN97dNGu4vdIA+/mcexSNbOFhWMdXx2OAHSXqD25nkX89tg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbIi++T5I/EY7npkGc0X2Wvuhoby9O/RDkzRPOSp+tc=;
	b=U+z4IHYrjXMhpyuZ6S+Mx3+tdSnXcLQUu85YfWj1i13HQoIWq5IwsS0esCWixb2BRRlkmc
	ZoirSwRyfBgSZ498O9H36ryiRN3TtgIRKnZIK/cKU9Q4Pq1yNv3YuZXzspOaPZOx8zxYN8
	elg5MYGluY/lzxO6hxJmDLjVRFvIEp3GIWMaVQQBVQu2gmpiXgcMnFk7QBRrJE0Hi3Nmk8
	XRGcFIiBqjTc6UvT0pKIYSRnmhaPe7bXrMvTduwMmrBs/KGzdMqhW4QDqgtkLhvp+IkMqJ
	f2es4RMw4RKvbll5T9SobWbwRI6pH9ETR/krGtj0mOcshJjqjF4OwaYf//zegw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006Si-12;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1369E5C7D9A;
	Sun, 18 Oct 2026 16:44:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/12] can: skb: make echo skb freeing safe in any IRQ context
Date: Sun, 18 Oct 2026 18:41:46 +0200
Message-ID: <20261018164417.1540449-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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

