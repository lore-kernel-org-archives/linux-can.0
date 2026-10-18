Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF63DEAEB;
	Sun, 18 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342224; cv=pass; b=gb9bSiO1ra3Obxax56ovIdY/YQ72hgiwFr34GIjnDbUc+XzcEXFgdRpbl5i/LRnXC6RuCp+3a0+lmRphUBPSDFDgCyU/yl/LNzfvBwOaSIUMqg0CYONmLkckSPsBINaWT5TF79bFH/IgHZyEPJRhO9LEgJ4nruEAYdJ1uZG1l7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342224; c=relaxed/simple;
	bh=mbZ/dAx2tSfz2Ubk6tMozEpHSH1m7C7Bdg8Oh4iUUX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8ggjfC51l06Gw2wMKB2k1SjR3jKfpir7rlbdWDPf/SkzaGSu/Le2GOdgBCxveF1IAMxtjhy43beQIR+6zG+sKkuEbQ569lgd6RuKbqApfMepXqEKg/VgeYkksv6NMp6tv9ibMjgNloVh9WBe5GJjZMwUT+QwLfo5DU6tOcCqmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=UEhWwhys; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="UEhWwhys"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C4DAC202095;
	Sun, 18 Oct 2026 18:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrvCeDlbEo1dcdadZUxg0hKYtY32Q9aSGECGIN22EA4=;
	b=UEhWwhysGjTY9bQe7TnRTlnVzxfIZSYh2O8fkOLnVn4HS/q4JFUZvfURk3zh90oe/sQwYP
	f3RdByNIROwwEFtFLPIqz1S08l5SQe5vSGE+EYCtOczgZSonr7wvz7aJNSAQq3Nw6AAiAz
	8ltjEcSMSNsoBkissankONn+ENyExqQflLOBwgd6tmkIKU+NjjePKzZN2WwMQaF85CrnGS
	D2z07zy/qgEJ2EaK16Fa+j90VLv2xqBRcFwvS3uaxF4vbvj8Xu63C/vjNjTvc1guE+9QXx
	oLyN/8WT0UuZ0rOv2kvMB5cRgnb0scObGuFvd9vWP31Qt4nywnWMiNNIjvvkQg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341859; a=rsa-sha256;
	cv=none;
	b=B4kZp4AlUXLLBjX+kT4xg3BZIVgK+Su/JbStuE8CGqnKpQuh+5c4U7xJ3UfJGLCxJk+1AP
	ThsuD/wAORBeDx2f9toYD3pQYLsVUQ9/lERiJ6Sgo+wVOMEp4sO5lKXEiImoecZ0Ek6Ktt
	qdZ+Boq1vXnM1VthtpIcptk38e5fuqFLrfu2cOEuR6PuD9w5ZouGEekGJYMayWyCbuMxVF
	ahaUqDm6Rm90tZzBYz44vUbt78mY0OWUUYu4qUpb2TDkwY6xPedJeD3jHDWupC+5BO4N4q
	2cxUbL2mFj3IqjKunrwrCulrPLm6NZvdvkqVl092jqgdqkMSM+o5+Xk0bIOJrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrvCeDlbEo1dcdadZUxg0hKYtY32Q9aSGECGIN22EA4=;
	b=TKLQP00h5mqPdVc6paL0pNanr2OHX96mMVz/uaYSwVnpABstucdVrrK4h/Pacbd1kUmGc4
	510RBxFnj8m9j5j1YvGy3egybB8ODGZrsAqFaOh8sQXNN2bDrBcuDX4RLNIxmfOHQD05Ls
	DINU52kaN67PNiqwou2yno2RrOx9qdWdeCNsjZpqSLh6LvcNiWDWkByrWjv5VzrocJfAbi
	Vl19J+zMkNelGhIh0f47uEPW6nzyW5IhcBDEWowAz643AHoDllNwXubP95qSiIztfAUHXA
	VdbiC6Dvtk25Qb8rP1IXtoHVUV3KRjCvV4HRk3OSMdBoBZkHNmZQ+w0RjNTGMw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SD-23;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5952F5C7D91;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/12] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
Date: Sun, 18 Oct 2026 18:41:37 +0200
Message-ID: <20261018164417.1540449-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
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
 

base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
-- 
2.53.0

