Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429730;
	b=hIvfSoYZwNsrMnjtDAkMAhNdkFwzAPIaeX9ij5nakOGmcwVjyer9tkO9+eF3k5V9sAik
	 GZ/T+b2TPoDIQiejdwpv8zKWdiqISGbEq1q9rB7DqiZih0SBYeUqRK8Z+tuF5+RuFuLT4
	 QS9Gx5nXks59HcoLl/fNyf6w4KVi23PYFqVBvNb5RHMtGm9EiVKTqxfwTkIcmTJa580nI
	 XaewEhLSLdnzxzOUDUQa903xB3FDbjQYBUyFisqJPRhKSMSO/SHR2SSp29TJHDjcD6dwC
	 hUx8y5HbZVzD+JGW0BZgXOBIG5cH/52icIU9Cfn2dvduMWtVk/uYVeAGokZcfRYcGxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zrvCeDlbEo1dcdadZUxg0hKYtY32Q9aSGECGIN22EA4=;
	b=G2eHiW8/xXlHDnYVeLuZel9c5xPV4wJIhP+xt5fvgwySBT/Xteeo7IrC90GKEns4ZpOQ
	 MPv6dek1jdQCj1fk/Ls4j66lUSqMiShZZBgR5NtzAYQRWwA1ETwYVwiJeowlt7Ev1230M
	 1ycS372Z2jAlPBrKPxKqqxNvhNCLUigrKhqZUYZrMg2CjYD/srPDLQdQuyp9gxGc+V9Eh
	 6OdWFLNJzk8fYBgYygxQTwhbvuz9C7h7VoA0/BILE2xEKy3LWljdsTqxosZs9XhosXlom
	 a7gYCkfXin3EikMo755MmbeskUeIbuvc+t2plmfmHYc3cJHuNc4WRL3RFfuoMBLxduQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=b0ZlzURX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A84606A31E;
	Mon, 19 Oct 2026 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=b0ZlzURX
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BFBE0202849;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrvCeDlbEo1dcdadZUxg0hKYtY32Q9aSGECGIN22EA4=;
	b=b0ZlzURXSUfjJuo2k6z/Q/MlWLA3dSksxfj4nzPLOf0pwX/+1p1gWYOWaPTyYwjmaZ8c0D
	kqeafWpi/87TzvB+J/fZgkksMPpEwN5yM8mXYb5F/dl7UD4XBK+Xos0WZiERN5FKyJcVb3
	9g0+X51nvJimODbJ2lfofnFlA60GpYXKcOUiKmB3i1mr08VOzeBH+zd8Z4hVBYno0D7BgV
	RQxvTJvDAXs/Lohpj6N7Idc79M+fqEq61oGPCAxfXqvsZUoT8lPDCvA+36/lnmnRsg+u+A
	vA78+3GHV312UrUpw5zTX7b9V4fOf8Dqe+uAPYEByZfrOUWFB98qHcynbn76nw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429716; a=rsa-sha256;
	cv=none;
	b=bZGObe00i2N9tNnmXvCRXFsVBT1qECfO3ErhZzNnpgJHqIwBYRqxHoa+j0o3EZkc5W6Suk
	8r938+bn2XSSOI14vdWxkecjZ6nvZ0eu/h8Slq0EzxfsyFyWdZIXnFdQxl7ZbBxQwwRGIf
	lTRJDkhh+B8Y98dmFrDZDZtIqAOvTlRUDeyjZKp5lnlByOSXV/4332msbfZmhYrjDNLC6f
	COj4aJAQJetLw3cf4e516mBc04G9MmNntWG+MHL+6xN0os8mpanv7rlz8Zhsh9CgedEdpR
	iqBIGZign5DjlK+zJJwsVUPwFoJTZ8myyyJrlI3TD3YlQH+kK/h/XsURr85X/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrvCeDlbEo1dcdadZUxg0hKYtY32Q9aSGECGIN22EA4=;
	b=SGWEjMg02Ta3iSs4k4lThwkLqfioP6B9OqItJ7y+Z6VPnDbW1bLFuvLWi0ykhWlZUE1lcn
	JXuoE451POqxZrJf9X8pi+7i5+D94v+v/fIZQVssi0udBq+RnnaXdOFSNjIW0tUNJSTs7S
	ky0h6PEgcpb4kfwbmc97kALItz8JmwjsQAcCdjnUAdok8/rtcpbLmBsvFIJmsx/YMp4KLl
	ctRFcG1Gkns88u1jnVs6S715r5LhHu2lFIcuFQc9eMj/e5h0MzVK9qSftdUNs70YhmA1H8
	hi6S5U1yn4l+jZYPrweLpvki6nihB4bSf3hhp1UZjegtvxyBjYeeLp54skkH8Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000Fg9-28;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6393E5C948B;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
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
Date: Mon, 19 Oct 2026 19:01:06 +0200
Message-ID: <20261019170834.1727150-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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
 

base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
-- 
2.53.0

