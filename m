Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D24E4327;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553429; cv=pass; b=rpRbuLVx+Gg7wDLDha0qKW5z5lE3fX1UdBE0ErJcVDkpJSxzwnR7yEBJw+lAyp4xhCxW8C0AagzKciHJi69dbD0tKLKMOWYzELZQp6YawS2+RQ/d+hXQZEcIy3XwsO9HVDj21i9lwZc8KbFeFyaVM2Io0tO+A7gy9mLpGKe1RVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553429; c=relaxed/simple;
	bh=zqYgY83Qd3MVJi5EQcDjmP6rTcdfsyA9dWmXNqos+MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcOFYG1mTJ6v/sVKIwXG8LUqodNV4x60xtoAPLFq7QTmXp+thEawMF+meKiBIWn4b6NC56tEla5g1qWkUtsz6Wxt7QW9i9k2aGLDRXbIDMsRXvo30s/+jocjuczkMWjjM8Wc97oZogCUa50s49UvRdCC+EP/UTodZ9w4AcHvUiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KKtdgmRA; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KKtdgmRA"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B090202663;
	Fri, 09 Oct 2026 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=KKtdgmRAcfVXvx5xTTsG/VV2rBENT/9jngi2rGzEvz1tcp0l0/ZgY6UWLZjZWgdMr36Uv6
	ace2s07CM8Gv/ZBR7lRHlVoi9pPRhTuC61cWzSnJlLvQpaoRBcNyOrWLoz+u9p7/JJD3Te
	Fu7Z5NsOUdLKEXjLWtqtXDqHy6GXvIVuGySeFVHjijUtXPDp6FHw8AAMPeFBPdDxi2KnD5
	JzKUFYlhU7SJOL3s21SMV8W65pB0JbaT/wvaZvRuRy2TONZqe+VMsNfCS9zTsl8veavRqd
	DMYZogkb7I9rGtPaZF9p3x21drvdOfkU0Alo1VntYLUlws61E897xOaFYB0t3A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553418; a=rsa-sha256;
	cv=none;
	b=fzCThU3XrXjcomQNfu8oV6NW4OA1QgNJFGrEt6cyjJOJc4ICa5scxFE69S1/+vIZTYdHJ6
	Uuy4ZpbygnBzZdrle4QudS0pPQoCXpY82B5WjELO98uOJZOey5FAsirY0N/w4aq+z2UuLz
	q8oDST8AzWvKtsDO1DL0hZjO0FtfLQ6+9JMPHEjRDkIuJEId/c/G+4q9SQm9Bam+N1RuRU
	Q0EazjFj4yY7kf7TM5oenyL5Xle2NDFfME8RK4SvpPsB08OGRLdLeotvZZj2W4LzR71IAj
	3TyVQQBY4I3wLGeRHjLdkWUt2wiCiqfwGn0pw0nlnMg5gqpRdMfXtC/aRphh6Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSjP1spz4rt+wYboAofhwRg0bZ8tqsT93ZO13rmsSzI=;
	b=AtYyUgnCumEAmnu5pDLCWMiVxe109dAihSDrcoHwdsi094++Q1ugjpwredglghAQG4C+K6
	qhIO2yct7afeWzVm5evWSqE6zKRmjzUr6Cy47HJe1PRNkslQ4xd1OgUO4RKH+MDfXkbTDR
	2E6AKQyeGjtEoKITGQuLm9WodRoah/glIAQJ+gF/jgi6VvALum/MgQbhQHofVZW6zocsDI
	92btqCfAG/zT+zwTGLEDTkMrvJuAUDr7Lm/Ui+Jz03Jy3hDDdEYgrvJVWv5QjBnuesDLsF
	iuno+UrcWEbMLxg6MpXV6BRYwe4sytru1DDtZRDKfsXUZb6dY3psgRCJedwLGA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAss-0053Sw-0S;
	Fri, 09 Oct 2026 15:43:38 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9AFF5BD8D2;
	Fri, 09 Oct 2026 13:43:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 23/37] can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri,  9 Oct 2026 15:27:55 +0200
Message-ID: <20261009134323.64064-24-mkl@pengutronix.de>
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

