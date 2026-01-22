Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4D429801;
	Thu, 22 Jan 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083862; cv=none; b=l522pIvRRvjGYXPAiWrPuHuzr8yJfWXNOQtO8+AvTdPScjokLav4qBmVoFQWRIehv2vTtcJKRdWz/Q32ztj4ocCJ12/HikYODt20j0F3u9ZfBxwXc7NhiOWMoWzBByjT6tb8Z7lKozsYC0neG5LrIoLLXX6lOHcyNIV3Fc8xO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083862; c=relaxed/simple;
	bh=D9L9i8M12EsxiljRdseF7D25+qQuEpcvENTCB6hcrCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP2ywf6v1kc3l0MNFNoKkf9S+oWtB7gUOB71bKLKKHLwAwur4Lttu7TvGKq5vp9kqqCck/exwJTuc2p4TakSXFMEYVhKyqS/LHuhhzSpTbuwOT1YLSA7VR8vu3jYWnUk6NeLmUMBsD19qmFZwYVq7qziJgk6nNA5clBdksmvUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=dOg6EIOL reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="dOg6EIOL"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzF1TBfz1FlXs;
	Thu, 22 Jan 2026 13:10:49 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzD68MFz1FgdH;
	Thu, 22 Jan 2026 13:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083849;
	bh=Z9BHb1vgH1ymUiLA9YViZTEhdIFyi4WNzllEYLrgUw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOg6EIOL/dPTNklUDqTEcMdaC6cEeeSyciQSGdEbQt4ggTKLKR8xbhzUalJZrHnyD
	 ms3vMbmoMZIJYUKzaI/szijIz5Zm4m0SuvFOGOBQS4NmF4zYk8QSySZ9RlWAlsHHYl
	 GA9fjk2zreBhesnr2Das0TSe6KNBOH4nrNi8CPj2SvCEmInCMwwX78q6N0ivc1aZ4z
	 6Z563iXQzuOVByvZQ7SKNaRTXHApgV5LtzAnS7z6/YchfUwR1E+rGO3LjoORvK67Wd
	 lXm1+0gDi76c9Wp0q3jIMmx4qxIv0A1hSJ1MSSB0rm8Nc0uO/TYMOH1ma0simYDGsA
	 L93Yes7DC4pDw==
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
Subject: [PATCH v3 10/15] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Thu, 22 Jan 2026 13:10:33 +0100
Message-ID: <20260122121038.7910-11-arun.muthusamy@gaisler.com>
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

While reset the GRCAN baud-rates are preserved, since GRCANFD has the
baud-rate in different registers we need to add saving of those
registers too.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index a2a5a5c868ff..0ee6e9bfbe7f 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -517,15 +517,27 @@ static void grcan_reset(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_registers __iomem *regs = priv->regs;
 	u32 config = grcan_read_reg(&regs->conf);
+	u32 nbtr, fdbtr;
+
+	if (priv->hwcap->fd) {
+		nbtr = grcan_read_reg(&regs->nbtr);
+		fdbtr = grcan_read_reg(&regs->fdbtr);
+	}
 
 	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
 	grcan_write_reg(&regs->conf, config);
+	if (priv->hwcap->fd) {
+		grcan_write_reg(&regs->nbtr, nbtr);
+		grcan_write_reg(&regs->fdbtr, fdbtr);
+	}
 
 	priv->eskbp = grcan_read_reg(&regs->txrd);
 	priv->can.state = CAN_STATE_STOPPED;
 
 	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
 	grcan_write_reg(&regs->rxmask, 0);
+
+	priv->hwcap->set_bittiming(dev);
 }
 
 /* stop device without changing any configurations */
-- 
2.51.0

