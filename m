Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554013;
	b=5hIG0goVAjKb84CjWOglyDTOg5e45eXtSChfRZWSyLB87YkI6At6tW14JeTbfm1aaWLy
	 a0Ro1KbTgUKkDgufYVEpmwRe6EnBg2uu7yFrxsQI9sTmInGLEvsAqr4Kv60akcqZ+X4ic
	 rrhxdll5wuVRH3QflwPTdHYx4zCgMWzG5tQ9c6+RJD1lL5XBfzc7QWs6vFmJo3T796P2+
	 Ix6gXIHxHpgTkg52zqaA6zpozBzZoEdUoYYuz8u0pkxfMz7hRwNyJFnr1xaNfUYFXsJmu
	 OGr1OrzsfvM5hPxodiuOzPxTxBy8hoQZV8ca/WiZJ833MvhWMVd3vMy4QduHPi1V9Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554013;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DDjxMiPtX/gVOOex6cbmPXIU6u9rIyq/QCbL2aSKAeU=;
	b=ZwygIIoeWHw5nyN4/f5rp+WLlMmRW6AvMD2shcJUR2cRxXyIw6zXptfp55nrZVPdSi3K
	 4gJGxN7DCUx7vGJpBeZDv9+GxgEYDXFnOriWpVbvXmqTv8C3MQgVsTsonivuMmJeeW1TD
	 ZTJzfSfbVN35x3D3VpAy9x2hAZeZoNZgAK1dIbF3TywKcu20HfzT1t9W7f+Nr2OaNByG9
	 mHAH/iCFIibKUFgKzjKKwoQDly5TxOzBqUzu0+QHzfaHMIpY5ODGMgVGrsseO+1JOzwUS
	 38+EFGaygRZupyXeinc7zkKh33dyNPLUucIWsqkM/dOjh7XwkWS7A3GeOMeWg+9OPsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eRw799FL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14460A5BD4;
	Fri, 13 Nov 2026 07:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D14460A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eRw799FL
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 39AC8205848;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDjxMiPtX/gVOOex6cbmPXIU6u9rIyq/QCbL2aSKAeU=;
	b=eRw799FLaNl8u6ipzuwxhLlJJ5WlgJOAVkAcUZbwoSi61GmSJNuH3hrB7Lx/1djlgvNbHk
	a03KTVgQnCWnT/Wgkr4r1KL87i0/a1d7Z8eEaeCBiLNQRbFmNCYe01uEKqj4Qi3AU3lamu
	T8Qfwpw+26vKljmMo6U4UJTcZVJlRXBelPbVvqJ5QY02otUYZHYmK0XY0kRNr9mtckjs5N
	vfkVo2RFi5HjULsZG/qRZ8Wjg5sUgwmigiNv51QBwWdmJSXOuMm8jrmVSJue87fBhjbdd0
	ejfT9CSQzXrqoqy++Z0iU93VF2C1k5v/2TTMh+beN6XEb+D/9Os8BcS6mRoS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDjxMiPtX/gVOOex6cbmPXIU6u9rIyq/QCbL2aSKAeU=;
	b=FYwVR0Nnroh1Iu6R5BzRaX3YCCaHI0IMDkVpM+uJX0ziaPmUKurU1muNlVTNBK+iTi3XN7
	mKjOm0kLI2Y3+gAW02Y7Nq0HKa2kANQ5OYSqdR95wJK7lGA/B0VGhe81TOUvY2MspSjmD1
	NQe+mmJTC3QYSIvfs52wsaBUsEjTV4Sqys1iGs0O7HCpTQjN8+lW5btOz0wV70WahmsMHQ
	G5YLfXox1G3DtJtKpxxQSLYXmZdz6jdOcOqB5GRz7j06vv3/gvD3ddK3kfoYF0musuHCkk
	X2sWnqE0pH4fxJgx/dVWCjTbPWWb2/ofqh7Je2JBWsmGmTP/HLmE68Rmxt4pSg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=DBsq81Wf3aNuzaDNJQ6KRM3EmHcAPiHugjt/0IiG1M05kGUN+qoBYFRFXzhZ8b162qvDZM
	AmG6JVu86J4Otm9GqhT1YxSopKsM896nVbo+o8M6K6zLQzhLZJmj5FdCbX0bAwr0Los/84
	0THMTG7UO2gBWqIXqoR1qmHN99xL6cL/FOjOQcHKhNHp1FtnLdXb4HbTze5nD6vO12WK8U
	n6tH4laa8Y1QYl4ymP5mcjZhvttp/ZJqmcCOXyS6Uvtto6w/XIyXtwV5OLj/9OSMDjLcns
	0kdWIrXkbGCm9dO6QsGANHHo6JOMLJtmg9PhxdT4JIamHVko1tsM5CKsI4vE+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTU-003xHz-0O;
	Fri, 13 Nov 2026 08:13:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DBB4C5EA57C;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/7] net: can: grcan: update the binding file reference in the driver comment
Date: Fri, 13 Nov 2026 08:08:55 +0100
Message-ID: <20261113071325.4092169-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113071325.4092169-1-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
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

From: Quchaosheng <quchaosheng000406@163.com>

grcan.txt is replaced by aeroflexgaisler,grcan.yaml.  Point the comment at
the new file.  No functional change.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260929073703.2748220-3-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/grcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df56d..1b4944d1d06d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -10,8 +10,8 @@
  * Full documentation of the GRCAN core can be found here:
  * http://www.gaisler.com/products/grlib/grip.pdf
  *
- * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
- * open firmware properties.
+ * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml"
+ * for information on open firmware properties.
  *
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
  * sysfs interface.
-- 
2.53.0

