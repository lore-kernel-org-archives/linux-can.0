Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586F385D99;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029233; cv=pass; b=fFLdE0N6RK79oQ94hMXc2bKj8grGridUTod/ynb8+6HY063yhlDsRkK6ZfiDdwxodEaJTcqNwd6bkNnwB4sUMdsaUYGNCO/+Y+SwEeS/5juSEiYU3Xs9RbRRpmJCl5iwZZhpc5Pa5S2l1O5PKNbN7fAsLk8VwZ0t1k/tZnUS9Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029233; c=relaxed/simple;
	bh=zqYgY83Qd3MVJi5EQcDjmP6rTcdfsyA9dWmXNqos+MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpqqLAIDlE9ieib59TdrfubmPwXKlpUGjXGKpf3T1G7odi8IIUCbNq6aMv4NzxKcOAYNPTKSmjQywdo2+iNRBaIM0Bmi3VaKl3DhwFmEabZF/RoKJChb6nTXZvUS+igMgYBxEr2y6A+EXeRNkE4idxSNF9dLk0SFUsX3L2Hd1RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GSrncnRq; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GSrncnRq"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B91442027E4;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=GSrncnRqkHok2TxJBdmnZt0WtvvMaPn7SuekZ/vLKK0LSHeRSvsma8d4n7bwoe4yD4aKzJ
	hDXppO0jYMH8nWxVqyVQEDK1/BPK4Ot8tsHhMQcJW7dFrgHJs9BXUAkDzyVld1up/PNkgn
	8mRe9Buhlyh40hs29r6K2DiVejqp1lPcXxKczcAyMPZIuwujnA3Tv0p255NuoOaHoSuVp1
	tG90953n4BeuS0XiJ4v+bgM7FB6z34cd715AYgIP6XS9i7QQTZ6ehXbADTeVMI6g18Qck1
	8o7vN5baILOQnHjpKKs4e3PMdBrAjiiRreaDXIEMT/cI4nFKyb45OtN7E0ViUg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=B573lFZA8huxPaUAX8cTXNIU8jex8MnlhhTs7ZCKlG7ADpVILarh92Kk1rPHwaPG91uiPE
	VBBKh6BkC//9wc30Ks5dD+9VOalEsrcxu9Ktb0VOPF6YyAIr/rHrCT+anobYdTeg5cMY8/
	VWTBNfRRTICwtWngljIYtNm909KGiz0WltasDGtR0634KW7GuMDdRh2xxF//zWoYh5DTOm
	TQkYWgGj4kJmCK2WNrw/69yZdgOuXbTbSxf4M8NtcBbwQ9/qROPC/xzTSbK8srRVq+tQ2l
	Rypj93IhrIvnGc21E6BwZIyxEoTdHEY+2bKd+ZOJzibzPgzJ+xIC0aCpPKg87w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=f5LOwIfDHCHQ6EMiCQJHS7zb6vF4VGkMcbqJxMmo26n26ACbdW2i6cmC551MavULafavKz
	Y3Z5vZPHoXju0PyIKNKy+DVxisCi/eVTBcUnkcu3DybTiJTjN2yIdHHubqgQX1Ks1iW1Y2
	OQdqUJFW/Q6URAGERI9pg8hUp/VgEswHr0Ht9hVUZfeHnfXPkmoCPi3gvHoAFJwi4DKKdD
	JuNVnv/+OUBRNnb6k0iWojTSgoj9/yT/sCHM+5rYn9lueMD7oQTTfI+LOJYydO0B1BY7sP
	wllZwag8h9Pm5l+gmFY7BVXQyZm4MKRACJM7bPdl8dHGZ1HaVZxC4DmgfmjRZQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wrE-27;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 67ABB5C4797;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/37] can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 15 Oct 2026 03:40:23 +0200
Message-ID: <20261015015336.816543-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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

