Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B8311583;
	Mon, 16 Feb 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250042; cv=none; b=c35ecP4bRoP2/BX0T3BOx9rwENGQNqDobiL6fzX5C80+fJMy7JSPM9pZ21GAfVWmDKzPJe/j+K+Vgijgcti7QjN8bNK720lR1nyGVhpEibjuUn+HSJJD3eTg6J4QAKLadcci6GRG2RNBTFn8xTtwtpc0LBK860q1Q0vshWO6Zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250042; c=relaxed/simple;
	bh=llM/KzBhmu+L1VSf3YRy2olgNb3GA7BR8+7MG0A3LjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oerw3ctmWCrVOurKPy38sP6YFivvRmj316alhhK8e1X0udyp+eXDISL1ECPyXflNWCeNHTct8cb89/XhlTBJ4n7dzaeHroXmQPkz/k/dNMlCHTKa9HVEEcjh5Q7XBzs4+K6XnouvaEAF8m6B+qYSkXQGnZD3Gynk2bbDXfob0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=pYRH/vSp reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="pYRH/vSp"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44b43LCz1Fbwb;
	Mon, 16 Feb 2026 14:53:51 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44Z5c4yz1FbwS;
	Mon, 16 Feb 2026 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250031;
	bh=jXQcjRcxsrRIpmX3uVmGRrYNnSd0R0YaXJGt3CFoZWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pYRH/vSptesfA7htlh8anXgejD1p5X2YX2U1xpgucypt1gUq4dgSnAR0LXYL2TCIP
	 k1wTmj/pTJ0TNUDcp0oZJs38NMg0g+uiMxV/VDW5kc77eNeJcYM4NIU8wRSqHgJwN/
	 VjcZE5E/Uiheo6JuTJas7+EhcajoWth0F+eVaGSJp7xxtKhp87fVopZdHrkJntz1ZW
	 SHjPufsHa+dHVPLfIlPao9G2Ch1L/P0QrwcFobHqBcnBZJlIeFU7/UAoZ3d71cubWs
	 JKLL4EdEdip8en5KL0AY0BQUXLxlV50ocvB0mFAxGMDlZu3CB1s7kSFJRKguLxHfuq
	 8vtUxDsxBT9eA==
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
Subject: [PATCH v5 10/16] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Mon, 16 Feb 2026 14:53:38 +0100
Message-ID: <20260216135344.23246-11-arun.muthusamy@gaisler.com>
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

While reset the GRCAN baud-rates are preserved, since GRCANFD has the
baud-rate in different registers we need to add saving of those
registers too.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 13dc4989f067..0ceda12335bc 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -525,6 +525,8 @@ static void grcan_reset(struct net_device *dev)
 
 	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
 	grcan_write_reg(&regs->rxmask, 0);
+
+	priv->hwcap->set_bittiming(dev);
 }
 
 /* stop device without changing any configurations */
-- 
2.51.0

