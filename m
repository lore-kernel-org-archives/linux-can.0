Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB742379960;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029227; cv=pass; b=Bi2mEJIp5QH//6cAR/ZGoga7FnsLckiA6b3QhjkkyC9ApRUsm9I5mBqE0z+uGHCxP4FpPHPKy08D9wCPL5t0F6WHCGXmaXGKkW+p5J766g9tIYxkK00akqzZdbkiDoiIjTe62npx6num4zT0kqutiLrn+IpXRuTkpkZz8cZenVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029227; c=relaxed/simple;
	bh=Ao3L2+Ue7+pZKtJ7MES2eddpZH1SQOSOAxD3Gdumu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByWHFeYZt/vGnmdWpiccTvZ60sVo+Ch4ixAYgeI1VtNU+pEFhZvUiGMkr96FJ2W2v23mIlyYcMLSn6av0z23YiYvo5c7HR5+kU/dbKBUzM1pl/BAhpA0ntO4tYv2EF1Y++mHmzzu/Up80n0BAKV/5cqvt7lQjbnyaW/v49IJ8Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YJNoXkiP; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YJNoXkiP"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7E84B202342;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=YJNoXkiPZOmDOilry7Zm6eM9z4HBd4PJzAIEuJ7UtanH1z9mOb7YWXsk3Pmv56QbMocu13
	gbvt8eTg2T23b0PK19GGFX3/0n7qAurrWSI2JptwpbCT4JF1nS+on5xPWBQxKa2dsMZHRH
	xPOiIEqu5EHyZOHrlqmcYQvbCrs2nakRWjCs2q2VkwI/MU5NJCGlKrUN0gMJ0SG08J6GN7
	KAm9sVjQH80clRqxGyoWTHGL80NkZLsL9zg0uvYaI1kA6XHZaRLbXUycar62SXDZ/NY2DY
	PGnB+s6A0wdmM0D6rbQkMK+hWbQaxlTSLtqE2qpKVuoDBCuBvNStxVeUw66K3w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=TSLbdbtK4cyseJuVeE5sczR30jFgIuGx2KpDiksf95Cs87cvhKcZL0YDLdvYJ+8ZGhJ4D+
	tMFt7hAK0H7YAUaoZTvLQxeDY7pDQtyh6oMiIoz5oBMkheKNRtdgfkwq3s1OwGvQPnpIPQ
	+jyUkXYf3qDFhnapGh+/vd+nSupw4r4l57ZiJdehwsWAmjAE22awj9g5a4q3YlDeCB/JCZ
	XNXfXFm0vOVpvPN41QHOiG9SyjQcVbRMt8Kymt0bNLKJ9I8/E2JOJsRjpV+yUU7H4roVbH
	PTNLelyT3SxeatBlzTeGWJF+dnnPD5JEseaeYPkLIL8d2F2f7rhFw7meRcgmDw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=dsPxZ6D0jDGeE17kh/3cb3uHMoQaATVoJjtp37/JYbV5+zTYk3q8CvCURh9IOzibWw8Pxh
	uiDP3BcTrxwrR48lEoofGFYbiiBuf+Gvqn76f06HobV5jrVy6RE0ql+ixvNV5MBljrAlc7
	Py2qjtvGR5Qmufv6FXAAaOIrvH5us5167b0M+556qI2J108F1gXKO4vmk067ERWgPR0/OU
	r37grSZyvkfk9pMCuJ0jfMPVlZ/12rTV/4bZFzM1GefC30vczUNXxdb+4RJv/AKumzKqIB
	hC3qgWchpbuZGlJauS6yD9rA2D0sf0OFhj2jKu4umADAKvvAL6pLGvPL16OV+g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqM-1L;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 235C65C477F;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/37] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Thu, 15 Oct 2026 03:40:10 +0200
Message-ID: <20261015015336.816543-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

