Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624301;
	b=5nUtJPIrT/erokNWLB3zq/Ekv4ANWO5JMGO/0kjTY2RNEvMSOq0AU63cYYUeDnpdzO5R
	 I9AunprIoCNHMvbof8zykuU2JJLXymEUws7WYeDdaqRZWYmK4L/HDCiEzrDTs4BK8xWTK
	 /lSnNJhssM7H5vLHYYZBrXPOfQvNMI0N6KgTADcb9gLlncwqValOAM2dv9huJYHInRtkd
	 3/AsZS+RW2XPSAbNaCB9M9ynszwh0TVkP7BLiEHGF/2itFpPQ3KKT7bXzI0NCHgTN7QJ1
	 +w8suv4xTBj0wXki4LNgoyjospWEiep59On4JXWQ4idfC3tkyC0fRhnOBVMxOYGMIZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=3ahFLmhyisadyTvdRtIry1IavsGN73qi38r+Uh7P077zPare/yI2Wdfj5RjBVejoM2f0
	 CZYa+kCvnvV1uyYYCbLtWBSflwJ3YHENfAL0nTS9zdTXfMJtqX6H5oqiDaSUS3OD58nSf
	 QsVHaaDT75Lm/KPf5NZBZo+v+hHEXyBlbaN4rRU6oDdC8ggJrVxR+sbWtS8PMAzR4PDuO
	 Qx48XxGTOj0aTwAjsoLM04DjbD7Yu3lkWwvL5E/bTCFm75ahsKyeLWIrN/pJebBVkqAv6
	 Wpj2SkFJju+X5QgC+B2MzKxLZlOSzlIyH4QZUPQQ601AzR+BMYSbNhgYnM2m2hPhcpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YEDoOYyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D5606A31E;
	Wed, 21 Oct 2026 23:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7D5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YEDoOYyt
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 264E7201E05;
	Thu, 22 Oct 2026 01:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=YEDoOYytV41cwgGykQ5U8ao/HJrMYLR1Rl6nSisNe65S/rdIZbnYjUr3CSFVbpqA9qrDlv
	jBj6DsXsVVxadnYsjdLUeKcdtLE99rzkJgNnQmFPVCR42MTkM8LU1Ko+5RLfStkf37tJ8z
	butalDURb1ecH8hBrQ58j0YNs1FBchGavTHijYOJHnZ/z24gTgAckdBVYXVe9hcSXmHjgO
	/bhrXZ3UDYmo53BjWwsWdOxiN7uKo3bV4FZJ9o4azuxsjM8gZrwvcFdRzMLcEnsasNWM9B
	ID5DtuZxGjp9STP30P4HdLs7kH619UFM/uxRXo02BSqk7ozoR4B7XsfUe2hXKQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624295; a=rsa-sha256;
	cv=none;
	b=Uqwt0k2oFaTJrIwXq+oz2yBIZGYm9D5LvKO8nE02yB1Jk8SVeLoxXGLySLhiVDbJPCBJjI
	l2/muItCWu1ucv/xvwc2I+PKPPCYUZ11jILQO0nXZOnYQ8PAjmILCxL5NVMSvIqKKN9375
	NRZ+gThwqKaDtHe3pI1a5uG/qq8hNbixQUes+L8RDdQJxhKfn+zZQbqwJ77v8I1B0fX7hO
	hFKtSC43HZAkxbbuSz4t2pvf2Itv94bS10SC7PDfpXivb0gBV8ezifatdsgMu/8DMqTVEj
	/aacfNSveSb6Ro2pYlh6lco/6+4sjEtY3Pj20czbLr9mk8cNRlJmg3wqmvbOxg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=af/AclNh/LkbyxnvKGs4fp4uM9SVumKgvd6wIRYPmfCI5HvgimgvrfH22x7zsNhG84aYJ5
	yn88mjx500/CmXIoTo9ON18XWK1qZ9bjnXGxIu1xGvMfXd1p8ygSUvjbRvxrW4hdq04CS1
	x+jFg6nvmwuqbCOO/X8WUIC7de6BHvWlsly0AmP38p2o1HV614fuUvMyBfhv4DX5jX4gpd
	c1ySv+9c6KUR5tUtzhk/K0YJx5mwBIzn8U6HmoI8wpIJzJx4eDD1mVLNITBlPQyxxTE3bT
	Z8CfggiYQ6G3LoIfdM3J1hw7rjhmk+SoP2qpFp3cE5cym5eemv097F8pT9AGow==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT5-000cWH-05;
	Thu, 22 Oct 2026 01:11:35 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 754785D06D9;
	Wed, 21 Oct 2026 23:11:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/11] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Thu, 22 Oct 2026 01:07:51 +0200
Message-ID: <20261021231130.2085690-5-mkl@pengutronix.de>
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

The CAN skb allocation helpers are used from hardware interrupt receive
handlers. If can_skb_ext_add() fails, they release the newly allocated skb
with kfree_skb(), which is not safe in hardware interrupt context.

Use dev_kfree_skb_any() for the allocation failure paths in
alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb().

Fixes: 96ea3a1e2d31 ("can: add CAN skb extension infrastructure")
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_C825C17D442F801351CE2FBC4984064B4605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 46c151eece8f..3e36c0368bae 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -228,7 +228,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_cc;
 	}
 
@@ -259,7 +259,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_fd;
 	}
 
@@ -297,7 +297,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_xl;
 	}
 
-- 
2.53.0

