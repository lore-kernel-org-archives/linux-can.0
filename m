Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35D3F23D8;
	Fri,  6 Mar 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814605; cv=none; b=CfJgJnuZIhMxBurOKeQLaI6G5x95nV60Gp5+WL7aiDPC7w48IITyC0qkyiO9Ktri5aZhgeY/PPmfE/5wX37l+k0u1vdpzSHorNo7AVfDbv5/jQkNwIhLMmVdpy2sEVCkNkKYBVoyKFWsWMjMKhESjYlFusejAjCBhncZai67G3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814605; c=relaxed/simple;
	bh=jxTYQKjJc9VfAgRwg/nZ6qy1YUH+cw2WrnuOXz10Qug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwgKgWZoyPnVh+TUE5RtBHTBLFFn8xIZ/MyFtvSYt/NhSikKk1ALhpjyyxZNaktJEAUf/vpsImV1N/Dl/X2/bfiGvQ84T+aWe1Ceaa5mSAobtJ1T9aBqZfvzLdD6kuIkUPd+l0T+bZ/TimgmzQMbV7TNEGFUsyvu1gD7Ug9VybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=j1PEuuWW reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="j1PEuuWW"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhC0PVrz1DDRx;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhB5PTTz1DDTQ;
	Fri,  6 Mar 2026 17:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814586;
	bh=2H9zcDHFJZTqODlTnjEqtv89BRBVUKCoeaXN9y9asDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1PEuuWWnCCmWZJt7vXoj83rqBAe6C5KY/f/W/hQH/hVYsZnYAvASSFMbEcaW23bN
	 XreFZwv3rxxoU4orGPiM9Zu28G2CxHI15nPI3dfcxA4pVws8/NqvrkwKKmUihweQ0q
	 GncKITFLSLnw3ZDhGu0YqlLnz/z2SiJfYihoL+40tyFmqQQbRU8szWfdr5IrgXVqo3
	 QTqc2lGbmPx94XMirlJzKGZ6z/Jb9fqD/5e6IaG1xIMwb8E5Muty+PGeNY7UYGyHnq
	 8CKRnLiUmSFo0I16GzYbWbnzEze3pWKaKJ7XUNgTiS3lWaQPA8a9QyENnijK0/IUFm
	 74w8W/4348k8Q==
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
Subject: [PATCH v6 09/15] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Fri,  6 Mar 2026 17:29:28 +0100
Message-ID: <20260306162934.22955-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
References: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
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
 drivers/net/can/grcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 74caedbcd55d..1cfc8d90573a 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -528,6 +528,8 @@ static void grcan_reset(struct net_device *dev)
 
 	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
 	grcan_write_reg(&regs->rxmask, 0);
+
+	priv->hwcap->set_bittiming(dev);
 }
 
 /* stop device without changing any configurations */
-- 
2.51.0

