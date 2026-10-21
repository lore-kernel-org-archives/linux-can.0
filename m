Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578482;
	b=lFic0HvRouV7qLSiP1l9h4zCVh9AYtOtYf5i97bVAhGYEbeynnUlCX9awoMxGp/RbYrU
	 oIX8+QKU+2vhcLjFTjuEce1+l5+01Z01MBdzweZmgUMCc+6K29ADJnBQ0N8Ri0hAFZYdH
	 3kfSPUGrNRWoK20iUYNa5vWku3/cHqY5fp34z0VHz4fKI3tdUrAF5xcgFn5psiaPBz+Yi
	 pmoWxZXsyzHyzAqVUwpmlQTvK74fRvHiY/de1WHBkOLxpAEDvKxUPdKfH+MBpOXADa56m
	 6FfEymrQo6J5J+OjanIVuIv3cjS2/WQGOAMiapUTV/scplSV069eh2LD5qZ/FGZJ+Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=xEpx4Pj2JwCg98HidVlO86oSU3egP0yZNF0Z8V+THaI9+RUBq5cKR0zeb+EmFXBKCmq9
	 LC6TmN+PTB12glBGJJ5fqmt41czDtheCeucg9CtuLWnmf2h9rF6tXAtYtfOPfgpN8pris
	 I8gqOxq+XZSUM6dHBO/WTDXq+8Q/hX7mLvFRrUTd24iHmMyZyWlaAdz0zx1IKFnPYYDhr
	 PcRDD0XOKJxbXdXVT60E+ABiG2zlTHue18KCuvVtiWjv89thjB49NHTMQhL8RdDe414qC
	 eNBWA27GBxwXBXcqhxgIEO8zs/K6VJDYpMmZp77Gtnaa33cORQYHiNtVk/GqkCvgVOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FLIi7scX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6C606A31D;
	Wed, 21 Oct 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B6C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FLIi7scX
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6FA25202920;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=FLIi7scXbjUCNrr1rXRAiZXegvtXF3L06DfcP9gShJrJKeAd8IFqLdbvv+UZxr0yFPzHb6
	Q+8MUuPElmInwhqyjghz6T4/A7+wagxYdR3ZZhfSsiPXwe8GPLvry2NrrzkWInUf3I02Vk
	jraWUi2Mq47g/2MOdQq4COF1MJI9q2bo/qXw2gqh7GbqXXF/wpZ+JUvp0nrxlCaghpB01U
	SMKn1BQpa35iv4DyD+DIuCqJeZuKqqwtAMVhjb9/4VBcHfXcdHegj6b/f7nFlkei0Nqi5h
	rRLu3VKxhB5I+/NSxW3bFnl+Mzek9oqL2zmw3HtQnBsBxBDddf8u5TBNTR6suw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=dIi9UThYxDESj5pfkwO6XzAe3POjuWvWEISrgH/osaTKfezBJM3ybPMr2oYk3GxiiKU+q+
	M9ixjLBJEknkSK73/3EhdErh4SnCg4xVTfC1XQoLPgOLzc2ymOE0VMFSc5Kt3fEn3OQiD9
	320I1RjP1GU5/CnWZb9uX8NIWatEzNG5ETOe9BWOEixoxaBiUGGbI8ZXh14cYcjuFFZu+h
	zBAm7lYI07rbnYEpdKui9GMTfKQIrZKZODF6L6TJ5pjcv+9wT49lHWw0782U9JAZwFM36X
	OI2hlq0Bx62TaFVNNZNOHpYj0KPUjlAA3TFPUkwoN0Z/CRh+5dnZUg1LHrkPqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=eYam4mpIWUcVD81W0DmU1QPF+87x/76G+fXr2avzUGBGLl69WiKDf0xv06FJkFm8v207/a
	bbrx0lsnkXL/BHVTJsW9nEuHuQcfN2lusndPjeuh95AiuQOj0WU6WYFbkwPQobGNe/FJrh
	Qc9WHBExvh47CWSFYjLhA5E189oe9k7cSKrElUQz3+TXH5qmI57917sqJs6swuZgAlh0NG
	H9bTtRtZT0ttHWcc+HGqof5fhUcnNtaOUfabSEI9U4a6+ZxmQE8+7ecs+BXzMu17Z09fSm
	Fnk94ZbIx9qILJEXeH1vESiR6HNGAlVYiKim0WLiMvapTFlR7ip3iYqh73XChQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjk-17;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0F1075CAFDB;
	Wed, 21 Oct 2026 10:27:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/11] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Wed, 21 Oct 2026 12:24:35 +0200
Message-ID: <20261021102756.1900679-5-mkl@pengutronix.de>
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

