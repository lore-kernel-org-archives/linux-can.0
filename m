Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382E4D6C57;
	Thu, 17 Sep 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645421; cv=none; b=dXpVZpDF+GJF2dBN1WuQ9EHWySIDvhboHpSVCEAx4N/gxRmK564L8sElsRUrWB95JzN/qU4FsFEFIjxfecx9PuyB9s/TgXuFVL4yCU5oYXsY9uBaPnNAn1TBnc/VSoZbixU2DtG78bIRMWZFmalim48cO6SBhYIDKk+bExdVBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645421; c=relaxed/simple;
	bh=eek6u8893Mp6R+IrbpUYqaRh57JHlrRd8yjFeKQc4/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL0vYDNiMR5O3ifN+b7GZ4HEdWP+XKKPODNslPmWMiJolKocURrZH254biTOpMVy3hWpHyUDH4BeThp6EqyfHs+pWU2OHhtblWBFP5W/VPcHLsZ2KIJ5/6IEhWkT3F5Hy/8WWYb2eFdt9Ttwy/lWTlQv8KEdZRGXzEMBbTGBO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JY3iQ/Pe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JY3iQ/Pe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yV
	Gy3/epLqOdYXpbxQL1bVKZCjldwV5S628qAF9EHUk=; b=JY3iQ/PeorRpM2Tq/H
	JncgDm+PwqNizotcKcon2mUC9O4pl10TPDNINLNiWMS0U3jBtE1g6tEDeLok+amx
	dZ4/ZwPPMf9tLzBJiAPecFUKgVQDm7DBKHhP1HRfbf4Ruf67qZ0cdiByLzLfc+vu
	ZJRfwIA13j/i/urGCN1i1FYAY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3TARP0qtqjXTETA--.32916S2;
	Thu, 17 Sep 2026 19:43:12 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Quchaosheng <quchaosheng000406@163.com>
Subject: [PATCH] can: cc770: fix the clock divider check on the platform bus
Date: Thu, 17 Sep 2026 19:43:11 +0800
Message-ID: <20260917114311.534863-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3TARP0qtqjXTETA--.32916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryrWF43GrWrWF43Gr13XFb_yoW8Aw4xp3
	yq9FW8Jw4qvFs0ka1vgw15ur4Uu3ZFgFyjka4Utw4UZ3sxCry5Jr10qa4kAFWUArZ7Cw15
	uFn8ZF43ZF4DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi7KItUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABBOw2qr0lDQXgAA3Q

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
---
 drivers/net/can/cc770/cc770_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ffb97..1565bd5eea28 100644
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
2.43.0

