Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84525013AF;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624008; cv=pass; b=GvbhQfz/mpbOj4vo1aHp17gmMbXmqF+IOHH2cKZRJ+i+UsXsdceF2g2B40/60+B+vnBrUXeHBx9u/DJFna+g+8OWfQtsOZ/d2XQ2hhpuZqIeVFlnpa5yb0CJINvaelOV4+0jpLMdins1UdiyrU2yrza+Lzj+09u8cWoNavDWr0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624008; c=relaxed/simple;
	bh=haSJOvVr8z3W3KgNQsrFceEptXVTlvp/9L35jkpROvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxj/RTVUIulg9h8ALENj/RtT848bzu6+CUVKuB5xr2AyLn/o3czOJquHzOqLSLbwGjbtT+AwjSqsmGcRFWBaSBEf5Is1dSAaj2ZDl3IvLu9krdwi3ci/YoJbspxLeHyfmOHS5VsjhQ4RA1hd4e42ZpHYJAo0BD3vlN0wPZ3sg48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Z3mnHnrV; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Z3mnHnrV"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 13771202004;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUGNfMuTQ1bj0qyPEY6+lN2lnpWkwS3fo08YPjgJs90=;
	b=Z3mnHnrV7KqnjR384SJeU23oXUzS6j0eNLKHzGMKQQW5F91XvKY3nSpjTvVwkbY2e7MudC
	7hlD0C2FG/HB8kZwmVKzXKNDzl1IS5MevKKJVudlucXk305ETOdZGK8oJh45+0zRPgR6zg
	IfbQDxbhoBeVgaNXAC09arRxGUXQUfp0GzE5nCm+KSbj1VzcHgTnWCE2VzUON/q/9QTel6
	9I5WYLV9qBDEA8to5Kg/zAyM5uKHXFKXHqYCLxsM3IKbbWxgMfrTkHXxwfIx+Gmaj4WMre
	cGCxxYPZhadE8UxChoi3Mbc/xa6HRvH3PzbRzK6eliHXtDKqg9q/hQOMSgTrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUGNfMuTQ1bj0qyPEY6+lN2lnpWkwS3fo08YPjgJs90=;
	b=akBv//5OhMGbFjrn2bVqAxkod5nKN3EynfzlihuvoJ2wCSJN1adFMylym81vYhNtkfxT2y
	+cgD3UGKON75ib95Wft7rpHWevVLC5GHlgSUuShswogWWD9evQAqAN1CKlW2IpfMgcvmiE
	VRNJhjtyu4OCL6Oeiqqc4AIaVs6Jbr/lY9KdHClt67LkFmd1ln1dFzAIPVJ62tUvjh1Lrl
	Ug4ArLlYbzeOurLk1c0mb2YAsRp5C30Un6PAn8ftz89T7s3BHF289Es6qplsVrCVYWPvKv
	Y6q9Y4wqd7pOXo6TR4hXQUepNzcGt1tAqOGGiluocBMVGlt6t8+EcE0xvEC1rQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=Vboxq6yJHG5j5J1rIJ5jd4HpSw4YlBjeVXcoS9nl2yF9DjT6hgOPnJwSxXTaVryHr/cUq2
	cyKzcNDinF+Y6YcBIXkJY/hR0OEV3H53cpFdT1s78sD0Cb/HW1DMZohp6dT+qPVTl6OnKk
	YAa6WrPxmHWi0dry8YlGZWeCPCEllgLeMPI8k8u5Ormj6L0hkyUcatST8d+dqjiG4stPwI
	N0GTpCWwMoHFx+Cu6g+svdfjZ3KON79gBK2IKcQV+kTaWbAtF2llSmA0wzv+l27TnawHGY
	J+VTLjoFq/jb+cA3if7COjn3+Kl+ckfLlvHmdEJ3EyrR3R7KaTwG1gpGG1dpcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H6C-30;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 910595B1550;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 09/22] can: cc770: fix the clock divider check on the platform bus
Date: Mon, 28 Sep 2026 20:45:16 +0200
Message-ID: <20260928193312.553632-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
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
index ac218acedb10..c7dfcff4e1ce 100644
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

