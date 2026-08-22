Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61E36F426
	for <linux-can@vger.kernel.org>; Sat, 22 Aug 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384873; cv=none; b=ULbxWIXjkGoGkiF/K4JoHMgMa/75hdu8zBBEvYP3sQw8DRyooda6kZ/2IgmHqkqHuUnZbulRzM1bKIyQUzgAPwoeS2n62dZfzYbn2DlJPyrujmlbOHPaYld4oR0lg13sDSROIwS2sS9ZUP4dnLIq6TkkeFI4HleRFNm0tZ1bC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384873; c=relaxed/simple;
	bh=RP6GVWvaxPIJVaaSKZkxtQFEcOy88IrS8GIzqXHMG04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ut8KVJJjjMdldWGVxsRFTFPFmO1tLWT6VPnFZimUH9NrwFzBRD6sh1hKsyPexTzz8yOBZwaBOUjY72ld8l+HWGm+/ggicpV5HQqblOJfYhe26K1zbdcvV7IAFqEdZmn3Z8PzxVX/Vl2p88UQKMvGtTJ1e+7lT9RMAHSGXxHGwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/0hLPBe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/0hLPBe"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so1314322a12.2
        for <linux-can@vger.kernel.org>; Sat, 22 Aug 2026 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787384871; x=1787989671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiALqZOnRMSeRuHym28ZXhm8elis69XtxfrRz6r8iys=;
        b=B/0hLPBecePV5sT21W378EbMMl3Lu2T7JS9zggNshGjMgiXvrmV5XtDPIk3tGoboDt
         yH0hi2hafynC1rCAHquEMgnN8fTGc7Y72IsE5ICCUNrcMTJHBmtDaW8SvzDazcbPu3qR
         FgwBWLeNwVDXqB5P/xcOZQM9ValBdKVr7+zZ5SfJLxsfN2gg9ipCOAYj3Woq2DLigCX1
         WHkUcIs/dpv+D6/Z8791ppe/ueZswqV1UukA72xtj1sllfw2R88XqJ5mm89TG6da2MAr
         svzSpHHbEKe0XglsaWsm8O7EBZxTmlS0BFOquGiRkuGFK/vY2DnVBwn88G4jDw0C3DV4
         OoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787384871; x=1787989671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiALqZOnRMSeRuHym28ZXhm8elis69XtxfrRz6r8iys=;
        b=Z41IlcFz0lGju4bEzwDQ+DyvbJ5FApMey0yHIWOptDA+sNpSLoN9BFvjEBsbbLiwYM
         t6eXboMzreQLSSjJbGb6CzCSmIST9JK6xXfxMsuVELBOy7DZygtkaHIW8TTL6W3XqSnl
         YfPSpFa1OLnO6kctsNzbhP16fh2b0Dgx69gKkIx72uHTSL30LkZGDkGDP/1cQT3aV9mh
         fWg7hO4SdeD02o6Luc4vtfMqvIXxAZ56DDuZCkprtLrrX2IQ42l7Vlnc7iFEVSjzd0bq
         /Hd+OE6sU2AgBGXrUFq9s5TUe0WF2Zn0xDvQFzHM7okNOwCx8gtldqviehJRRcdRnnS+
         51eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLd8ncG4+kgEL7WgmvyGj/7r8GOcX94Qz0TtL72qSfRokGezMp2qqKmpHh0i6lFx1RmZCwwKSKZFg=@vger.kernel.org
X-Gm-Message-State: AFuF++lkVhYtAEB4Z3OpzJAcGQ9Ov7GVhp70JWlk4u6ZtDK3/vO7sy3D
	1aGnesfaikpYCHbF5P074Cp0i8fS/Vu+u8q/kF6qh6nIJtW9ASLZuIw=
X-Gm-Gg: AR+sD13oC5SpyaQEcyla+j58ctZLtnNk38uiBcjvaODQrk/cNk+COpa6AARmWVsUeH2
	jhG+KPAPDUUdhzSpzLOt5qIftEk2TiFKyP6e1PCtPSdWmxxP4t71e4JqMKJcKJ1e5mZJWdqyNJf
	oZqrHgDMhpKuBxsnR+Kl3bnAUM5F3Y8FkFMwAjjEG5pqXXo/gpNXatrN9WWOKEhI2tKdPTs87C9
	Q4Z32ZnljsNfuptno/Pow+XBu7Ke0kAtGn4DQ2KtgCre0fFkIg3USyW2bj0bB9N/z/UbKTc2Rs6
	ccSgTRt6G5G14+/0D1N/yViOXyJuFIvtGYxjHkHuY1Nqpbsd89IR/vo2HirxMj3a5auL9vGgr23
	q9bVDT+FdBni/L2QRPaEYGv2MNkCcwN5kbSjphVAdrulREN4HT05wzZ90fmaRu04yvQ4Wvr6hJR
	pUehrhkwi6jYvRADrOyGdeGutj/DwCyZgIvuFerZqlb52+Zm4tSSnWAiHrwqB9jkcPXUtAtiL4H
	Xf2SBdyNKL+6rz3I1UEAMCQttk5IyHkqFmxESzfa2uJMR1cH3W+zpBCK5JI24UeurJFxrVv3sYY
	zFE=
X-Received: by 2002:a05:6a20:394a:b0:3b3:d0f:7883 with SMTP id adf61e73a8af0-3cd2fea4c45mr19321557637.7.1787384871064;
        Sat, 22 Aug 2026 00:47:51 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1593060e8sm3616213a12.32.2026.08.22.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 00:47:50 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: mkl@pengutronix.de
Cc: mailhol@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Sat, 22 Aug 2026 07:47:01 +0000
Message-ID: <20260822074701.22856-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend 
and resume callbacks, also reduces kernel size in case CONFIG_PM 
or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
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
index baf494d20bef..b2a0ff8c033c 100644
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

