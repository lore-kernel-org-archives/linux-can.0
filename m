Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738599;
	b=mHyGyGZsRegdtlMhJnte5m5T/ma6t3DjcyUvwjxmCKbTZy9KPDbWLo2bT45qevrix/GA
	 gijlKuuuBvq/Q5hKd3X0DCW47vlZs3LaFYSfu9/hVyHmM1amnW1QV9gX8GIooOGz08r2B
	 fzJrAhdsM63v6ZGvzCm3ix+tgxc/yqc306dYOl1cTr2s0cTsz0tfF65huE9tQCp7JA3fz
	 SDjazNuM/6A27dS34pa4iIOg71S51r93/a6IEc4kzCkvFBzTI/kh6M5qFxxewLBFAg8zf
	 H/BrNxxSY7HOQ7+g1PEe7sg0Xf+miSnVGVF5HduIo5poN8SM2iw5ysXlunnhMQxKccg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lerO522pH2NLNZ01BgZXW6LDiaKLG09WRuDYQr/wQOQ=;
	b=b0ygK7/fk+mCBTUC1Hr6s8Y7vWfAG63PAzELp4a8I2yK7vkcG8jpNUjd/2dGfMlLpzsR
	 FFehlAzQxwrfzSBKSQuSDW5SsjKktHQykY+8pQmdUC5gz6duLU3luk7H64Ss7Y7PvwQqC
	 s8EX3C04BonMqiSTWmb8ebEGf7zMBk1plLWv9TYPUabyBVpnkM6qGjCORcoly1AMYaqPU
	 cKWZJHSrfzKDdolzWIdT3YJirTS+/l4Msj3IWvPhwVnQtrUsVOb5A6Q+7jj8dqHMPgxEE
	 FgCtwt+covcqJ2+NaR9g7l9+NbOIx4OMMD5YTi7xRe2A0SqS0dfiabpTwdez2QIDUpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ECZKWf2d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9E606A31B;
	Tue,  3 Nov 2026 20:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD9E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ECZKWf2d
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88C0C20109D;
	Tue, 03 Nov 2026 21:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lerO522pH2NLNZ01BgZXW6LDiaKLG09WRuDYQr/wQOQ=;
	b=ECZKWf2dzeof2+IIi2IPt8FsECWZNeYFXxrOA+BkujT63YPJKLfFoh5uAtHMK4WQZCuuwz
	VaJkbrUUWibmU5O1R+o+fC5Gs/osTz3nMwflySNtloJsrP67ZSLTEc6cTNof23duR/xeQ4
	af324pN7FY4sBMWcUg3eN9UQbLMnev+UqjpbXMCPh11SfoicACvzrVemky1T0+0al5QFfn
	NAB9J5TwhFaPH29iG4412VIUe2yA498dVI1xF0Bz9niUy75GVNkEJjfZCiUOo6/qlyBNZe
	WF/vodmIIP43sBav6/3wMDbdh/owBkA4qRLd9JWsKwhJ2nxPO2669ySphpUHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lerO522pH2NLNZ01BgZXW6LDiaKLG09WRuDYQr/wQOQ=;
	b=Ad1M0dk0ICg7iQ9AySVWXvKf3pJ1auPF2B392f+5mibN5aYfTauKtPP9/Io4qtR2+nHbHt
	tAuFXiK4qAb4ZjlBsF+De5fb39+GqsnM9k7ng8RXY2/FGQRYipYu/bKbs0RsS9+VDTUCek
	DwUIbpA0NCsT4OR8icEqRtbVvnTb0IX8wAclCZC/7IOoSdAtfWgXob1xi4cDfg9WQBKwYH
	58lGcB4NE6uykhqnfqtiv14sy1qLu3m24abhjASnh7FraWFqRsQBw9ZwQ5cWsnhZv6OAWq
	jFbSyO1kTgb6CxMav9ws8M3hbiWAjUb7Su86utkAjAlEU0JoMO9XYUfIVEOF2g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738591; a=rsa-sha256;
	cv=none;
	b=KeP8gH1XYQbnFLHOb6dR/q1lNbLYuZrpEOvGvCJAQ+A8K6t+Gc+OhJsxvO5XtDg/VOuDwp
	jImrk9ZSaamz4RcxcUsV1RWpZjQ8Dva0K/izEHwreuvVdk3LiITjlqESM+NDL+2YTdY1v1
	oFpfp7IVU4e5vbihg9InW+WSumq5QsVwncdGEdfEehnc3sY4OsbJuL8yI/M9Asp349MrHK
	S5iA9EiZmH2Ykq0FGpDlQmpJUQv9HHIn6sUwAyL4Kty6zugATIFRVVrLBINfPySYBYQLT/
	HMifVukcmZNs+igiUEFY3Qqu+MEF1TgmiumT7HFdpxHwhh2S7rVmtZ20QuKJwQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLb-002V8G-1M;
	Tue, 03 Nov 2026 21:43:11 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C74B5DDEB8;
	Tue, 03 Nov 2026 20:43:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/15] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Tue,  3 Nov 2026 21:30:22 +0100
Message-ID: <20261103204305.3211144-2-mkl@pengutronix.de>
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
 

base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
-- 
2.53.0

