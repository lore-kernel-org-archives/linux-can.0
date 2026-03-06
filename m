Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F82BE65B;
	Fri,  6 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814612; cv=none; b=tCqpl+b1FA2mpgC6c4OojznkAuSa0ajYJVkhcUrCvpFdCuJMneK9FMbIAYib21pTsLNvO4fcXK/2/WzXTRyV1GCjK/uZwjya9dosSMorHs9RJ9umip9VwVMsocmiqf2U63G0gl4wZItRhUU0iRD5L45QbRL/KdPO60/Ep1JFNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814612; c=relaxed/simple;
	bh=mnI5oDMgftj6ROv25d9OoO3w8YnN1pQpJUb6cxATwdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaWSDM9UCDhJCmtkzgxfGr4gxhehm0qM7UuBA9CvW7kOHxtZU1LDXgJPJHdwy/pn5m313WdUZkPJwpzOosw4hI1R1D/DzCUK5Sw0aCI5T56WjSyKRFhlYMSW98xhdMLSpOjB1s8wuCTplxfLm3tSwCOaUUCqDj5SM83Gg1Of6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=SFRD93kN reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="SFRD93kN"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhD3Xnmz1Fljg;
	Fri,  6 Mar 2026 17:29:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhD1Rxyz1DDgW;
	Fri,  6 Mar 2026 17:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814588;
	bh=HEHS4MCK05/7iplJTF+QJ7BrkPa/UogpKyHpuJ4BN8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFRD93kNH0cpLrxRiys1ijob71KeDQW9Jo/4gUUSdaM49J5q2Vq3NBo6pNxp5eJSv
	 wsk3A+sRVJcqUbhqkbS7XFA9u0VY3VYz83jKDy3vTIEPc6Va9QHUVxfu+BN1U6pJvL
	 T3qkjQF2riPUpdbGGEkR5dCLg4UjjsS7BqCG78fp6tMYweJ6Gh06uPLRqUeTcvoTt+
	 6kdOQMog/Km3KokYALj/g0knicHgm3r5hcb97qbRJtybCI5Dkeb2ifZYShdQGBOATv
	 k4OK4Utc9Hy8g0QfKROrrF5GsEnBvjkF4Et7fK3pE84X/p12R59rGx1QZ0fnpA3jSq
	 8x0U+oSWBKZLw==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v6 15/15] can: grcan: Advertise CANFD capability
Date: Fri,  6 Mar 2026 17:29:34 +0100
Message-ID: <20260306162934.22955-16-arun.muthusamy@gaisler.com>
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

Advertise CANFD capability for GRCANFD hardware by enabling
CAN_CTRLMODE_FD flag and providing CANFD timing operations.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 9204fcb93b2d..bc1f205e10a5 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1767,11 +1767,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.fd.data_bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	if (hwcap->fd)
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->need_txbug_workaround = txbug;
 	priv->hwcap = hwcap;
 
-- 
2.51.0

