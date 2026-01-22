Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4343DA55;
	Thu, 22 Jan 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083862; cv=none; b=hpWWxocE9s0e3a2UYIGN87nyhcAW9PyLTDgT+b3TmGOET1FcNVUkmAInAr1vWoYiQsQpetVv7M/BxKJGS+RVHWCAIBnAkfU1ZxVjGUtHb59qjJM0p3X8SWA8Drq4VfN29tuSQGiqraYJktmI0gxsKjYxPHdZRGU263mwmnPyG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083862; c=relaxed/simple;
	bh=vd7GadClo/RlrvKYnks9oUL4JQToH3YvUgrlmb9pj/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP+Y1/wR++YAo9Zktlo+H77L9G85xD1eGCr2ah544SWCNbO7ZiUXO5T/YXICxJ3iftxlZtrW8zlgbYpO1Cxu6mFS4fjIAVVK8K2sy9lE7Fwrm4bbX9VyHQnR61GkG80x11Q0//NfQ+sKKBbC0iCp93MonttSB94huwr5PScPyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=OHP+mcX/ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="OHP+mcX/"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzD6Mp9z1FlXw;
	Thu, 22 Jan 2026 13:10:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzD3pm5z1Fgcl;
	Thu, 22 Jan 2026 13:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083848;
	bh=LvNXlj/JjGmCmxw9Wh5XNyDZed3gle08v8TWEGLebtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHP+mcX/8wsU7uZfHoJY6br9vYqjHV5yKd7fKHb4EFcYD7funhlWy6coRB8gqQ/6z
	 IE2Z78+maYnHksTCcs/Syy7zb1sD/XeC+NmKwx7P9tIZgB+k38kMBPEE3zdrtmpDWa
	 slG+8freLPdYTxGVnGclp/xNbpXE0+FMc3hMvEyMrPcaKi05U2NpoRTb3Jjxj0TqBH
	 F9SOo5cPo+9pBZ5T6+ZK4Dpt39vxb0rQK1vh5DeSS1xwBM+Z9xyOqLBcQa+z1hO8ZE
	 pce/C0TwpGEsBDfqcf2FQKo62m0GFfTEcTOpqEGytShpf6rqfpRILqsjky4oPTUKZd
	 gxqWqp8gjuWOQ==
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
Subject: [PATCH v3 09/15] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Thu, 22 Jan 2026 13:10:32 +0100
Message-ID: <20260122121038.7910-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
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
index e2415529db45..a2a5a5c868ff 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1747,6 +1747,13 @@ static int grcan_probe(struct platform_device *ofdev)
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

