Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196A3112DD;
	Mon, 16 Feb 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250042; cv=none; b=b/QV1fsRgAJd2ompr7QrTYXP2nFdTT/4TMhRR/C+H4rapn3vNImBkXjLcGArAGq7vNlgSwF3XL9fZeS9mx0r4/89gRs7OhPXNP1O7NCwDFErVNT3ETzgPsD90Wv8yXkF03rDizq5PDn90f9jKs2Xq1mq77QFY7EOHRWG/fCnuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250042; c=relaxed/simple;
	bh=uVrZ0pyVLCvHW7B+h0I/LjU5mAmaJJk1PFxAq/SUBqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo7CxxYmCNgINnQebhEyd5pmC6EGJLLHPznZoohab8+YImYCqAmx8ns4lzZ3m9xyRttdl/0+DotYVHRVaUFJOr83rUciWVJdYtbYw6krr8GUsx3Q4Z7TldGR3FpUIHiN3uirQI3J+kzf2t/QkAXtmLhsKb2FN8odvqmFN1FhOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=G4rqTzCE reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="G4rqTzCE"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44Z5t1dz1FbwW;
	Mon, 16 Feb 2026 14:53:50 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44Z2Plhz1FbbB;
	Mon, 16 Feb 2026 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250030;
	bh=Xu+Tx4YbRAuYDk68YZmjQXkVSfoxhaU2CbP0o4HeWPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4rqTzCE0divp3RKvveYok7EwCVXwZVtW8GoI7iJVJOBC2r5phPqGyGs0KVCAik5L
	 fzsuV0hDTxoYVnGI5JQGnYlqGrLZKLN2g0nTPeWqMKS8JdDB5vQvVWJ1peoXaodFMK
	 geqZn79+qASRalhcbVdnS+gte8SAtBwLdSL6S4N/YRN37HgAoUb6v5djZCSzu8sHmy
	 r35LubN8L6Z7PSkLXg7Kr36VYtmk3/1XvJKrtxZH9JaStOxSLli06yrUY0zVR04al0
	 YnJmkxnljDnPwOWUeJA0m26/xaj/UkQwOr5zYSr7QYl3e4S3qx5R5KUxJyJtFXT3Cz
	 Y6Ray8m8G38+g==
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
Subject: [PATCH v5 09/16] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Mon, 16 Feb 2026 14:53:37 +0100
Message-ID: <20260216135344.23246-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
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

