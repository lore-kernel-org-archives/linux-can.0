Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAD4DA9B9;
	Fri,  9 Oct 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553415; cv=pass; b=XrcDee+6iLJeqkkuFMAp0NtAGDQZDGEcmvofCjPLErYBfYhf0w1YLRYRZsNYBHo89bA24M09nZ2aemST+Z3Ovm6IlZhj4veLl4jDNHFwb4UBNSluUfaan5l3Mpnwv9dCsrVg8/rEeVIVDtaUcLdu58PXA5HssNEclJlZvYL8Cpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553415; c=relaxed/simple;
	bh=vUjrXno7nHviyyo8AwA8z3a5lD/SxEe09SdiXOhBFS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYQ62rHssE/EDlxhESBAQ+AXV0Vmo1fRbI3j65DL2xIr0KAjb3BxJIiU/dCZBih0qxwi0Rsw2phuygmCTTawgYYxV6aAwmSi46jCun/hl8LXPhz3r8twB3ZM0ijKrSS+87FQCvsCs55pyLyNXQluFPQBQ0qnIN2LmvvWBocw7lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=IBJMcxQ0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="IBJMcxQ0"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B1BC8201CFE;
	Fri, 09 Oct 2026 15:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxGPsxXKBHV4jC7V+Qz2JSd3U1Ab9xBeJ0kr6mI1FGQ=;
	b=IBJMcxQ0sqA/gsjPhrGE4r9MYxU+0JpoYz9+9iZm0ddpDo+OXNMnMavY0M6m/W2caUu/V8
	nc0Fa5qXnar5cPGvokzjFvRyZH31nntQdwPZVd9FCkx9Sn2Pyo9O6g9xnT1rDkKI4X5ASX
	rUg/RIqluAo0O5rBHj2/eAmnWW/W/N2aTCem8mdIb0ht34FiQ9BqdW+jlR0TIOk7wM8GrD
	P+31evwJm9Kp78vB6JRZJxyBfqJIRYEyNotwmTH9WXzm7gp5SkBsGLM++b9k+MbZmzsLOa
	UDE+jD6AgmTq7b36sGsWEOUC0olKT84ILUqhoPsMfqy493RhObDcruIbWIG2Mw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553411; a=rsa-sha256;
	cv=none;
	b=FgmjsQFz65B44unHuwEdfYj1NAHLUf689P20drPufPLtHNIHDf2bTHTf3MBLzXzPQOarQy
	iIPu2gahkgkqP/B9ZWtzI5C0V1PXdkkzy5e/eHHYScExXrOSSTRxfBSbyxdBs3qW5Pz2Fj
	fWUTIpCYez3bEDgPoXV2cpbVfMGWoDRbEce9uiST+8B4jwZyM+6AnB/adGvWy7krAaw+Rs
	7k+g47Sg8lErRi/M1Q2OA364TLrYTKh9A+9AqxDHxJdHRe6pS00xO4CpDoavauYbg9DGJg
	tWrjp5TF0MsQzj640sPHfKBiTrXmfWcfTFoSvXpmULwOFHv1AIg9BN/Izm3vRg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxGPsxXKBHV4jC7V+Qz2JSd3U1Ab9xBeJ0kr6mI1FGQ=;
	b=f2pb5GGaIlgE+eE+BUjBSfHEuBK1fnFezndn2iZxbpvmbPXRRgJB15jm8wqwjdFN1ir1Ww
	wfd7RFLchGbebyrx90E4dFpsGOdvaez7sOm4KypcCw1asW7Y/S+yJq6DXcg6fycTZG0lde
	bXumWOopEAid2jYoT3+J/0U+mz78AQ/Xhfcgfs5XG0N512JIVFtJb/oxOx7UyrGo2tZNm+
	vvzM0QAzvFicASbH7SfoReWu7qiRXMXRSrqQ1ngC8YSGi4bwVqzZuYH24p7XN4i9T7I2Vj
	3PJq9IuFxesLHOw5IASYs1rWCfNu4PtpCCJ7dcK19Ek8lRalzGGILvMxU0Vl+w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsl-0053RY-22;
	Fri, 09 Oct 2026 15:43:31 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2CDAD5BD89C;
	Fri, 09 Oct 2026 13:43:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/37] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Fri,  9 Oct 2026 15:27:33 +0200
Message-ID: <20261009134323.64064-2-mkl@pengutronix.de>
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
 

base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.53.0

