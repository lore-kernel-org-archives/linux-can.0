Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91B3644BB;
	Wed, 28 Jan 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611774; cv=none; b=MCi5Y0IseKF61LFRQO9JmqF2VuxoPe9PH1Hs/uqZHjLFATGvvCzYwxGLmaUjY62qN/F+Z8yLrdME/qy0u+kaOBp/ID13YR8Ee5G424A78vu4+oanYf0Hc7rFWDevAPuEaR/MtXwFdmim9YRrUFK4BsMkfqgrXGZy0LwFIYmDCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611774; c=relaxed/simple;
	bh=ypXQ3CGaxHltaC8+njiLV/XzkbBML+AAs9YiQAPtn+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlCVj1sBsofuNZiMBiEJuqbyBxuiBn1M2b7zpnqqbgWn2l3P3vxPqySoH+ClGWMRmcS9h6vlNRp7gvoGAv4Mf4bt1ZjWKy0V2QeREEMCxCNv6Kj1TM8MOxgm8o76JqTIvUUEwrOyOMel59//QgPlOznqX1I/uiEFwDuOVguzDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=iiSuj/yj reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="iiSuj/yj"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCY5vB3z1FQVs;
	Wed, 28 Jan 2026 15:49:29 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCY33PTz1FDXm;
	Wed, 28 Jan 2026 15:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611769;
	bh=Xu+Tx4YbRAuYDk68YZmjQXkVSfoxhaU2CbP0o4HeWPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iiSuj/yjRjJNCL2surRCDlxr4IqLqU2wEaprcP58KxBPuNP6q9E9wx8v4CGnmhyG5
	 m+cRgTaJ/Z0KLYhkdl+IlnOM0J1luhgbxBv8K/Dk/ayGGWws45kZqJ7D519TTUZc5g
	 KMyJqem3FuuxjXitZWv3+X3dptYeYcMp4UtMnsbvxU4YSisvAEmrAZKaWSlZ4MBpQ9
	 ZxHE8pXUjPA5njW8T8CxFMbWCBqzDE3Lvu6JlGPpIbxSnwrvj+WmNHXrFKQIwoH08x
	 JgrX2d+AkniB7f0gclGragXmuLcqaGrMiT9eScBT2A2amWlSNMGO/+nEQkTjqr48yX
	 VXwEoCWK53yUQ==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v4 09/15] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Wed, 28 Jan 2026 15:49:15 +0100
Message-ID: <20260128144921.5458-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hellstrom <daniel@gaisler.com>

Sets the DMA mask for GRCAN and GRCANFD devices to 32-bit.
Setting the DMA mask and coherent DMA mask to 32-bit ensures proper
memory addressing during DMA operations

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 29247e9860c9..13dc4989f067 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1741,6 +1741,13 @@ static int grcan_probe(struct platform_device *ofdev)
 		goto exit_error;
 	}

+	/* On 64-bit systems.. GRCAN and GRCANFD can only address 32-bit */
+	err = dma_set_mask_and_coherent(&ofdev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "No usable DMA configuration.\n");
+		goto exit_error;
+	}
+
 	irq = irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
 	if (!irq) {
 		dev_err(&ofdev->dev, "no irq found\n");
--
2.51.0

