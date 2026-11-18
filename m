Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=xEv2MFX2gAo6YRZGDB2jO4FFOywhyqlZUIC5bxokZXOwZAG2hwo6uognhRBb9MWG8W8S
	 pnR/VVTrR2l3dtBdCOxb3MtNWHK7JqtKCaHrboaG6hFfN/Ph/peBZ3v4eXERzOlp2EGMR
	 9V6ASAIBYLd99zhPmWfLlFN4sxAC9gmvcQcJ/rQzWSnpWSUZ4kVcgXP4DD6jcjW6+dKPr
	 I9UZk/N6sjRMMKio7JQxaKjTTGmOmaRhjMg7e8M+wlsrSONx158bWSVj0PHOVauOdNFZd
	 iGdYyoPHHLxM8rdqiMqDFW8h7jETVkqqvft4D5H5RJxqantE/k2PDOiRELOE3hiotDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=lRkPu2Qdog+/BWFQd1SVogOnSDM05qShhtBld/jl5ZVGVV0iItuZF/OzUPT5Dj4yivmg
	 BvsWbRUrHyxBgMkbuKLh21D7rNXsfpQuYMluwG1FE30y2+f0pVZZKiDB6CEQwNB+GECW4
	 CJpSUV/gD3MGIOaXq3sKxBFtkTd9tDw+xgtf0C+wxPoD6VOasHvscsJEPvEJsvauypcFi
	 JvO2eZFLTGIJXIUuxxcJyOB4lD+4kYbIN6uJJeYVKYXd1ae1rAjm7BamotF4Y7AZXoU9w
	 kIacwI6o9hhCIlJSmSZ2Bu9tGWG4j2H2dQ/eCg250cIHP3JH+23IGdIT6lT2zChp6Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gbIoUhHE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B3606A896;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92B3606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gbIoUhHE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 70210205ABA;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=gbIoUhHE9NQHgPQpu8YEf9QUBpwcjg0uMvVLBHhkrZUiPj0ZfiTn95VrM1YAFg5aUsDVPV
	aJvVQUJafCIk3OEfqbr2HisH7woyNR4Lmv5QpubMYAYQ8cVUoyJD8OjSNjQP2w4pJebvIq
	18FrB9B0bfrVdj4dD/DyerBXW7Af6LOV9D1wsBLgd8DCwOr0MwlbxyLtTaH+NWIWtkNR6+
	qynuvV1FSnziNTtkECAjJsBipIpWdQJTZtzsIHneAGc2HeoozKD9IoJk+DdJ7vJXxMoEtD
	sLwUz4U9j5OPVkevuaFAYtva5927qz0tYPNA67ghILIHvUgOR/Y5Rsvv6O+PDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=YQWaCaXUicfd1FCVi+uR4yi/lNlAz0vDPdmXmq9jNj2Nk8qiKDFITZgfM7EgAhswAyg1XB
	vsgH2vg1RQAn7dKV4wsyWzhMUDOrD4yJx1uNjPEKgR8kNziytepoXackM7sc6h+csouiSx
	azE4g2EcZNVej5iXZQgjCP2HZM9kS8AWFiGZONToTgVfsPSVsInjt03D6MgBXgz4H1wy5R
	R9PyCIn8tDMhAquoEVtHUqUkmsMCUXBj+chiHUnon1pxGjEwMaxRYHnl40HyR9EzArteXA
	3wl1zVfbbVU83dvByIa35Ad7a73S2QtqoPRve6Kk3MpmMcwX3nKppIwfw5TyyA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=IfHfzu+t9z6J9zYPJ8FOeEiiGXQLD2xZjtnMGGdr26QvIWwTnTLx+BKguOTJeCGaj4U7eu
	oFwMOldgv3d9ExPdRNNQPsgDdPkO8a2ly/5alq0est2Q17pXsNWK3L/LQq+KL2MhsW7/u5
	kcIkpnL5ojN7tv0fO2pvIOOOY6SkAnj7OS1NcYKQnyLCACnKMuG6Srht4su7Jt9cBf+KZD
	70oWbDtrsZZM5+F+DkPcPSW+OSoCFNC4ZETD6MlcTWcZFa7SDUhJmzMaLRAalyKs1lb8Zl
	Z4c1b0t0nSbSUgxtvZx3h8j/cySjtV497nOAFdqandSQvJxZpfMZC/EHQ5Ms4Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KIC-2W;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CD2D85EDC8C;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/12] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 18 Nov 2026 10:11:37 +0100
Message-ID: <20261118092955.1283165-5-mkl@pengutronix.de>
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

From: Triet Hoang <triet.hoang.dev@gmail.com>

Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS and
pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend and
resume callbacks, also reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bxcan.c                      | 8 ++++----
 drivers/net/can/ctucanfd/ctucanfd.h          | 4 ++--
 drivers/net/can/ctucanfd/ctucanfd_pci.c      | 4 ++--
 drivers/net/can/ctucanfd/ctucanfd_platform.c | 4 ++--
 drivers/net/can/m_can/m_can_pci.c            | 8 ++++----
 drivers/net/can/spi/hi311x.c                 | 8 ++++----
 drivers/net/can/spi/mcp251x.c                | 8 ++++----
 7 files changed, 22 insertions(+), 22 deletions(-)

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
diff --git a/drivers/net/can/ctucanfd/ctucanfd.h b/drivers/net/can/ctucanfd/ctucanfd.h
index 0e9904f6a05d..7dcd7dc507e4 100644
--- a/drivers/net/can/ctucanfd/ctucanfd.h
+++ b/drivers/net/can/ctucanfd/ctucanfd.h
@@ -76,7 +76,7 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr,
 			void (*set_drvdata_fnc)(struct device *dev,
 						struct net_device *ndev));
 
-int ctucan_suspend(struct device *dev) __maybe_unused;
-int ctucan_resume(struct device *dev) __maybe_unused;
+int ctucan_suspend(struct device *dev);
+int ctucan_resume(struct device *dev);
 
 #endif /*__CTUCANFD__*/
diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
index 4b6db28f7b67..9c9c41c3058c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -259,7 +259,7 @@ static void ctucan_pci_remove(struct pci_dev *pdev)
 	kfree(bdata);
 }
 
-static SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resume);
 
 static const struct pci_device_id ctucan_pci_tbl[] = {
 	{PCI_DEVICE_DATA(TEDIA, CTUCAN_VER21,
@@ -273,7 +273,7 @@ static struct pci_driver ctucan_pci_driver = {
 	.id_table = ctucan_pci_tbl,
 	.probe = ctucan_pci_probe,
 	.remove = ctucan_pci_remove,
-	.driver.pm = &ctucan_pci_pm_ops,
+	.driver.pm = pm_sleep_ptr(&ctucan_pci_pm_ops),
 };
 
 module_pci_driver(ctucan_pci_driver);
diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/can/ctucanfd/ctucanfd_platform.c
index 70e2577c8541..4962b00ee8ac 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
@@ -99,7 +99,7 @@ static void ctucan_platform_remove(struct platform_device *pdev)
 	free_candev(ndev);
 }
 
-static SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_resume);
 
 /* Match table for OF platform binding */
 static const struct of_device_id ctucan_of_match[] = {
@@ -114,7 +114,7 @@ static struct platform_driver ctucanfd_driver = {
 	.remove = ctucan_platform_remove,
 	.driver	= {
 		.name = DRV_NAME,
-		.pm = &ctucan_platform_pm_ops,
+		.pm = pm_sleep_ptr(&ctucan_platform_pm_ops),
 		.of_match_table	= ctucan_of_match,
 	},
 };
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

