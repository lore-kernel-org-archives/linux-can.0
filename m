Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=F5MUZs/Y3ePnFVMlT3aFUQwiZtXXyFFhYauU2s40xsn86j6rwhLaiPeuv0lMjs72iyVt
	 rf1/VHlhTAS6NWZVrcxbsf30e2btroJvsn0omhb9uAoywXnjGY2enEDs/ojOc2ua4cDZD
	 PPW5gcUGTGJ5yk4AdLjaoOgwm0x60rfDtN08s4EvHYOnsnazkDY7XRGI9lCg37UDUq3Su
	 UY7GUorH+GUoI82cS5LgjapeZGtDrdHI0d3HxQufq1kYzfdSfeezQYZGjxPZ2z8tVrQw1
	 yNi1RZUTeMGuAIXgjhp6edq4Oi22LTr4bCnxMCpLBKdVa2MeseEaZGrwoyR5sQLAJmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=frAyl3lxjYSIgcTKo0n5SWIV4HdT67a3Uga3b7AkstJA0JN448fnU7P2HfIKwgc8on8+
	 T7QcA07uJPuA/0RjUPSB8r8cSlIbSNwHD/6DC0SJcAtQ3t+zzMI4YYw1Wt2CxLpTr3oHl
	 ZyJCjh0y/3KVUvxyNNU9sO8986K4GQ5GSnnPx9zNixX/rS/weZ/XgfixqGrLAtxjAv2to
	 9yYtRUF5L7JC7IBBhWAug4zYVdlYxGN7wYPVgSIksKe+yoZBCEAFqmQ2Vg81tqsTGQTzJ
	 uzBH++59LO8zOS6jDJPzLO1Y3PyGBXrpSF+DzML5Dp0ZMJIrvrXjMK7U1V5bFGlzw4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VoesevXO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED652606A32F;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED652606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VoesevXO
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 74878205ABB;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=VoesevXOqonLxc49/vgJirUgMlbCO1CRWiL6Lx7GbSpK5pveNxR/EE+8Wt9rJF1+wEjdLd
	Em+IkmY8Kz1vFjrum3b1/hT7kaDF9/PQIWkTRDon6AEB194D8WYXkz9pU1pL7c7PqJZayv
	inANHNq2dg+FMH6/8e3YDsgi4iXJKdqhquqv/CIIVGiGBEUJv1zTnveHEQxtTi0T4/Fk7Q
	AQCTQollxyBD98oMWHXFg8+XfYEDAcnigEoy1B2NbKNHVne59jxTV/CJ5+3sS28Yn8CQJC
	p/2hnA5nw8yjsTHtfvyi3CUgnzWSBq0CIdTLT4u4jGBiObiMYxrFj66Op6cRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tLBYIk0WCP2/xC5iC2gFzcK02rf48UVepeJt5b4JfU=;
	b=HcYzI7vGM1H5srPBimB2RM5DRb7onTboCiwDGBU00YpMTod2MZorp05f6WZjFCAzHOVF8n
	8rqtwHtCKVyDvjhC0SP3n9ixUCPx6UFtasGBF2T3Smgmtr2NI/R2xvXSi0/9YbSVSdYSOP
	vhrEZdO4WRrRDKiKz2w98USlHv7QiVw3Kd7xAFxFdV0q/9v56+C3vpMacNwT7PoDYPuSDH
	F3ljgUEvOAHj8dRhEKSx94ilCBBjxkvVy5DAx3tPHdLRm2ivw+WkbK8pDbQsO+8BN+T6mY
	97n7cUjhJtFAH0IXR7Nqad6IvfafuUobEh+HZ21PRDKwBC4bCnpiT/bj4G/Q0g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=U2YF1wPLh8b4Nvmm31/T9AYE8PIc8nUuOkOaaee1UhwNdKS4oqhhVbyRRQ4J0C6EV1k6mH
	AJtBQwLXXfnzAI6DRlI0OQBzUVD8z3iyg/ZhkCKHtZYK/c/5TDEOQDyE9n6Y1Z6ZfffThp
	2w8FlY5+wUO+jPNqEKmcjeucUAK2v2nGfuiQade185ujtAkVtT0qLRES+lp1m8wgNsBSZo
	jfvKzfFirzzmaK+XJ+IJ3CB7RG9JthwVvuy6GNrHu84XIJFKYMVX/WdcAprwK5y0ADC+9p
	x7lFio+/7VbrTZ+TX5Np78g53bhLk9LWAC4k5hKRJ/QrS/K5PVWidwkilecO7g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KIG-2e;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E0F355EDC9A;
	Wed, 18 Nov 2026 09:30:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/12] can: ucan: fix repeated word 'is' in comment
Date: Wed, 18 Nov 2026 10:11:44 +0100
Message-ID: <20261118092955.1283165-12-mkl@pengutronix.de>
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

