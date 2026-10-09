Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F434E432D;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553426; cv=pass; b=X88ZBWLfvRjDNph18Zj2zCCOeSckvthgdkrUbb39XUH7EbNR+BUB3F0X1BL8vbNmAs6XDe8yZMVwq/guDmJu56ZfEkXErQ33iPrzdfgzcAUqV7Zz3zCn3xw6R6dl7OYxsLP3q5jVorDSPUULOZMAlydLOSat+npLdnd4ZdtKPX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553426; c=relaxed/simple;
	bh=Q8tq2kJBgkiifQFoP4DfObd8XW8al+m9Vb37j7tSduU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsQw2URR34aL+pnBmi486gqdOfBdPFipOHJKLJC3Lt9iAJnFbfwTAKrgteDanV7jUALw3v8lxTpWtbll6OVz9NyOXrVzY2bxMohNtq4M14AIhLcr9c+29DF9ENuxrE/fBUxlsL9naMxHwMsmSRuRmiGhhR6DAT/usRvBWFptFKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YJ8csZgI; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YJ8csZgI"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF935202665;
	Fri, 09 Oct 2026 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LNYjFUdef6ciEIJ+B13NMVIpcD15hZwINLB2eZN9Fo=;
	b=YJ8csZgIIU2lTamFUABAePsSEIFWptpGRDUbgYdtyRl7rI79Ae0sxGDK8bMTls+pSLihcv
	L3XmiVz47N5yBTzAuzcjvq3L3+BeG/yLjSyoMGQkje/LN4cPywI84kSYmj8pguihrCDjRB
	NlMRQETzoP1NxKluXRujOCNWG9VDuNuxjqOtmYoOaQMaScrIezSos9I0v4cMq6dDuoaCXv
	zacVbWAfJW61RdsbvHJ8XQQAPCdi234Fm4IMUA4WHn91fR/nt+u1yu8SXBkpoods/gj3Ob
	UJ/OLSdTouF0BB1f2zUCmIQRd4lRS1qdprBtpRXW9xOa5gJgPn9N0boOI5UkTQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553418; a=rsa-sha256;
	cv=none;
	b=elA5wrHCyL26o9bRK/VuqFFBw/+YuZ2SytfrempuemK9VSVfY5Y7YSqk2ZdGgPQ66oHjOT
	3RFQb9KG0sY/STw/B5fgZjnQRXmOy+bXnZqXCLBynZVvzO6/cxnM/LW39HHj0jn0/RbWfZ
	ejNCm40TNIEkFAcrq9OZONQyMDJuBQhPgFUBbxG+sRLFXCOTJEBNfWpFEUy0RUsEUqolcg
	+S+DgVdoOOrX9gMZPqMrxlcKrfk42qNem2nZBliqt9CcZzZlB/bl5i3gNDJP46SQpCO7Bc
	cgIDcCcwAb7GLvyJdSPXJ5wEIQX+v+z9kvvWXgY2q9vHFn+IhkCRqxDwZQiQGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LNYjFUdef6ciEIJ+B13NMVIpcD15hZwINLB2eZN9Fo=;
	b=FvhqFoqBpMuxZP3hnOo1KLRfz7cGYwKwXjZekFpBeBpGgPw+Qp9JUKKYZcKfYXPNmQYqkw
	mC1Gy6E6Ttlj5UTqbOKPv5DZcB1XHMtn+HTCgQBPPvqk6aV6IwVQ1wAzzSLy0uAZj0cV+R
	IWgo1f6Ww2MQAGbqMA91Y48L/xKDPsdY9+YhVKNTcO0++hRahezcVcQnpGxaQg8xbuNkNu
	ZS0SrPZRJTBODnRZLiRsK3byonhobrgr9QNjqU7sb3s+CqNlV0i/naqYzTRvq7WIZpNBxn
	7i2gSKg9zMuoCR02ZUXXX47JA2Aze7qgq0HxJ0y+DzyFHQ5jc0tmKpbgIfbxgQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAss-0053T6-1z;
	Fri, 09 Oct 2026 15:43:38 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 38BFF5BD8D4;
	Fri, 09 Oct 2026 13:43:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/37] can: cc770: fix the clock divider check on the platform bus
Date: Fri,  9 Oct 2026 15:27:57 +0200
Message-ID: <20261009134323.64064-26-mkl@pengutronix.de>
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

From: Quchaosheng <quchaosheng000406@163.com>

cc770_get_platform_data() tests priv->cpu_interface for CPUIF_DSC before
assigning it from pdata->cir:

	priv->can.clock.freq = pdata->osc_freq;
	if (priv->cpu_interface & CPUIF_DSC)
		priv->can.clock.freq /= 2;
	priv->clkout = pdata->cor;
	priv->bus_config = pdata->bcr;
	priv->cpu_interface = pdata->cir;

priv comes from alloc_cc770dev() -> alloc_candev() -> alloc_netdev_mqs(),
which uses kvzalloc_flex(), so cpu_interface is still zero here and the
test can never match.

A board that sets CPUIF_DSC in pdata->cir therefore gets its system clock
halved in the hardware but not in can.clock.freq, and the bit timing is
computed from twice the real clock. The platform data example in the file
header, .cir = 0x41, sets that bit.

Assign pdata->cir before the test, as the ISA path in cc770_isa.c already
does.

Fixes: e285e44d91fe ("can: cc770: add platform bus driver for the CC770 and AN82527")
Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260917114311.534863-1-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 64fbdf14e8ab..ac81670762c7 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -137,11 +137,11 @@ static int cc770_get_platform_data(struct platform_device *pdev,
 	struct cc770_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	priv->can.clock.freq = pdata->osc_freq;
+	priv->cpu_interface = pdata->cir;
 	if (priv->cpu_interface & CPUIF_DSC)
 		priv->can.clock.freq /= 2;
 	priv->clkout = pdata->cor;
 	priv->bus_config = pdata->bcr;
-	priv->cpu_interface = pdata->cir;
 
 	return 0;
 }
-- 
2.53.0

