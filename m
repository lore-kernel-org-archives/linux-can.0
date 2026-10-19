Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429730;
	b=LzySTlpgmcMt8SlCpth6Ds3fasmrpNuv5VWLY0XEUw6irMrBBOaQS6XIvNA1eBB7molv
	 WMPsRl+LzZH/pZsVjIY49KzmUBqvNxG4BmCYNptqbJGMaPFz43OkL0XltDjEeGUzoOWw/
	 BPXoDHv/HRnrBKSpBViKGOo+K+efA0R5LDI9GbobaMJiSYFXRsItWoYKE5qPZLpNPyWrD
	 r37JsIUi9MJmZo56DScBGPlWLldiv5bAxp4cHtfmdH8FYDbzxUnp8394AeAs6UMt3NAM8
	 +FSJ/LzPdHwLAAXAe1k2EVYM6ZeK1MC5MOOrS6Qc0OgWIYlOs6XF0Y2wqJViY6kYo1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=CHK9ohkWEgpBkRn7YDZ7pDi05vlFhdC3NKrTrTqdN5NaBOrBtjgfD0MFIK/yDG8Iq0bQ
	 ZrkK+JiF+5SyhV1S+yTHbi3WlR1LkS1Wv0+dk+HTl1fN1CGHpMsBzc67ZM62Wazcq/A5p
	 E0V0HrONqVjqWd8vgWWV/HE+u2ZfZhcJgl1/ATnMuzHaACPMNPc84A0EDttCUh1JNH81x
	 NNN+rnfqPkRGQOPQIUO1SBiD+XESQ/2pOBu3lX3vkGOtvWDWElAbvOSEG911g27FNgOGK
	 sNN9pubzc9PN+Q5JKB2sFx3FAdcLglZzNwGEtqLu4oYKtvO565lY6Et5sOHmV1leJyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bfE78CFp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D2606A31D;
	Mon, 19 Oct 2026 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39D2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bfE78CFp
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E4F3A202853;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=bfE78CFpdioZ0sxLlUhxn+/oCS8FdYCNC44GyqpzLvMSFzKz0IYYVfDn66UAqsHQHztw6g
	RQw6dqXPo+71CH2lN+CssIJYHq8Lw9yOjyL6vHhsuWl6aWjPyAgp/V2bUyo9KODUpHUuc/
	bK7KPXb70pFnnYtAu/6iASBPxiyDouQsZOsKbuER6j7rHzHSuFE9hy1UXAt04ItLn2LCkV
	RUB0FpctXdV6MKpkyTwVcWfxcBtn+jIzzXfUooB+3e8HciZ8cSIuNSII/PumUmaLLvtEu2
	t4OSTK0gefvras4d0UbTJIN2qFJciVYrfd9d9emyNgxnjnej8RHFiurr/vwlBg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429716; a=rsa-sha256;
	cv=none;
	b=F0kKJK8KFsT9nm0wkaP9spdczDIXHDUZDvCukrjly3NkDPt6xCWxWJDmr1X2zZlk2LmWwM
	A22CSS+3Viu2DrUP5VD89M414nLTlBpV6iWHpG/2594Y1ixxv9OzsKgFYpfrm/FVcQTE3+
	859ezGHuX33URZDwlJRdVJ3u3IUEcOmEAZ7pPyZ7UuOm+rKrnnWYVKCDtEOzMHvnIobxkN
	IeCcJ6d1mgoWCtVLptxo8+NAzA6jO9mTCJ8aXslY18cEC9U401wZEB870rTdI8aV7JTjYi
	dtMj4yov1MXscjkkXJMcO/spOY+QaGHYJfrtPo8jHw0fXjX5ekV0WFgfNBbPyg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmBq+kau38eq8xUhlmh08YcQWsEHQ9X5elckRx+lLtI=;
	b=YoGhmopcdyCdHwYbanFqj3SjcV4uievLbhAz8GeSoAh44IdJCj25ChNoSDETXxqsVfjZNl
	5JHTNisRYuUvJlH6+CSGF8yBE0w0z73kQB8Hw3nyvaTM+Juu/FO1MqJ/QjfGsF4HwfpKTt
	B/XN7hT3tVuvbaBM9smjrkBEYCkAjY00K6xwgM1ce2QyecU7KLsbRnblRMH5RkbPDAQxgk
	5jCkN9RFSOq/WU4i34gnGBFpENGP9/8hwrbDkXZyoKVfMhdP9trVQTL20e+B3Vh6meRT/i
	fT5elEzpdfeW3VkSGvOBltEdlADcjbP5PyRaCrmdB/ql5rQozpFehDRwdESSRQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000FgC-2b;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 887E65C948E;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/11] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Mon, 19 Oct 2026 19:01:09 +0200
Message-ID: <20261019170834.1727150-5-mkl@pengutronix.de>
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

