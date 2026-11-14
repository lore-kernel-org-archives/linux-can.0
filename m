Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661041;
	b=f9jGZLVuq5vIR5aYkmGKlDz231ZAimJKp23uYIWimX2U7D+7CO7SwP73CnhSWi+vIL/H
	 u3An2iWGbyqPLLIJPD108OTQ9WsR2CqtpfwT5DFzkgL6Q+VkhM32pudCr78aIKl9RzrNx
	 J+OeqNSkrYKL780U/Xu09EPfA/i9UUST/lq86/XBqYhUdyUhL148i3AfBcxJO5Col/ehz
	 25CrPOk5112Qk+OGc6+Mqe11xeaE85/wT0XM/om0jth46It9lr5y0crAZQGHV8jJ1f+bO
	 SfGVqdRQZ8FaGQKFLgEQFpvS0B6qVnQ/3CgEOHMNKCg0WbwHJg8Ec9HBaPkKM5u3CtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hSKOO6Nyuz06WQcd4udwKSIXDiIXsiKGhV8V9XHa0ko=;
	b=rURN2UQ1vH7MRTMGtrCau4kB4KJ5QXtQiipWo0yDGwzYwT52SQPic0sY2jj4tE5kE+rW
	 RbRPpM/wTKujAGovVAGsHltErQLIWbxAh7lyoYxzz1c/zTf4fQP1ThmW9EENilsfc2aJI
	 UPkf/NB+HShk6rGmdqg3V78HFUUz5ZrQ9DkPaa4qYokRnB1rq7mpACqxQijuZlj2AXg4s
	 /yAxOFhwQjc67ijPMjYLk33ECBrHjXeMlDzTznTnLB8G12xDgR5Yoa2GLVJakZiWcuE09
	 wkQSW1o2BIQxE0fpGY4VygqqPXwarTfoQTrvzm8wiudliWf3ukoHFfz7ELHaRwmWsYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=X4lNHg2j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800C606A32E;
	Sat, 14 Nov 2026 12:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B800C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=X4lNHg2j
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E216F2022D4;
	Sat, 14 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSKOO6Nyuz06WQcd4udwKSIXDiIXsiKGhV8V9XHa0ko=;
	b=X4lNHg2j5MO1EqBESU9stJ6LCvzR7CdKHiRhJ7aAk7k2oVshweONge5HFLYeKreKbw8Psv
	pxPbWVUt4dNqHfJWpajqsEyuImSkVbDXiAE3fVXtUl8KV2IIyhu8s1H2XEPHSvGZCKUG+x
	FIYSnI982lc3tvSh/EQ0BjChnBbNqFSlyU3kv+8gCvJIyx05j9xDCwsAwlQw8x4IfT5yZa
	PcGHpASJzlVOo9zjQ+9kO8Mt2680lMeiz4qWrlHTSZuuYX+ZVyG18lG1ec4tU3pOlHWCow
	oAEzoqcVC3gh/dlkdUDOU40gCShewDyQE5uGZK/Bq1yYbld1IFszKnlL6diCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSKOO6Nyuz06WQcd4udwKSIXDiIXsiKGhV8V9XHa0ko=;
	b=RozUsurT9mdVeH5gGj7VPz+8z0XE1UNakouVgti2SWGhv3dlAjGVyEihaOcr6RgaIRZLj8
	R+a1NZNA3Wo/hNIeanAuSjbYdiCAXsOLvGQVN2qIjZzJif55+dO4pcdrIx+A3KdONbrGCO
	CQ2DnufSPLs6J3zn3bS9PFR94HUCQ3ssjgYjQJrQFyB53S0jKRLQPmoUzZIBPSrdu9+kGA
	I8y31CaT3kqOGPYrxDDRt9HvmojrFj9vTACPrMfg0N0wDWDsxge1V8RFcZqs626Jf4jYuv
	pKVr9mbgt92yggR/l7spEijo78y+nfKZT5augg+UEt53hF1MXHh9UTx9DeuPLA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661037; a=rsa-sha256;
	cv=none;
	b=W7I1jleNyZjdnbfGp/s2ZjjPIHGP7NH/TeM3vqkN2S4K4wFkOqeWoPiJPANKkgL+0VVh91
	5JoAeK3Kvhp0OOtZGeoCU67rvCmGP0gu9EU3KbMXb4YYup7UCHqRLCA7UZ4312gWtf9D3l
	mJQTRzr/ce7pTBHPEsk1qgfYOoCGeTjBpAhVj/8pQSE/wXLOO51pa1ubvMZHrHU7fVN4rE
	MxJw6MgTkZV5pllNP2DRK/ZCY/QquJ/ZjHa/U0PsAcCq5OJhs/MFqe7kVj9DhTM6ELtGAH
	BzXCIk+zmqc7PqLoobjoSNDVb3bEGe7G/cPE99Mz6BJEMirpePfzvkHp57LQuQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDJl-0048pT-2O;
	Sat, 14 Nov 2026 13:57:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6FBAD5EB9A8;
	Sat, 14 Nov 2026 12:56:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 13:56:14 +0100
Subject: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-fix-device_get_match_data-v1-1-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
In-Reply-To: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=EVtfv8H/r2eSuhEBKDPovFiE2ZB1wfoNr5NIM2DtYvM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6EVUo47xIk+PUTM6Y+I/qxw+vXls091f6J+WS77s/7
 +zwqvs/qaOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATUdvK8D+79LG1ZKF8q5zw
 /Buh00tVl5y1jPxa6Nmo+DTkThNbwRJGhj9HC5apr7oh06qe7/IgoXr2kqozNXld3Y5BPsx7D1o
 IcQIA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

A device bound through driver_override need not match an entry in
of_match_table or id_table. In that case device_get_match_data() returns
NULL, but c_can_plat_probe() dereferences the result.

Reject devices without match data before continuing probe.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 75607b1afd2e..b6012cd713ce 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -266,6 +266,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata)
+		return -ENODEV;
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);

-- 
2.53.0

