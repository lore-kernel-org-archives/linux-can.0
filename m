Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=lnRI3h3fJDi7Leu9DjfubKCh4DxXix1hx5uG1NhRNTjSuatQznCaQPX51WBRWer6kmGX
	 +ax65e1zunZ8Lc0xN9tZuHUruXXOFs+IBRVdwD2ZJCMeQ0znjZm7G0U9e0J8XdeCGsFFj
	 Gr2SzO9QmZNVuwqaGyi6uDdwc6EYlZ3s5GRBWd8I9lXWET+Fq6yllrdLPqTVaZsEl1UTz
	 WtDaikSUnkjenXHzhFfpSFhblszzwV9fLYJgZUx9C9GPUvwOAtl8rr1Upa7iPUhYba0rZ
	 zK9s3Hm2riQlDLjh8olfpy1O1cc57ES6V4dSb9yp91qDcqgNizfhnOqD56W/ZEMZQHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3ATRx4owcSVrolEMA1XuhG833GVEwYzWRPpvq5JwrSo=;
	b=aX9QQ809IlhsYltwV3EWgzzi7XBPrLk5E3U5S+hoKcpzVCFRgPSd1qmC+WVH9rTcRevb
	 s9LX9p5HorXIMMKO3MP3sUwnUo5qCgkCXaOJTxOMVBJX1BD5dCpH7N5+tDfLYsJVRwWnV
	 RUYbxuauxdO3Va0EuMCK39s6SarM2UL8p/fnoi0GmgEABe1dBiRPsEyJ1ib+4VrkxxXE2
	 Xjjlghx7NPH3TiA6rhzUaobljrgLvD6gXxD2OKtCMUtHeuIZ2020zu/oRS6+q6JlbhC8z
	 Y2lk8OtcVdUGxEj2O9Lm6BAdI6s2ZRyK//VZweaaYUH/q9jd07Xkljq/5jD/xbCF0jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I4PH+pa4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9342606A899;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9342606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I4PH+pa4
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 46A67205A77;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ATRx4owcSVrolEMA1XuhG833GVEwYzWRPpvq5JwrSo=;
	b=I4PH+pa4PNAJ/V0nKuq0hH1DRWlu70tcj525Ge7IYv11rekMkMn2hfvZO+4YCZPLncpgmN
	M45OeifyNk3lRpPVTi81OXb7Fwbc+daLaUPWm0PTUpGOFVex2LMBIxsuAhlPXEZ+a8tBe0
	NgERg0UQkRNNUrOVM1cvGPkgBiO31FrP8bWIxlTSFGmQaiFBMQay9dZraPe98UJLExUFR0
	LwjmMDp3vOmCWMDWiqyIFjn8F4GkxbgiVis7xbRtzlY5DoqiSRI6YU6eQLFj68Hpd503TM
	XnGcaspTPO8Qyj0zb3m9UtrdQANME8UEPfUDACHbYFY4BSG7Er84aY/A32GRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ATRx4owcSVrolEMA1XuhG833GVEwYzWRPpvq5JwrSo=;
	b=KUyXCh/XimdLqCnJ+8DyYCtcyMI4SWsYtQPmmLHcADwjQl7wEJ1Th91BjcqU2Ag0i5Wbmy
	Br7G4upSeG+p3DsmDMu/xZlr7iXYGVuOcHg9jNuo9/qzXBruEp96mbwVCJtSj1WsD4mbc3
	61Gc/ko/VS/aS8Ax7NWZSgy2FSgezRG3X0ayJG6jnck44OOdSWuYvxgKF/xUxx3BpxSc1r
	nqfK3ogi8cLu3azKnxeg2ZlxBZB+d2t4w/rEeHj2RmNyvV5QDZcxqFH+Od6n8OlUR2/KUX
	klBxo5MhfcurZVJ/WQie4BYzOcFpACdr5C3hfRfQZu0OOproq2J2UoYeaCn3cg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=dyeik2pg9mBdMW+81wtlVsezId49sMhy3gz4E2em38xZdOcbTxPz3TSOoobi7Usg8GqfA5
	oXavJ2OjaNzAXf714U+ibIVP2WtNSnJj1KtmkF09POhRjW2NuFser0owvOoC3oBQq41/SM
	jwj1h2CR/d0O+lFrA0+QX91OZY6QjT0TRDIBeT2huobxsgz/3sa+4Hn2M/kh8i6LTF5Ry3
	BwUpodgZhxCJQPRIY1XLpg0wcAXoROHL6DKdBhnwD4AMGRiB7/s73VqMKWKPkxNEZa/ER9
	0/ADg+y4xGEdwjtd0uPpLmMJosIU6AusFEPAqrriVIpl8J0XLz25vqf4+GXclw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KI2-28;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 621E05EDC94;
	Wed, 18 Nov 2026 09:30:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/12] can: janz-ican3: don't discard the IRQ lookup error in probe
Date: Wed, 18 Nov 2026 10:11:41 +0100
Message-ID: <20261118092955.1283165-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
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

ican3_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	mod->irq = platform_get_irq(pdev, 0);
	if (mod->irq < 0) {
		ret = -ENODEV;
		goto out_free_ndev;
	}

Return the lookup error unchanged, as the neighbouring CAN platform drivers
do, e.g. previous commit ("can: cc770: don't discard the IRQ lookup error
in probe").

This driver cannot see -EPROBE_DEFER and the change does not fix a
deferred probe. The device is an MFD child of janz-cmodio, which takes
the interrupt from the carrier board's PCI device, and the driver has
neither an of_match_table nor an ACPI match. The probe should not invent
an error code for a lookup that failed for another reason.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/28add8d0570b72d35c65c19b2365007cf0aa15c3.1792118040.git.chaosheng.qu.linux@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1efdd1fd8caa..a65326b0f11e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1944,7 +1944,7 @@ static int ican3_probe(struct platform_device *pdev)
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
 	if (mod->irq < 0) {
-		ret = -ENODEV;
+		ret = mod->irq;
 		goto out_free_ndev;
 	}
 
-- 
2.53.0

