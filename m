Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429730;
	b=civNlCz8+nNrsqUjk75G3VcwtLfQ1cAU1VN6VVsaMNAzAz5bK3zJeeLUUnSBXrG0nhfb
	 dNO7REIDrttajMYE9LuolwE1r3/6GT9kItrQaJNvOM2Ar7uzLr0IcOXF3moiM8QdfdVRI
	 nrfEoYCKu0KinDPEECJOmYJWwbhPtD3ScLq7isZWitP5iNd8HS1a+cyAJzZaU5EYa5EjY
	 K+PIYsP03oNk4Bwlm61DVmJzNRuXrl8i1p9cYqEGyU919r5a0U5K6UYuw3EW+xJvQGbNa
	 FL+pqhybLRyCrRnzE7zOVYVjLHW4uoyU9kgcu/63DqqHZmxq5/Q6phzBF7ruIsKSrJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wbIi++T5I/EY7npkGc0X2Wvuhoby9O/RDkzRPOSp+tc=;
	b=Pc1atayp5hv842GV0TbiWiZ1O7+OLNXsqsF7o33SgGjZv72S9yPWhTzRGXe7HyiM9adB
	 nftr7c7RvxKuk9SHECPrf7z2CiFEE98/OnLDgsfE6kYP0ccAy1e5dXxeI+0KhnyQZPPBf
	 qQf/1cfVvAVAA3dDmdDvKy3gzuA2tGf3mP9Q6MSXTQoOQI0ZxCcbuJ+FAoQeiLQg4Sesw
	 TNqKpqEzmjBTrmekj6Pwcd+JNu0ib8I88LizSOodwXHXrLWtNrJBVBzhKVi/X5Q07BLnd
	 qC5SEj46S4soio0CKq7+B0gct4ncILuIHB4VengyDN2mGKsGbLyHrPRa5bebmnLZ8bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eBLMQuCx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DA606A31C;
	Mon, 19 Oct 2026 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eBLMQuCx
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DD1F9202852;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbIi++T5I/EY7npkGc0X2Wvuhoby9O/RDkzRPOSp+tc=;
	b=eBLMQuCxaSG4u28kbg3Z7QajzD876uI/gAHmHPlwjnxcJ4Dwru7QKU2cakueEBUCh7unmD
	+rD7AuIMYMZ4/yuHGjyDAj6zEG7P+qjpcy+Bs2SfxzurwaD5w5AZus3+Q7dKLZCne0wLNV
	uQLW8d4k/UE17SeP6Ql7LB7wMt2BB9C9xfMcnIaF7ywyiWvhjI85wDz9LPC+ci4LDw/gaH
	f8mxPSeNx0gpMiIQZCqwRzRVKvZDGqraysj1/6cG32TNH9wDS+s9QHildW7EaTU57qrE7/
	CDYE2/yrO+9VrNj0f6sXxGvL1ONjucCRncjqB89NxmiGPPWEcnFu8KwuW4HVbg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429716; a=rsa-sha256;
	cv=none;
	b=U0hQknE8MeBU2xjfWqul7jh8YcvCWs4fHk3iHiAK8g+dc7HdW3/fkULyLu+z5Og56Ae9Kx
	JsCbKiUFGhpM8L1wtRg3N0SiYl/qha3I3vnq62V7vrDQr+9mXTez3FaRK4s4b/e0F27GY1
	vO+lWD105DjLujcj/13fZo4VGqvuJhLFGiK+cGQUqa7EUxqHBSFROXvLiw6pNLMAh81vFM
	AbEoIJk/HC9+vM45/2AqLMeS6WP1U8WrEYQkb8mXHF6xK1q1+qT6EmLEGum4qlXiqYcU+2
	DWQkUvOvYjlahQnTdFQdrNafwbo1iYL2RKAmXlMtNLRnvqdxVjHdL/SqAUCAiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbIi++T5I/EY7npkGc0X2Wvuhoby9O/RDkzRPOSp+tc=;
	b=fbg2yY2Pm1UVQpFmN3n8/9+inPhLXwO9cK3O+gxA0/tFzNmMdiLQ0DgRkz7UKRCJ5RwbtJ
	a1LNk2aDJEs7PQkZy8RfF85l5VEpkz4vt8aWBIi2aahikvGEhUXdLz6zpl764Q7A9H2uDs
	I49gY3/pePDR8lBZf4RfynFAyZlK2rf9MwJxRnjzTBIPRPBeI0yoEz4lXRvDmGeTsMdKsM
	7Faudxcvj+uoBz8g5DLNdgRjGuwrnyoJiY3KbU6JvUMBSCrU4tnMoggkH93gl6WsSMvOqZ
	UhKC2QP4+TDhpiX+gL5A/LVFc5d6qdjTGDrysqsEuqX4CRQHo9YfYW2CyNoRBA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000FgB-2T;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BA795C948D;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/11] can: skb: make echo skb freeing safe in any IRQ context
Date: Mon, 19 Oct 2026 19:01:08 +0200
Message-ID: <20261019170834.1727150-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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

