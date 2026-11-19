Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126295;
	b=Fe0BBBDUJ3vhFraexm5+4nSeFvA9cifX8ll/MznMm+958or97AbpZdwuXa+UXe/Y5l+t
	 cQxujna632O612IHCBtNfQYf9+EF2jupS7+E+wm30BG0kmnoP4Nhv4DWaSqgtPiSoIFpM
	 dS7n6XxPNkD933jf9r/pisEn/QkqKnoL0pjPuMSK0MDNtdyNziayiz/I6US8Yy32TItW7
	 KfNA+2Ov4aHDVZ1YvWTD5PTHSdGiXWT97mdQpIrWebwl2z2khne9MksLUbQiLlu5Ogka8
	 cHZfJYIxAV1mFtvU0EArDXiBI+v7c0kj71WhXktCrel277Z6zPmy32noIPbuIZtw7OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ui6zES4ZakF46pBLFIl8tQ9ISP3NVZw+yD2r11N/NRA=;
	b=EcxXkYmXo0sUCdmjAdIkpst1iQG564Uxh4QSNCgt+5rQisQkoQO7LVZFOFG9SafEFksb
	 bA5lFgU4wuK5aQ1tQWXGjZPX4DJU4gsNW0EEl3CoyUW7DJP4qmDPTO+c7h5pCql8ap4t8
	 eCyoacHeJoNSBOSnmXaO062nLMUd8+PUyyGg73Ec+EjD0H7B1FB7vzTb4okWo/sBCcYZQ
	 vrTPNChvyMxj7yjXw6jVDz0fo0jf8oYoaGOxALSJgyNOQZzMv1EMVUM803Gs9ONZ2CDwt
	 C6WVd8QPkXtOXiaVav8jd1s0V1Zvk+S0SxvVuYL4CikPmcVRgP7wIKPbcEUu0bLI7iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U79OjNpc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4C606A326;
	Thu, 19 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E4C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U79OjNpc
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 35012205B35;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui6zES4ZakF46pBLFIl8tQ9ISP3NVZw+yD2r11N/NRA=;
	b=U79OjNpcZn26rCwlry0p0nD/0a3ewjXdkEZcSQ4vBy7OkKVWfX3ijej3/f3dJvctbUeHJn
	o8ZDppnv9G4IEbetzR8XfdtG9D8hPkJQOVyi0W/l+/4B1VphlyKBwzkXaEXhux7C4djvZA
	cmlmISVPdFSvXeKNwdfxSb02qZZ7du6+zH8JhZhvELoegShQq5dGUvuf8J83U0PlFcgHWU
	slZ50toDb8w0imgIHtc9hfdAWffU0lLZY0etsJ6guAyr75WeTk/EmmG7bOeX5bi1k3kpF4
	Okc8rm4Rl1bBkdNkoGGwiPorHbjKxpQXBsVmxI//lDtKpYs+zTvHXKpZqLNvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui6zES4ZakF46pBLFIl8tQ9ISP3NVZw+yD2r11N/NRA=;
	b=KW0hM5VVdKtJ1VDUm9IUs13ZHHDYrQ5r6ysAwMO5r/kJDs0yEsPAaypLBT6Hbw4wvXOEYr
	haMYPM242adOdjlpLKhHXtiGclOOpkRK+v+Hj0B3Py/wyGLZSSo3WeGmPgA/rOG2U9LZjU
	Bb3t6PtToq1BUxIrTHSiq67Dz7IsDfNJX7JA+cegKI2cul9BmiBcTLT60rA6jQM4A51Wud
	Xv0x0j7EqeBuooV7sa5fA4OeWKN/z3JwrnAOsP9+tLO+egAEECRjNkcxoLqYvz1epztjpm
	XEIWc+mz0471tlyR9IDPGYG7dGkRL4y9HZm3ihWjPqE/YfjoVuiBgERf2kXfAQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=f0OiLxSsmwQFmFMmgnY1TGhpuMajiw/gTsxM8Le8ImlmVOqYypuZ4M/YIJzptz+Wh+g77M
	WsKWt5OBFCEAWWtsPhaE+I9j8dprrzn7+TpqlrZW/AV+B4ScBEQh4PU4ll0Z8ECdbVkWIa
	oWnXN7Eq4ZxGrBSG/glZ3grcvOmWejwBRcr9+JOSJb3pqC8I+T2LdOaD+ChGrbOk+TVTKk
	FF/nPgI8oBS0nMANUjLgI2IYqy3ENNINtxjXKZGuSpQWoG45JTt/+bjeMDa+/zfZ0vzslD
	GLtb/hRhQ/Zb9WAxfXtn0Pa8JBFwzRWdt8GBChabHEiQNv0liWOUxlsYPtfYlg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z68-1n;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8C795F0997;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/13] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 19 Nov 2026 22:58:40 +0100
Message-ID: <20261119220936.155728-5-mkl@pengutronix.de>
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

From: Triet Hoang <triet.hoang.dev@gmail.com>

Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS and
pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend and
resume callbacks, also reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@gmail.com
[mkl: remove ctucanfd]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bxcan.c           | 8 ++++----
 drivers/net/can/m_can/m_can_pci.c | 8 ++++----
 drivers/net/can/spi/hi311x.c      | 8 ++++----
 drivers/net/can/spi/mcp251x.c     | 8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 4bddd015775b..622c5d73e33a 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -1042,7 +1042,7 @@ static void bxcan_remove(struct platform_device *pdev)
 	free_candev(ndev);
 }
 
-static int __maybe_unused bxcan_suspend(struct device *dev)
+static int bxcan_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct bxcan_priv *priv = netdev_priv(ndev);
@@ -1059,7 +1059,7 @@ static int __maybe_unused bxcan_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused bxcan_resume(struct device *dev)
+static int bxcan_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct bxcan_priv *priv = netdev_priv(ndev);
@@ -1076,7 +1076,7 @@ static int __maybe_unused bxcan_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(bxcan_pm_ops, bxcan_suspend, bxcan_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(bxcan_pm_ops, bxcan_suspend, bxcan_resume);
 
 static const struct of_device_id bxcan_of_match[] = {
 	{.compatible = "st,stm32f4-bxcan"},
@@ -1087,7 +1087,7 @@ MODULE_DEVICE_TABLE(of, bxcan_of_match);
 static struct platform_driver bxcan_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.pm = &bxcan_pm_ops,
+		.pm = pm_sleep_ptr(&bxcan_pm_ops),
 		.of_match_table = bxcan_of_match,
 	},
 	.probe = bxcan_probe,
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d11a7c88fc32..d31179312026 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -169,17 +169,17 @@ static void m_can_pci_remove(struct pci_dev *pci)
 	pci_free_irq_vectors(pci);
 }
 
-static __maybe_unused int m_can_pci_suspend(struct device *dev)
+static int m_can_pci_suspend(struct device *dev)
 {
 	return m_can_class_suspend(dev);
 }
 
-static __maybe_unused int m_can_pci_resume(struct device *dev)
+static int m_can_pci_resume(struct device *dev)
 {
 	return m_can_class_resume(dev);
 }
 
-static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
 			 m_can_pci_suspend, m_can_pci_resume);
 
 static const struct pci_device_id m_can_pci_id_table[] = {
@@ -195,7 +195,7 @@ static struct pci_driver m_can_pci_driver = {
 	.remove = m_can_pci_remove,
 	.id_table = m_can_pci_id_table,
 	.driver = {
-		.pm = &m_can_pci_pm_ops,
+		.pm = pm_sleep_ptr(&m_can_pci_pm_ops),
 	},
 };
 
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ae90e6716de5..076a3efa1bff 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -972,7 +972,7 @@ static void hi3110_can_remove(struct spi_device *spi)
 	free_candev(net);
 }
 
-static int __maybe_unused hi3110_can_suspend(struct device *dev)
+static int hi3110_can_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct hi3110_priv *priv = spi_get_drvdata(spi);
@@ -1002,7 +1002,7 @@ static int __maybe_unused hi3110_can_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused hi3110_can_resume(struct device *dev)
+static int hi3110_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct hi3110_priv *priv = spi_get_drvdata(spi);
@@ -1022,13 +1022,13 @@ static int __maybe_unused hi3110_can_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(hi3110_can_pm_ops, hi3110_can_suspend, hi3110_can_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(hi3110_can_pm_ops, hi3110_can_suspend, hi3110_can_resume);
 
 static struct spi_driver hi3110_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.of_match_table = hi3110_of_match,
-		.pm = &hi3110_can_pm_ops,
+		.pm = pm_sleep_ptr(&hi3110_can_pm_ops),
 	},
 	.id_table = hi3110_id_table,
 	.probe = hi3110_can_probe,
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0d0190ae094a..d971890487b6 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1490,7 +1490,7 @@ static void mcp251x_can_remove(struct spi_device *spi)
 	free_candev(net);
 }
 
-static int __maybe_unused mcp251x_can_suspend(struct device *dev)
+static int mcp251x_can_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
@@ -1517,7 +1517,7 @@ static int __maybe_unused mcp251x_can_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mcp251x_can_resume(struct device *dev)
+static int mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
@@ -1551,14 +1551,14 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
 	mcp251x_can_resume);
 
 static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.of_match_table = mcp251x_of_match,
-		.pm = &mcp251x_can_pm_ops,
+		.pm = pm_sleep_ptr(&mcp251x_can_pm_ops),
 	},
 	.id_table = mcp251x_id_table,
 	.probe = mcp251x_can_probe,
-- 
2.53.0

