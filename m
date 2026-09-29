Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E40912B;
	Tue, 29 Sep 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716040; cv=pass; b=LNNqO//sEbpcXHMG/iZwJWPPJVw8kwTtFhjVdDvZAj4tJEd9mhrXrrM+B/MmwMnJFEwvTUoSa2QCOfKgBYDaPJGfTceiM30xKKDU+OymMl0BG+u3WqLt3kRWmtnud1KQ+WA6VuGsES/M9nhBw8Lq2vvJNsJR9Pxsq4oXVD9rwXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716040; c=relaxed/simple;
	bh=m0Ujkari4sHNBRPYYfk7wuwMpAimXpHWfCa0ywTM4rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8ZhbBAkuPD/RSMuqwcwkTDkS7XQkb0zYu3UaO+G3JL2yn1mtU7zs1P2eSL/OW/4KaDjrPlDm4ZRz32PrS8/ruNd1F8grsGPjX/jBK4RUo6DHE4/3S2/l9YgMLol67Da/MwwnYRqHOpqD0tPK2VjGNiz9muyY7emNrsQIyzVsbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CORUXSi1; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CORUXSi1"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5007E2003F0;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN3QRq+KoWc5cWDWUaZKIQuDDNDktHFb+lN5/8SgrA=;
	b=CORUXSi1md9DBQ98FRv3kFgrruMfk2VD0efkQqIabuDwY9v4BCk9iCxNC8C4l7XfBzrTfS
	2o6ncADmCXgXF3Aup/bdWklpeDNNOau9+QWh/oQWe1CxyTvGmrH8eN2/OXyjysFA/yD0E+
	eENnkhcsXt+gT/L4iT7xsv7G0VgWvaXeqREx2vngak8B0zjQP8pVrm5y5uQjYRSlNt0d1b
	YOOhDL7C+AS7op3LLCWhfJGUtt3iknGyEdGXBUvMlw9Jx8VPhKg78MB96uCgJSsewy6K92
	kSb90e3IQK+pK23cLvHgrpeWGBfR44PbfNhTBJL1FxxAGuMlk+Zp7GL0FHz4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN3QRq+KoWc5cWDWUaZKIQuDDNDktHFb+lN5/8SgrA=;
	b=ETrr9xDZxGdJpW4TGTAAzKqFE6TOdp+9+S1WSngcVTxdIRazsdxIBe3oJZhpsw82JnK9nd
	1++ydDhcSAncZhMgp5/3F2+XMT8oT92ZMMMVdIisalxi6JbSULilcMYToqG6LcA0H/mB9I
	/ux+ILM5WoWcGFk/OKIMFYAoXxIMsEA99WQ2TwXv5ZUBKLavg357h0V+hEeQCPgpiYa5Yq
	n2q0IBDQ6WNQtz8iZMx2bCJvySPfWyQ65anDTPJxw1W9Z2LI9NpMxBMs2DOcfQDO3pizmr
	1RgTneGBLgzXx5Ab8D6pm2E6IfQg4mzR6sqhT4ujg1zMvwTopfV2RSGI78Vd7A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=f+pU07ZZY55SIFyb0dS0MX3ZFfRrYKk9TQS4OVUmVTknqiAdVH2iCaBhyg9Xlut7EX0uBO
	s8DED+5aoqPoSNSS6iT/JmTPckfNpLq5Gt8KSdZ3jOa/HSWcNyKiZhG4tn53BCOwSMqwvx
	fgkXe7ILuCXCoEpojR4ixAIhG5oMSIXyFpDquikKbg/h8m5e6HHH302O2KkKIDgo8bazHX
	BZyoq10teVgF7uRv2tKBtDfvJ7N7BGQv9EQ8tW2ueBIs1xYqediCShOpCRm6L01J9vEIzs
	INsAgjIQjPlKnET2kQbfu06doAvgS/R+VDHVwdeh5iUSwEbVsxt2LPGjmq9nQg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3Z-0e;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DF6495B4CD1;
	Tue, 29 Sep 2026 21:07:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/16] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Tue, 29 Sep 2026 22:43:51 +0200
Message-ID: <20260929210700.1183036-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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
index 95fcdc1026f8..4f7a189de265 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/module.h>
 #include <net/can.h>
@@ -384,7 +385,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.53.0

