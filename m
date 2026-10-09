Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F04364949;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553419; cv=pass; b=rX3NcM8neWsfe26cjdAqwwR295mDfi/SDcsEMmkKvN+2EplcUjL530KHajvD0QJj0GlTxfNBNIN3ab3fxhKSwxg44j1BOfffzRoQuP3rYYRBjY801KUZV74ZW6aBVAEAfbLGRKCgur560N3aFrDG6rGdkJrkj8IfXJhiyRxVty8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553419; c=relaxed/simple;
	bh=sFiy1qfhumLK4uWzPt/3LOQEc18konFIxAyBF/XLK+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOYV2lm5mgosLf+ncftlrbByf4Y1AVMwUvbRfnXpjW3cizfWa5P0AmQh74xZBqSyp5ttotQ4avkyMVHob1En1uAPqySuhCOpD+YYplR0HEAr+A0fk7ZtIwljwjwjUkYG7rPAuMIb6dR7A7oJw98UkOF0FrB1EW0zaAPri8hIDEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Ma1AIBOS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Ma1AIBOS"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7593120261F;
	Fri, 09 Oct 2026 15:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtAEIFtkl1+1S1oO5IpfaZTGUQN3NgM9Hbtv/PYjQY0=;
	b=Ma1AIBOSazOKbNx3yG8shXIC+Gck4Hlc7Wd0zGcFTrvD9AYjy+lfcH81C6d0rjaGk4wY17
	GUPUvwBs0lSAahYlfXjqDMQj6YWlujYCgMzPWMvgmQvZrjPkX0GE//bLfCdg1KyH7ejyKz
	z7FYBa58kThqgJ5r8Av09DK77pjsNMLeqMl134EhpgdHzA1JdF+9wwQs14kcv1cS7KEP5A
	UypEyBuC8SxrGkJSP9zpw1yLmq9g1ov8pBMZ3qYUzee3L9v6Tw8orje6uAhHxPUwwlZTD8
	XlTEYTqseTow39+VIYsPCFl3n9ClYJ0C7mpwCK/vijIPywH2y7L3N5opZx07wg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553414; a=rsa-sha256;
	cv=none;
	b=dHnk0QBa/8kQ99abrkB/dCvua8UjYrMG0LwGq+vVUN6YkIuWVemsjeaRwaQNB9id7d2Zn2
	h2fY85pQcEShZlwRdeO8PG2oRHuLh8UiA5nWWj6GyZP9jHr9lGaPnReR35Ia0CB73EUhnw
	00FvsREOQhjlicvdso5UuFEc1f6Xv7krqLy31wGgYwCzItct3S0LcCOmHRvLZDLZUyAsxi
	u9BtNabkmi5wFX15kxnDiAVr0yliSGWVH54l2mtb/qaFNfzlRxT8PTniLHPqWpa5ty0k2V
	EAw2mKQ/0DK2W6/BXBZEsP695pP6w+/IZ5cCZMeVCIpMceY3xPz84KJFYp5LrQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtAEIFtkl1+1S1oO5IpfaZTGUQN3NgM9Hbtv/PYjQY0=;
	b=bJtR3+qLwnCWDfAS0DJtfJ0v69pm7Xxr4aMCQVtc4/BgGkxcCUzzz75Cd4fFSstH6ZOrXJ
	HnzSuTA65HKJMcUt8BFoQku8n88CC1png51pgHgzcgAO+XrRWOn4tSQmJiauC8kDmKuTkn
	jeoaBN1Pj/8J6I2ATFKbPmJdD8Uyf1VsBQypRfI7N5jdReFwSpMBDOlu5GYxsyjLFnI9tX
	VfwPsXG9gU/9kZlRGfYElKgoJJ70bPHVoSwiiQKkpDwNR0hZxNaGv7mcrxdLtdujLiK6le
	qf6uwbGbD1Tu6SkuZwT2WaPcfKOVrbwi7RdvBzq3ymD7U6pvdqcfma+D33qpMw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAso-0053S9-1E;
	Fri, 09 Oct 2026 15:43:34 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C1A085BD8AC;
	Fri, 09 Oct 2026 13:43:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/37] can: skb: make echo skb freeing safe in any IRQ context
Date: Fri,  9 Oct 2026 15:27:42 +0200
Message-ID: <20261009134323.64064-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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
[mkl: also convert can_dropped_invalid_skb(), can_dev_dropped_skb()]
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

