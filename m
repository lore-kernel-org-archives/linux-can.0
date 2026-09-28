Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85C4FE2CB;
	Mon, 28 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624006; cv=pass; b=UZfTG1nO/YavwbmZN6sQ6GCbKIXT5++dWGl/4lZ3L8NJ44jiIZPbMMuMIQA74rutJbkiQ9zdGVREQkw+QuWJJAZz9gcCnjwoZMtSOnE3V9gKR1BB5AVSvuDFU4Xc6JyhrmX00CnTtF/LY4LRRmr3F9AtIqVAFkCQ6eTS6oGn9E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624006; c=relaxed/simple;
	bh=m0Ujkari4sHNBRPYYfk7wuwMpAimXpHWfCa0ywTM4rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icm4BrXH1y6ApdldzH68+OYiLzGls8irOCPhVJTnAjVxro9Nm35XmZUPd2uBVEUN/3WVHwNFEm31xpOPfGvH4nH3L/xG8Hwpkc2eVi78YuxhJ1x0dlKtY1Yy841wExa5zdf5iXvkM3ATYdeJ+qvh3P6HVINMvCPh16hzvawvVjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=AX/KJCwt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="AX/KJCwt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 71DDB201F0F;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN3QRq+KoWc5cWDWUaZKIQuDDNDktHFb+lN5/8SgrA=;
	b=AX/KJCwtheLqcmL7SI2iUwIj4Pxdw9i3Nud/HUMifi7hLiFpuxpOD7W1yNXcplpLKqhvKr
	35rmegP3Dgm+5NJ3idANHWaAN7TV1ISe9E2d+mv302WR9S+fYKObxjsD1KBxDnpygcyGBe
	BiS47GjLrIC2WyOdN3x9oJ19UZPabD68s+CyxFYZ+/ZQ26bt0vFV0AD29028o0pgy7fLBo
	zYrhhVmfMraDVjcVcH8z3aVIPQgzIRcdi4sb7w1u0TL+jgfdq4434pza2H52G4McTIJsCV
	twljYn5bG+2fxkDirSKlejWS9ysLU85YctjTjosEg4PdHaLL1TYxZTeVUGuJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN3QRq+KoWc5cWDWUaZKIQuDDNDktHFb+lN5/8SgrA=;
	b=T1x/bMyoIvs7jI/EHsy0hzh5ysjupUPCJhSIcqYFbFlpqWqYToHMiBWmmlldNgRS+mPUqi
	7uOifOjvlYSpX65Yl1lIipwUen21GYuXADK+dW3PAlQVjSkGqwKwp6JQdVyYrTTlfmj4mq
	kM/8NQMKoszOUg+7DX2cipLNMpf7VtuiAB2yCxqqltKdePd9hO5kEVcV38dmXENBPv2xn+
	Wl7o8biuqbKP58Vd+npOc2J5F/zhmfvmyh9SsD9XlGc7zv3g6DrKtxwZOy+Zfy0z/DTTHf
	txAr+fWXZhx1NN3aKPl5n7mnTAQS0tLKpF1rk+tsR/SXTrOv43mBCkdnE0IN5Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=E1cLA4ZsBDRdCUBMDO2/+JgVtrI6XGsWb2Y2cLyTRULO5ee1YkEl93IwgDXtcgI+3et5wT
	X50T1aGno1hygxcFk7hFzqlaHJ5KZtH4ItwFs8apDECZSW06wLmJIsxpDxU5namAroHAXE
	IknSrPtE20cAVj0sDPHlDRz5aF310+73RTjwPFvLvMD1Zci/aTVKQ2G9UiEXGy32yCOwP2
	E69SUVujTr03U5ZdwB97Q0UuvKVROKCv7UxhWFQu9XmwdiwejhVA99TNDcrUvv1yMXBnwR
	LQcrj2JVsGxapOiyA0L3e4iyh+hkADllGGp5Uk6WHzid3/IOj2DmVCofCcj7sA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5q-0p;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E951E5B1548;
	Mon, 28 Sep 2026 19:33:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/22] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Mon, 28 Sep 2026 20:45:08 +0200
Message-ID: <20260928193312.553632-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
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

