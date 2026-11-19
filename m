Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126297;
	b=C6WhkW23qbqr4TQtaT+RlfxgN2fzPP553l3rkfMioTruRJlyuWe+0xgTEmoqum5L3dE0
	 BnHa5J6nTp+oQoGtRZsQsGbD7/gIX12GzUpuHXCIo39Pf5gjoc55JoEuWRGPSpN+sYMDX
	 AYCcjXzpLNK76N5nhXJglnbF/7ws+zYHEMakxrPIj8P35Pt50CLoh/feN7YoT+uiFn9aE
	 VaYYyA1WG5/BSLetMtwf3CsP90DZ51Z3WJ0kZN/uA/PftTu9E26TdRFyHFdjDDwIXt0oQ
	 WCFtAXFCElsvykcgkPCo7Fi0TEbSlT5RG/OBhrAaOL/Sb5EQdHhSKNbPHIRFVP/7VSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k71rpuYRBuO8uH8ETEjRfXzqXKKSzwnW4lkl2m34HwE=;
	b=X7BN+U/HbgDda+afITOcx/S9xkYtdTUyTCzuoeEOjwmyak0xqjFk0vmOxgMJvKY7DGsf
	 /Y6OyPQnJ6LgI0U0D9EeCgiX/clFEFH8IwFettEQaAvORXCK7CmSd5OlU37vdSqk3qBYe
	 qMvWi19uY9BmxSYJ23Fl21uAok8E9tzw7ZUlp1ubqWo/HdAucPRvTHrj7YBotk/YOXbf0
	 GAmp2Qig14GdawIyJs7RK0IfMovd0CEx9n6PZVgpbsJxtaez2gAs7a0gzxnTYczWM7cgQ
	 0zvsaHW9gdPH2yzmi/ubt38qjLURvamvImrJVPUW95SScHxKnSc3XAWoERIY9gFzxtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L8OZV2+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1E60A2611;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C1E60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L8OZV2+S
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 544A1205B3F;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k71rpuYRBuO8uH8ETEjRfXzqXKKSzwnW4lkl2m34HwE=;
	b=L8OZV2+SCgtY/6Z1fVPOhvQsi+0LpIjlwPXsXoygi8O/YDtJpVN5Nmj1JXK3emk/6M4mwv
	jb1A6+U7eLuJAhMuumh2olM9Q4jtppWN35/5MCV6Dv4/Iwgms2SMQzydaFQhym5w9s09Nw
	LdgBf0x0iPC/xuYh5g1XQpBmp3zMIKEp3wAgti3l7gxlYtDTD5UsVvKcw7avL4l2MFLtV2
	g9Lgd+A/qGH/Q+hi6HwsLK7tMM1Szdz9RHpvaE0XYUYGCkp13T4J+uNFzC6z4/vEeSnSOT
	YZWur/L4s93iGoBcqvwldJsk7dkVCMrKPT9K87RJGQw67x8EH4RDoiku0Y6v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k71rpuYRBuO8uH8ETEjRfXzqXKKSzwnW4lkl2m34HwE=;
	b=COt4rFvBwGnQo4Es1Ko/vFrXT3Bx1KWO1xWlmzWDwO348OyEoZ6gQBQ/8UWLQZYcxjJbem
	Zx0PNCIx5it7RQY6yc59j9miCDw5paYLQzVMeb5bFkgEds8fJW5XP0MPO199kLiyWydQHW
	kKzZavwmEuEZm1+WBy1TFKKp7t8mQrvNwuQLD9rh8aTSN/Yt6KKVekQzVvrMoLzyn9WZS4
	sEHP0PMgbVkic7s8u1MDccadi3ke0O3FmIquA+vWZ9euF+14tr4UcYJgSzwDGHhlV2Bd3P
	rZMAckcrW4V5GhfivcSAEGmJWvBbRNVIjb79+Tr7diAPK6GUHVacDN+UuX8a3g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=NV/8vqnv5PumCizZg1JTedmz/MQTfo4Mdq5GBpR1ttNypTzcRJs6f9NwrETrwMUYtfHjAf
	pVsrerBZm5SiSr8A6u19Njc7w2EDoqU9DTxjkDg69v1z9/MJTtZiTObyZUFte1npuVELAi
	+lYC5KzIW9j7ogyESfuVMqjb0Mva48IBzetXr8jLyyuV5ViDXeIOIn3QUhV6CHVMA6gihQ
	diHFSGHnqVGN4aVgfkWiMsVlSU7cSba3lERqO0qCSiSd/6x/LqD/gglcBi75uYWnD++qSZ
	P2mpm6O/rTmq8KcOMZkDsrn0ts9Ba6KV+X4q815p6GoffkCfym1TGJyaLoW61Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6E-2E;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E9A6A5F099B;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/13] can: at91_can: don't discard the IRQ lookup error in probe
Date: Thu, 19 Nov 2026 22:58:44 +0100
Message-ID: <20261119220936.155728-9-mkl@pengutronix.de>
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

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

at91_can_probe() looks up the memory resource and the interrupt together
and collapses both failures into -ENODEV:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	irq = platform_get_irq(pdev, 0);
	if (!res || irq <= 0) {
		err = -ENODEV;
		goto exit_put;
	}

The irq <= 0 test also covers a 0 return, which platform_get_irq() never
produces; it warns and returns -EINVAL instead.

Split the two lookups: the memory resource keeps -ENODEV, the interrupt
returns the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. commit ("can: cc770: don't discard the IRQ lookup error in
probe"). This also drops an IRQ lookup that cannot succeed when the memory
resource is missing.

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/303815792800553c34842147941cab083823c212.1792118040.git.chaosheng.qu.linux@gmail.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3977de761636 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1069,12 +1069,17 @@ static int at91_can_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!res || irq <= 0) {
+	if (!res) {
 		err = -ENODEV;
 		goto exit_put;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto exit_put;
+	}
+
 	if (!request_mem_region(res->start,
 				resource_size(res),
 				pdev->name)) {
-- 
2.53.0

