Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126298;
	b=rv8pXisg3viQ2XKmUrzdFO82bF4+M7q8P/t3oNnaCUb37M7o2eqJhxjQh4C3GyEB/GYW
	 ZDsRYBaB2Ph93IDYA01iOrJvBW8b48ZThcGhgGrVY6ocSzGLKkHzNMkr8HLZfXhgnwuw8
	 yWcyvI6Lj915wC+zNJK5KF2OnlEhxLeUZxTZNze/T+AIrAHFhd1Xs7AoaZJKCsDcYb0FL
	 0Tfq32OpOk1hIFavvevbKYdX86aFgg+JT/11HxHEj1JAs1lVHdhKntbQheQm3h4l6VyU/
	 9TeN/dfmce50+VUv8X4fml+HGxMbXE7cWLDuXacYxlN/wJBzXnB5qSnsVSBJ3cTgI5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=fCb5IoDInqUBJ2Zayp6SNV7fZG/tAjeI7UC8bXVUH/V9wbyKKeMMvDDA+/hepNC2sTIZ
	 wPRFN5WcqeM+V95+NfK+9+FAuX88cRUFe1yOWXJNiAo3AVd85O1onwUUkAwca6PVKDgnL
	 mqkhYVnBtZiOJY4XLcicexFw7HViHORu7vtMfJvZGW3EMzVqNH1ONNi2kGuZa6Q3zvk6z
	 7lXWnR/mIZCv62i+LI0lezuXimeTnY8J6JGvTBRgSb4UPYg8YYP3Qi2ONwwWsC/ETO+Jt
	 M7rbcVX3utRqN3ijyhaLN8zmNORKzIQVuKtNwFzrYTp9Y2L6g0ME7fmbzXpmDnCISng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dhEXtCef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7760A2613;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C7760A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dhEXtCef
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 40145205B37;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=dhEXtCefzJxnnFC9OISkMtGKPfu590F3PZeh2dZhZWYx4Aew48VDUO9egIdu4Sa+cPr6pU
	+JtCAxJu08oLnmfEvoSzqBPSqhkOaKJ7FZA263rKYdhm2Z0awWvMV0ZrmAOvFgloGNMvN0
	GU/s58L08udV3rbhwZy9CAPiDtj9NozZ3HR6fc0EGUPf3r1j3YvIEK7i/lN2Tl2hyoiz7i
	+05swsUJ7MjmrgXIgRcKmhgqfIiMGGfYs1NwSVUz75Q3s9+IaRp+FRqc4Oi8edEr/2qWIi
	xVeJWvfNGvzEN2MOSl//xeP7ZiPM9KE7LmLjQ3cdq6preG2cUx1Uinxdant16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=QXA2/ARf5kQURjoL7aTIYlJ/TGbS/4o4bcytpxQ97j/IlkXfeVrtoGazDkvPTXf0IO10om
	id8Wa704LGaLP2Uy7rD4vPELdmeLurScrkHiKRZQi296KEbx1MDWDFZIvxD95AKDabpdH2
	eh1ivu1wUxTFoxPP93ompZqW+ta6wX3kTYlsP61D0UoQFcFah0ZSwF1za7TbCF0Ls80IGM
	RLIUIPnLbwHhhjP5nup8c82mz2ysxE2Aotxu2kH7QIbuaMlfc4E2nY3KyGCEXEgCuBxqiq
	/HwcJq+G7UhMN7YIsw/Owl3EHLcGOw8MBxeHXku3T7uQ0dTrCDhMrOxzmDJ0ug==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=GA7B36BZkHlOGuhQ4L3IuSgvZRyOif+Rv3Ok5sqaTI48r2aTnCUujWBhq95mR66rsrMWG2
	pyfvTSO9gIxH/at9d0J1jDqzk+y+udrzC2V51VFbFCGbzwL4E5D8LUp/BaOheK1fVgHIQK
	tZKNBudI9+SVnFzC1vlUkfV+6U10QysQn40oNKj5t0biGtqus2NafD5Jc7EYq+RYsQ5KyG
	LK92OUjwIEZFZfbs2u23V2mMCFcYlhU4pKPgZuWuovfznqzphk/bdjoZglHEy4vm0RR9Ed
	RBWU1TgDqBBs1jXeg7n20jRg+qNrPho+Dp3JmS4ssICReDhmFHMza4ZQT3nC0w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6B-1u;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D8EA55F0999;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/13] can: cc770: don't discard the IRQ lookup error in probe
Date: Thu, 19 Nov 2026 22:58:42 +0100
Message-ID: <20261119220936.155728-7-mkl@pengutronix.de>
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

From: Chaosheng Qu <quchaosheng000406@163.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

cc770_platform_probe() collapses every failure of platform_get_irq()
into -ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (!mem || irq <= 0)
		return -ENODEV;

That discards -EPROBE_DEFER, so a probe that has to wait for its
interrupt controller is never retried and the device stays unbound.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers already do (c_can_platform.c, flexcan-core.c,
sja1000_platform.c). A device tree without an interrupt now reports
-ENXIO rather than -ENODEV; the driver core treats those two the same
way, so the outcome does not change.

The memory resource is checked first and on its own, so a missing
region no longer triggers an IRQ lookup that cannot succeed.

This patch was created with LLM assistance.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20261009105556.301821-1-quchaosheng000406@163.com
[mkl: clarify commit message]
[mkl: convert Assisted-by: tag into prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b690167c454f..c714a80ffd91 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -156,10 +156,13 @@ static int cc770_platform_probe(struct platform_device *pdev)
 	int err, irq;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0)
+	if (!mem)
 		return -ENODEV;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	mem_size = resource_size(mem);
 	if (!request_mem_region(mem->start, mem_size, pdev->name))
 		return -EBUSY;
-- 
2.53.0

