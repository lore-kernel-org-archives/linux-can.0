Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738601;
	b=mZVqxZ0U1h8X4pDGT3ZBCOja2CWgFwOMNMWKXPZoYFZqncW8nNSoHmkXx4d1caRpoLhs
	 AIynFm66ZjaUP12o3CNGQ3p2wP3apvDNQk92bGYbIpuOSFLLdBm/XPzjPujf66VmLSf8v
	 Quhzi/UXtBF610MyiA3Q/42IOfMXJgW3DiPZ88qMQRG/V6X5HnwugtrKj5KbPFSflhq7E
	 WSI9eY1fAwk/BDOSISzaAveIqvfr7gqW1v8moCoaoBYqiseOlahU8zcQ7NoAQDRaWa3s6
	 fav/H+NPq+rYGNY6RxEobGXb1jUqq5O0yguWr0kWVfabOYr72BUpUpIbHTrsvb4ofyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738601;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=Ki9HFzv8Sqo2KyHLqcLKoBs37pCeIhvb/QuNTFUBipUxmurH7vanyvHWYGpM+Adp4Io1
	 d4SaDsqVFgs4IOjqg+NgKo7K2/8Kkj3fFVY7ikXtkLAtbyLxYCFx+JpVcstNrh4XbqGCJ
	 5PZCeMs0b/m3vRVAiAXA6Aoq7bD+zXKVuBOf7+T2kE7VWCclHvCIRtv/we0SVDqtdLy5G
	 bRj32jLJOkv7nmbE1AC0/Qqj6iZVDyV3cpe/AWXgeWH7lvb+iEcUOI4/s2G/rN0SLbi9Y
	 tsmPWVwqlixpKnsUymdhOYWOU1BkCiXJkGtjofDn2l8Cr35ANoWM+/W8GIzh2m0zjcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SCotcY2k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C436606D801;
	Tue,  3 Nov 2026 20:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C436606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SCotcY2k
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DD52C202101;
	Tue, 03 Nov 2026 21:43:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=SCotcY2k5Y6mWJ9JdsKtjJi/ObeUoR1Vf/kST4RhSshacG2749Bl34hvBHpbjCmZOBybik
	GukgPge/OI0uLzCvT4LuTWxKIyI9I5OaqNVGNibmAz1YoerLlmhytUeOy1c1hNfrrVJOdV
	gnG/tvGA0DC+NAMqev9tNlM06grIGvYeluM6OR4+OUhQVZnbWz4tsKYDUIdeqPhGvEPxYR
	mwXFhUXUJZ4HoV7TzSPLM1FWMl3+uPlclx9YpQEjti8O8T8yjDsgC4LGXnzdqGw3v+/d4x
	OOrSs51I8ALta/2Z5gtEmd5QGTc+K1Cz8fIaDEMsZHPu3DJmzeiTpsJXjJTfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=RzHYsT/2QQs+g2fLZpJwMH58i0bUwl1EBA51TwMgMG4sxVSyZ5c6pa3TU+a1/TtKPHY6Hw
	rDVY9YHhxzcdbAtoUvUmf4DGSwOBnbZXkcMzR/yrDV+XwYaPLvZjH7FgGd/0D3bPxks6pe
	nre//Cu130yvRIxLycj8TIY4ecNGb35XLvINdhkD4ejvq+bcz2ktOW+p40GI4UkbYMqJZO
	9n2JLMf8f/3Lo8XED0IRgUGiX2irDgLbvB74AU3ZZhDjOytLo5QqXrDs+5rdm8bCUzhLXk
	chfI3B7AFnEHHvLn/fdn3koWVRQoou2PalU70jrg4DCM0R2CDql2UDnlwTWwFA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738594; a=rsa-sha256;
	cv=none;
	b=OEq5ZL5VHSN/4G9RNhUlEUOmWjuHU+mI6/MSBWA5WzHmaDJsbvXScssUZAW0aFd/BW96we
	IgL54saYuZnQmojgYsn3HUUscTY72GL9idwHliyowscky0RwIUsyKW8mBwPDPIf/ji0vhR
	2ILlv93f/s3eGcKGU3OZYECJTolre9zp2tB1Y6zV4kHzlzzV9AsO9lhAhS/b6KKJ3JuzGY
	fq+SeL+14uq5nxPE3gPMUc653nA6vHuk8iPNA+PUmsY0gIpAbqG8VqSVFvLu4lVOh6IZ+r
	kT2/U7ZnktzslPAWzEAHY4WJ2YrK2DsbLXH4SJ6Zvkm5I8evJKen09avoDrZHQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLe-002V8P-2X;
	Tue, 03 Nov 2026 21:43:14 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AFD1C5DDEBB;
	Tue, 03 Nov 2026 20:43:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/15] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Tue,  3 Nov 2026 21:30:25 +0100
Message-ID: <20261103204305.3211144-5-mkl@pengutronix.de>
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

