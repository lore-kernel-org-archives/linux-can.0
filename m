Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A13E9C32;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341869; cv=pass; b=EEg1TsOud8VhiV4ChTMjVn+mEE7ghMygb1pxACHWXXLXtNJdkKNdPaE+JQT8+jGKqui2PLXIqP70h+1BugP/M7T9kgT+h3PH/m9sASZFItL8xtFVADfmPxMM+Vobhfbo3b/hNhMlBZ1FGWvvjukr3VjJTO08CC+1lepAK1X/Nxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341869; c=relaxed/simple;
	bh=Ao3L2+Ue7+pZKtJ7MES2eddpZH1SQOSOAxD3Gdumu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPIoeGxWi8Ce/BaZ5IUXXYcZ0XZ2kJPoODAvLN/fqPFgaX5kKjdH2zSm1PSyN7ia8c/aOcqHL7m82Mi2sap3fiX4Gd2wu3e+T6KfgbXtJsw+h5MC/O4jkScXZ8m/x9jaWwIRjiVQaQSLIgkZTOQhNEtsy/P8kS1GNXeLybrNWik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=dnPIE8kc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="dnPIE8kc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7CA21202840;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=dnPIE8kcF7k8fM0DwrGEpkolexHwKFTzVpmBjEBvTT2pxK7sUKnycI6OgT8RKO9k7V8mtq
	ttgMvZe7b7IEwIKM73Kiu2D3/Ze4Ks7R3+ZtSVCtFZ9ylipN02mDdADUP+bHQPhjh/C7w/
	BW/TB9JJFAk2qUxot0DtVMGGQbelWujJJIyREmxyJJ2qm62rDR6qUKlJymdJp6iUJP5pHH
	pH+UUig2tQ5PZ85abKde73J3kYMWkeU0VtWErjoCFfyRYf3BAfaoz1guVRiurFzkYXVEQ9
	vEj9lig0xavpOOj/amU6SC08JmafQj+Zv+X7NXWoP1bae7uL53ukh7VB2UCE/w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=UAIus13c24gf7SGq11sl1VcorlaJNTEDxovtu4RUuH8LZHNaKdjYqaXd6WUz1Ax9qchdSW
	trkq0cpqpa+mzfDNlE17s/FkPt+8jKwnLmlA0HJr9gR/oM92uRp1lYtKKMtbRXClOoGOlW
	A935WJWx85AHtaemXBqOkxMNoXxVcAicmJKv97Isdri6Og2Q5vHPPMTffLqLFvok/WN2OF
	197cJa2uEAAZExSX4XhsKoxrNiXiuOnaLV7MuRny5QwfmfIIBVldLzJ4xiBPcL7UoJxT6Y
	nT5DJqJQ9lOGp/XeR5Uru1/i94ElAEdnPzMSB9PDJ1V8FYjvFsnOXfy7wVu3lw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=JerN/mv4on+NvgopMIc2xEjSVL3ORb/lxgUag9aOEkmG9vNtZSwYrTie5ejHWl+seh/z+S
	X5xRMGoxxjSqoEcMnY7qGXXVJZ4o985wj8GQo3y3PqKcUstH0Fz8tLgUBTxhh366wZ7adh
	Q0iwRi5REE2OIikoEsG+MfnauIC7istv/ztwlTCkpEU9PwwkuX3tJikxpagoHskErWYahg
	gXpfTOJg1ZODCreOOoC5XZ1BoljmEbikHKcgrCgHJhrH8+mzuERL9F+hGOpVrDAc4+pHyQ
	DMxeQrooGvAUzJvd2kB1Rv/IDsOol5ZHOjcTJRMbGbdyp2JMGJTJMParXpD2Og==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006Sl-1J;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2339B5C7D9B;
	Sun, 18 Oct 2026 16:44:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/12] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Sun, 18 Oct 2026 18:41:47 +0200
Message-ID: <20261018164417.1540449-12-mkl@pengutronix.de>
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

