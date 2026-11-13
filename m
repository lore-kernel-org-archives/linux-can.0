Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554011;
	b=jRME1T2iEEVFSexpvWagcMifVl06FMZ/9Djjy+CqYe/uo2vG6miHp9u88XSHZBIqvWZk
	 DR2RfJH9EZZxekmZ19mJ2MpqAf+ZPuukXyouHQitAc42esnDpXICLa8T6EZmOXrXZofMW
	 bPT8Cz4Eg8waPr80WOTttN/6KLu9OM8NQH52D6QE07a2LngVjdP3Wh6NwnXnU+IsbENB9
	 z6whxAY8d50QTOFKwxhB8+IFlStpz14qd+D416H3pfOIqy9DoZ3vpqgIs/4KoZc8fZqCJ
	 V6cBIjQ8FKjO7cn9jZi854Mj0TQmIiVXLMFdTOuhDDIfBHev7IJzc3VjrmjekVM8hJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EL95yJre1c/GQsWKvg7GLr0vfeSeCa4vMHUXRbwoWlQ=;
	b=qSufnIv/BvBhgFwjNI2zypAnXtAa82za8DdeI+qfei13odZVlu+lMl5qhsc+XFtKYYyx
	 +Rks+kFSdOHnbHKMH/ED1OKVpLU3aRseb05l5FjvguZDQKWtN/ghw6Qh/ax+c5U0JW/SL
	 oTzU8yrZOUF7EbkrPoFl4z0+h55IG5518sOcv46w8g3rba9HIhUSWwD0odY9TnludFkpO
	 QUBoahuLzsm6D+dyybKC8d1sMKERt1cgX6Wc4fXsvqpdi/whA7oN1nQb0T4igL2lScT1+
	 +4jX6LDr4JnP709FJCatGy3M5HSNkpbwr/LVgz/VtTPhZvV7IFvzald3kEPTgNWwPdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CNeo5Wxw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46752606A882;
	Fri, 13 Nov 2026 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46752606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CNeo5Wxw
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1763320581E;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL95yJre1c/GQsWKvg7GLr0vfeSeCa4vMHUXRbwoWlQ=;
	b=CNeo5WxwWqg3P8lXkGP0ZbY2ETN9btOuhnVEyLlMGhdQO0oBAi4jHPBz/SpXWAmf1GvviH
	DtnWREN1WcylaetNzUkgmGPt1LMAv5jHrfgitakXBI6OC9PM197LhqT6DAcMYd7Fkxsvua
	Ii4iJsejq6/jJT69eBRofjqbh84g0QEDuC/QHZs0sJI3IN2DBmoKVfXpqBIre9b2r3pltU
	Bs+lbrcKk59C7m0MlPjxY6uERGF5I/1Gh//AqJYRY7hgq5MagNjsux+lAq/njXrCaTAK/M
	uVmQg2Iyo5JCohvxOgHOnr4is5yCczLJj4Q2lgzlPFWO/bSIVwGm9jE4LeiQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL95yJre1c/GQsWKvg7GLr0vfeSeCa4vMHUXRbwoWlQ=;
	b=WcmbyS5VENkwi0BN3d9NjL7LvCR5/iRw2KPJXpKuCLUNZPtKLyu9+sLUOzoP7uYndkWXVz
	9O99dWjmiWWii4m02RGzyBBiHhfQu/YUhGX3wi9RLVGh+r4FM49XdxJtGlNCF5suC8JG9a
	xbXlR4WRfzU1+aaaRS8Qjou2/MnFXCCpbrGDQXHo/HGuumRX1YuzxYVt/akUmSx4/r+yV9
	irIRnDrwyRl+9oA/t82ALG+mUoswN7yd4gY0tC8wfXt8+FLfD+5iOept7mOMSMpKb3kdxD
	c/ulxaMawbxI5rAwSBcy8F4Mr94Q9sQ4/p+8E1p3PSQTYPR23dVSafdxfFIg2Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=NN9iPRfWhtYT+RDcqXYSYXgwEVuV20poaRHlIudIri76X9zERiczwa2+KI6wZrotxZIDM9
	05iCdyZYKHNmLbbbmdNOorv1Sf5J/806IvccDxN1rLUMrE7A5vUnVd9h0jjss/+0fuC26N
	9tHnkqdLclDMesAr1gp/m9pyL9kTmyLW6wgIArAjYaEe80TuAJgkYYJRAToMFTg7SAjEKT
	R/8Q2n13e3nT5bYfMDV0RTnznF3QhLRQHWBJpDM8+mm6E23dj1W0RW8EERHWrKWeCQnLUN
	J8nGUV9kOl1cmQlNHsBkV1rHUpfj9h/i3RtIXrBO4s9rcSmOeVfe500jehvecw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTT-003xHr-3D;
	Fri, 13 Nov 2026 08:13:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B78CF5EA579;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/7] net: can: cc770: update the binding file reference in the driver comment
Date: Fri, 13 Nov 2026 08:08:52 +0100
Message-ID: <20261113071325.4092169-5-mkl@pengutronix.de>
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

From: Chaosheng Qu <quchaosheng000406@163.com>

The cc770 binding was converted from cc770.txt to bosch,cc770.yaml, so
update the path mentioned in the comment at the top of the platform
driver.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20261009105557.301855-3-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ffb97..b690167c454f 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -30,8 +30,8 @@
  *           bosch,external-clock-frequency = <16000000>;
  *   };
  *
- * See "Documentation/devicetree/bindings/net/can/cc770.txt" for further
- * information.
+ * See "Documentation/devicetree/bindings/net/can/bosch,cc770.yaml" for
+ * further information.
  */
 
 #include <linux/kernel.h>
-- 
2.53.0

