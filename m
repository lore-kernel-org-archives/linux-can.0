Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D834E2F30;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553419; cv=pass; b=HtksExtiH6wRxs1O1Neqa+SpPiVqweBrs1aOosDo3HgipEfqCyW056yEtSDWtuR1jxp8bmb7jGOcYH4wXjITpdFdFtep3Kd7VqcDkvhmzI2+jxFRtknvgBpE1Dhkxwo3MgLoy7fWbQMfIQp3hDL3bmtWkquc8Q1uYt8g4fOGzew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553419; c=relaxed/simple;
	bh=Ao3L2+Ue7+pZKtJ7MES2eddpZH1SQOSOAxD3Gdumu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbU3b5x3BGshTdrta4CbM039EIOFoYROYK6S/eIQ+qZ8tJm63l9Oq3XODDJdwJSg0ROQGYbkQMXW1KY4a5o/oaVGbHWx1s8fBVb2UrNb22JdItQ9bGSvcIBgQS8iAff5xs6wblO1GHumpudOiFb+UA75IrkJPytGFSPoavZJ2Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XNdAcl6K; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XNdAcl6K"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0FACF202621;
	Fri, 09 Oct 2026 15:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=XNdAcl6Kg0ASxU3EcBzwKW0agZ+5jpXu/mupujeKJgctk28tDJbP+t5eFfudf4B+k8qPuZ
	B6p4aQZsVsw5nAZU8zhe3hvuUkAinrr56jsI0/5hqzDhWqIOTRasTuW3Yz3cv/JFgUQVNx
	FM4ZpHQcsXBcjmVZDBXVMoiXuVyF2ClGDEa2PsIWx34kbSImVWTpFbBeFpiKDt7K6vAqPy
	YxU5WiJhHLHgX4NZBP6FgP66Hnyct/5/ctzZfFDb+TlKT+n4W8+d3NUNCdczxW9+Q3ZIXv
	jqHiQ3X5nBHyz7oIaoISEexgaWFZn7C3OglTsSayqTOIimgxxv6fv2yQ5MVC+Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553415; a=rsa-sha256;
	cv=none;
	b=IeUFywwX7uYu2SkeaMcy0KCfiNh1kLo5GK/XK2Q2VgbPGYMulisdwjMgXmrA1W99kDdpFb
	2qE7OMbcPSU71WIQNd34fU1ZAKyzkFFu/ETh7dry94mpfq93uQZuTvl3dFOV7bn5uiAuzB
	Z+5xu0OTAsZX8uEddaCLyD4TmXzro97c4VL///PcxhvyKBrUOkFJrEfld75HxkEe7Ief2C
	brRz8rqYJeJq3xDPaTPZDDV0Z7J/ptH6SAj/TyjL8DUMeagYQfqchV3TkExEAAG07PdXir
	yo+V3eEeomZ+KiTHF9TS2y8lRmhZa/kNKwnyAFhpcz3pw8vygweBdDKmcTaCAw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=Bix2x7t/AOfG3LWTdEW105HlF281Hn0Ga5OYu27Ddzxm8vn/okCgGq/u2jGjW0OyiXhSTT
	2cYycasB3jrTNWqx5QubcEKcHRZzBp061ok8VYOFq40mbcs4j3Th730zS4jBzeMICCmUUX
	L98GlmJMAogIUQYrAqBnkf+DZmZJjCIpGkFA0Vk5TJn5A1M6hvlspsOSYAmsZ+uPgrDCHV
	dX5x2USO4EKKdD8qQMJKNYI1vWn1mAtwWK9fTKudke0ejycwVyDc7Ew/ciFDSBLHR/8j37
	wAqVnVaMELdA5N6tcAh45NGFFukBHyxW6L9Y/c7zlCSt+VQHFNOsxaF5+APBNw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAso-0053SG-37;
	Fri, 09 Oct 2026 15:43:34 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8C2F45BD8B4;
	Fri, 09 Oct 2026 13:43:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/37] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Fri,  9 Oct 2026 15:27:44 +0200
Message-ID: <20261009134323.64064-13-mkl@pengutronix.de>
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

