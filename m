Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126297;
	b=KxQl2LBCaiCT4AmYN+hpnmms5bO0d0PYe9KEmM37kKhftC/GCK+dmNQG5vy4nlpNg0Wg
	 Hg6MUqyMSywKsx7tE0fPXocNroLVjJt51bC4LS1S7jPx4igE1Ufapva0qKW99IZBynOXX
	 RX7/l3DcO4v+0dyyvlixiGF4UKsLnTTIK8l7plYcGZw3CuK6djWpYO869cVmkEUbRq7Ba
	 F9wRJO0sZ4ofDLopNhB+J9DveoAXvGTwPLABiJZhXXW+yKXArarY9EEsLDX3bLQuUJE1n
	 g0DNB98ObtRORw28fwjEKT7pxT88rTXh4d32O1x1j/JYU6pyxlcEjXgcOV6UBpO6Iqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=E3/xI5/LdmSJKMVS1qcLwew7N79NpA094JmmfPXXQEmCvyKBQh1j6ppQ8tbN8UFaIXGz
	 QchvD5RNla+hKDnchN825nExWxgOmEQam2b1Rwp4LcU3nfQJ0F+Wc1f7ddyPN4lehzMFf
	 Spz+f3qNwk1pe1O11QudCETjiyaHFaPjZiwSzbbMXhiu+Zx8XdJYMKtEpLh6oMWVRacvP
	 Vgg4FdRctUj5gUM69/VwcbY70nhTIYtW5EPGE5iLmd3TOZfIT870tQo02FlOb8gUp0ttJ
	 pYv/tibaNLnL1Vi5w8oGlWENgZbLjjsty96SHm7X+mf3TWBsmyvu1RnKaMlhtKkSoBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VbSEC2K9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DF60A2616;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593DF60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VbSEC2K9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8DF5B200878;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=VbSEC2K9eRPlnk2UYFcgkkqHqyhYNroATxeF2jtgYn+5PWezDMNMFFR/aIaNX+TGuwpRKW
	/GgW6PVl/2qXgT0z4wjMzsAhw/lY8vsG9xB+BxARvJ8OBQpFXAByT0TtiEuFXdWShNtw16
	Pg3UMuxi7nw68D99cTXvKNX0qIFbn8jmVjYO4hoN7Eebzgt+ee9TYq81ofU9KLThbyq3ER
	FXH8t0Vj3uEpa7wzZcWd70/Y4JFj7TLZzKHbMoGlhR/4DqJ5DpVl4TQ7+zO/FPNg1P0Ht+
	rZL7WPZxOrnTjZFp2L+uY/f5iS2TLaqWYKO2wzTGUoBIpgvf/PFNvhEto0w+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=AnPwVDztR4gsKhSmqoy9Gs/K8d/SKxogXYhwD4HPMfxLMNfJFn4QbkoRR5XqO9wK54qCj9
	dR/ouaTTQDKxBnj12BRxu9xukgQuVVzqvfV7jm85bu5wUp3XEwztc8zo7g2R0yiBHOJtyt
	T0InRiS5psPmvROGisC7xEq4wT5GB8reMA29xkVMdF9uOvVF6YaYNGoWXKZ+Fv6vl/8C/3
	8YWs9dMD74szVXiX8C1MIxzu0PbMGngKJrLjGBRLu8hlVh/dvSuwI7YcKo0z1EMYtit1Lx
	3z62vf+F3ZgjOiyXhfYDaZvg/vv80+KQici1DB7+YQSR0Mkh6Ljzo2S5DOUN5w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=X1Uzx0KkIqUIIramOxU2v30OkbpzxHRs5Wocq4JjIDVD3I6gTXC998u99n66s5KI6saXAX
	BxP+fsCh/wW1YBYaMkofPe8jJsRKbtIcY3uaqpxvQ7gmKPJU4EyBsTbLK5wXHvYjhRy5xb
	/o1OlbJeJAunujfI+2CYFBA3tSyIYWY/pubdNz3hLVUHXxpZaRYvzBfmH91V2dofnTTgSM
	/OOXHqhSRZhJBTC7shHP/bUQNIto+cw8k8v6VcueKYymv9w/Ya94wFKQI1DVxYBsTERjSe
	7l1SMzzbpelWSYpWKI0F31BjBNRg1qguV7oS+2xxX0ahHOLHcmPDGgj+oplrHg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6W-2z;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 39ED35F099F;
	Thu, 19 Nov 2026 22:11:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/13] can: ucan: fix repeated word 'is' in comment
Date: Thu, 19 Nov 2026 22:58:48 +0100
Message-ID: <20261119220936.155728-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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

From: Hemanth Selam <hemanth.selam@gmail.com>

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word. Only touches a comment, no code changes.

This patch was created with LLM assistance.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Link: https://patch.msgid.link/20260904125018.10923-1-hemanth.selam@gmail.com
[mkl: convert Assisted-by: tag into prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index a50e2e7e48a9..744d5ee5ec40 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -61,7 +61,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
-- 
2.53.0

