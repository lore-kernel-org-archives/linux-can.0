Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624301;
	b=nHrdeBdigNd4GyH3m1+IdB/iAnoZiuBw/H9Tpn13vmMvEZwWWTwZGAu+HNPup5S9gqay
	 RGZ/cfg97E2qPYEZ1ezwcJxMn0d84Rn037ulIfbf8/dhTpXD4fUZRetAc/Zardfxn+gOm
	 DRNlGwMJBQa7cvKTQfV+xAjQR+FjMOxG9ERpmy+1dIdZpJBv+dk+KJpkILPtwbIv0k5ed
	 l3Y/t1iCbDzEO8yEEUkeqfhh+LiDRXaQKG+DLrStKoNyMmp5JoYqQ91gmY4FofQQyOLvj
	 1n94OJonrDlWPsqynKWSOcaNEw7oYBKTddpmzo+jZ5CFnVDzjLhpaU+O7qtZJO8dU2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=SCqVq3NX3cmYmt4o1b2pr34JtlYEr9B4DSGdOvqRABOficSH9BnY66y9ABryiBHWYt27
	 YsqvHwpDpMXNlC5B0QlE3y1K2qIg4pV4BH4pCD1YmhzPNaxta7kfsB1oYy5TwjjRjZ+Na
	 KpFmoCTC+ekkYgoW622RN5UEptkPxaS9II+8BdRS2Bibb4VRsUH1m/IfN6saRD1qhcoVG
	 Wx549bYvPwPrypdqdShEdZx+IuoywPc9Fu9cauF6kKxxQRtibjuRK6Hqgiseo7mIas265
	 vFJwsIO/DFbh9hLNOVQ/u4aA6+sXCUoSqnOi76YgdSs+tmEKThuBhfRhYIyZpbBX1JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EWlUPNog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E43606A319;
	Wed, 21 Oct 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E43606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EWlUPNog
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ABBED2010EB;
	Thu, 22 Oct 2026 01:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=EWlUPNognQI+nXtOjwrKnEnQZOhhjj2PZveCOxHbPivwDLcRueJJIZWhOIrWrY0Re9d1lj
	APS4vxxDxsW3QZBzuHn2kLe3oWJu2U+qXJcg/vuoyxH1Wbv4OTNjNk5nq+R9FZRn9H3xt3
	MLgdLCPJTVjfGRhMV6j/EP1XCbbjuYGneiRH94avzd+2Bx3b92NZxguK+q8hxONN7jbXeR
	RwXqEjpQs7qZGZZOb3WvF0tFFCFBfy/IDYZSdPjDt7b/b+gjFPnaFgOH5FDgYhIV6RrEQh
	PhU8aSeg3pjpMU+cOTMa73CqBx18M7+n2scxKac7mtVQ1rEwyZq262tlDibLXg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624293; a=rsa-sha256;
	cv=none;
	b=bahV2yTJGv6xg7SPRmtRWA1f5VW3i4zYn+0xvHzgrAycWpc0TXTxnGd+czRQ+kPQsCq6sx
	+x2KzcfsJ4haTy980/85YztDDmgPOClSXbg+ULw4OuwL54Q6jilSZc27lZrHA2mA+2Kp+j
	YZom23fz7x0znmPXb6Oxc1rxhdAMMwY/x5IqqcowMjqx1nW/Q95LrzsCQMttMmnIYdCQsK
	bgXqJBWOXr3LgCnA+Q1p87Z8PHtp8oX4Wy2UdwVwSW+u06pEJDGXo5XidNzkNNv/CZHoJW
	BsxhagxoSzG5VcBhs6loh8HzzDRQNlrNiKvQhPUT2kddgKE/JRmqtF+yBNSKMA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLJ/Pg/mB+HODpg/ym+TC3h4uEX2MNkwBj2vRvK9Eh0=;
	b=NpWhaRIe2QA1sEgVZfEtKLZfh8FPrLOk0pqSDg2l0MbP+U7b2dRHS4DyBsPQBCUbP7wbJE
	+W133ZO0X1hzeSi5SIJQV+bB+cI3rXmCZndpZCWB2TZbjP2otIFdxK/EAeUEUMbA5RXakN
	jfoTxtI9rOaTUrZHrltRReJXxzU6vIhAGHCTjD8w6eQfcJ3uUhZpvkEkACy6KSC3R9EEUM
	kzDAuEGgxX3dO6GChxFu4zjF/01rcuNEUTjQjuN6h6rHvoixSlEqTIp+i8nrloZpSV2MMo
	pj8r70XBXHfntU5+1LGWHyY1+gawKcr/q4w90yR22mP9/AhPjZO/LJyhwI/E0A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT3-000cW8-1r;
	Thu, 22 Oct 2026 01:11:33 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F00105D06D6;
	Wed, 21 Oct 2026 23:11:32 +0000 (UTC)
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
Date: Thu, 22 Oct 2026 01:07:48 +0200
Message-ID: <20261021231130.2085690-2-mkl@pengutronix.de>
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

