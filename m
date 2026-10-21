Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578482;
	b=eJG6Oyut+VpPn8eg5iM8Bhddd4vv21oU+/NZWTZ13krdOT/eiyrOVLX1aShEIXBIscNg
	 ZbUyIJazTuWRXG8HpnXfItisy+l+RomAaUkPwTB79CrD00fbDRThKBUuGypmJ+8AQFfy6
	 RM9kVNQCu4BMTXKwKuebDvmB+cMwilqAE1rw+7tAhmWjdjz0Ykd6NMsXXdSHtt1cjRIOA
	 0vamItxLvQ4mnKqAyL6cJ871xtMOnCy0WCNdRTXQoDr8LIx0rKFLrjVQ6K4rg3OpaosTE
	 EldAhbJCshFzclX75YdMqn5SnSVRAkohp66FNM1+hizM/o0DhKn1kHYG93DDvRdnDrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=c5icCGE1j+8YwLfbTGFMmYMcAwtQo/qgBhEGeAxefr3xM1/n4P3QqeICbq3IMpg7W5wD
	 tHxCuYTGqtliIzczzpwm62R+kNJtesyfVbcYUh22EJhE2gIX0qiIaAI1VippeN6w/GoEO
	 upy23CQRWcx6Hkzm0kgaUoPFYImLhrZPGCAI9SgoIjWk2pd43AcZucmi2J+CvUhQPZ2eg
	 HeU80QiZ5h2HrwkUzpLMg4YFnXZ/ypTdJf56YM2eDeJzsxIY1quqXZnsAh4JV0VtUCymw
	 USWMiUZp34aP/lB7nN2M9pzI7R/8U3VciSzpiqyb2wiT9LqEzzVZDpiZ9N3m1qMH0Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=B3E30Pv2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37D606A31E;
	Wed, 21 Oct 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B37D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=B3E30Pv2
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 432B720281E;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=B3E30Pv22QuprcTPt70JAGHImnPDub0XH899sWTcCgiUr78OYg/rlmasonn77370j6aIsW
	O1XBQ7vnJyQyePx2SDjfcLHzVYyaCBGgJf87msebgQoRhRj+tDYVUQdsxvRUGZhofDoUxC
	OkDsMrsAPDsRCs+WHgGMg5klF8aYlo0fbN9WSyd6WWRc+9bra1KPgHViYGGmVSH0Ar/GOe
	HwZPIJsJllAGDnMcoA8hDCzSrOtHFZ7XX7on9p1xchTuGG3EJz+K2hQ+29aRj4tRvNxs5P
	QtQbCcAq2YRs4yVdNkS6qvjxlrN7orgaj/Xihcta99DocPkor2itX9qAekVQlw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=A0xCj0Lk7GFjXtudelcSW/QgOqsOTBOUTUsr28tf2t8ON81cnq5xQa56f9rEFp0mjDwsoC
	sIKa2iYRxnQ8BfIqV0lln2TXYMu3l1fIrEbnOvNgpLT/tUpkP+wVgqTmaJwOdl1KmNExm7
	WFSow1gnRQhFnb7mt8E4p3jRTWgilemRAcykpY/rdLH5zuWOeQ1OAFRvFWCktPbKXGFUM6
	5aevEXQZKiNrZ6/q0hjXs+4zhCZ7uPbpS0/x7VQCY1t6jG2SJ7iKXVfjFWSBQGtB1c3wh8
	xzDXybplEJ+xHFBfH5he/NrlHsF3UJT/KHgZViG2niwBR/0LJE12tMbeJ2Z9Ig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=KFuzWLMe98v4allm+LK1Y8hCmc666LtUpfcJvGNKHlSPrs8j6Nr03bmZID19gzDmihMPX6
	eQSV6k/2X4hftEr0AViH3YMffA5zikln2Aul2RHRx6S6g93pDKigO0KagLbbLq6/P4k8px
	wL2pfX7VUQ0ynkO8a/7tex4DdaIiLJB9Ey+TjOP1ImXbG/srszt3B15276WKAmVJCnW+WE
	GC8iXtnmlU8ohyp92ldXQx+vcOSDecyQaHuicc75aN650tgO7Mg3H56VsZjuNPPTmIcV1B
	JsbNBsaSd4QkUHpz4Il6fIqFPzCgpr47fnmwIQXB7RXFKT+0Wt4BhC+qRnDj0g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjf-0Y;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E132A5CAFD8;
	Wed, 21 Oct 2026 10:27:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/11] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Wed, 21 Oct 2026 12:24:32 +0200
Message-ID: <20261021102756.1900679-2-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

Sending a PF_PACKET bypasses the CAN framework logic and can directly
reach a CAN driver's xmit() function. The PF_PACKET framework only
checks that skb->len does not exceed the net_device MTU.

For a CAN device that is not CAN XL capable, anything above CANFD_MTU
(72 bytes) is therefore dropped before it reaches the driver. However,
CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
2060 bytes.

As a result, an ETH_P_CANXL skb with a length between 13 and 72 bytes
can pass both the MTU and the can_dropped_invalid_skb() checks.

A driver that does not support CAN XL will interpret canxl_frame->flags
as a length because of the overlap with can_frame->len. And because
CANXL_XLF is set, the resulting length is between 128 and 255. For
drivers that do not check can_frame->len before copying can_frame->data,
as most drivers do, this results in a buffer overflow of up to 247
bytes.

Drop ETH_P_CANXL skbs if the device does not have the CAN_CAP_XL
capability. Keep can_is_canxl_skb() for the validation of CAN XL skbs.

Closes: https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1
Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 14edec5afb57..bc0787535b52 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/module.h>
 #include <net/can.h>
@@ -388,7 +389,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 

base-commit: 7dca8514c51ea5219daf7f28bc1a0536b907e611
-- 
2.53.0

