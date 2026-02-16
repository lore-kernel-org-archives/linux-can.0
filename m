Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A830EF87;
	Mon, 16 Feb 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250042; cv=none; b=IzJzrp0OpQGpyFXe7JOUgcx68csB2l+6aPxfxVjid9LBrJbaOPwCiSDutA3DmiE8LokTB3iR391ifz2MNxtwu4UTRWxl45FtgcGSVuVoYGxqLFKNXP1Nj/k9aLG1hdQvC8gMNaJfJNRgH5PVL87Ng2gg7F9V1gPncO0Y/YW1ugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250042; c=relaxed/simple;
	bh=6MaiAjXRozwgWtPwUfXezORiF4z1nInsBf7XwPWop3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvyJhT3SoXglmnkRi5rVI1FyRzf/7mQ9z//PdEh1Sj+FzeHaTnRuv6d3ciScUXIrtOEZCcEmPJreJDk4F3oLhYb578aIOdmb4/c1mjACWXwfAZFye5M5LUzfHp/w5ymukCnuGqPCN9RbLuLbf4+/iofrqN56c8qAoKxQAF8HHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=B/fG8b+J reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="B/fG8b+J"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44b5t3yz1FbwV;
	Mon, 16 Feb 2026 14:53:51 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44b3XbJz1FbwR;
	Mon, 16 Feb 2026 14:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250031;
	bh=XhDpIgFvLtKYCf6Xd2LNeTP2TSc4kdJLbKvmX5frO1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/fG8b+JvkRzyjv405dGcF6c5/tKIDXYq+IS2nHdHWjmZ2R9dAhDvUgiNnLfy811X
	 nWEE4BMhUcSyLfww0xOXTC47P6z/ypnG/itAsXlj6ALvY+bszPeZ7NlzWVsWT4WdWY
	 /675Ra/xe1V5EplLZdUigjLNzJ5FKdBvkoYGmjT4jm61T+h6TQGwv1gtD9zsrJNBi/
	 8q6hOmK6dbACz8m2pdbVnfwJfMafVKJVn6RPoqxXDqv3CkbEUZxqdDYvoE1bfNAMSz
	 bMnA+H1XvoqEqQU+pZYAX338Cx+w5kuXLZU4HvtpdTLvp3jNfN9EsvST1D91zU17TJ
	 iJP1+YVyvqjZA==
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
Subject: [PATCH v5 11/16] can: grcan: Reserve space between cap and next register to align with address layout
Date: Mon, 16 Feb 2026 14:53:39 +0100
Message-ID: <20260216135344.23246-12-arun.muthusamy@gaisler.com>
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

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 0ceda12335bc..3104946071dd 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -49,7 +49,8 @@ struct grcan_registers {
 	u32 conf;	/* 0x00 */
 	u32 stat;	/* 0x04 */
 	u32 ctrl;	/* 0x08 */
-	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
+	u32 cap;	/* 0x0c */
+	u32 __reserved1[GRCAN_RESERVE_SIZE(0x0c, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
 	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
-- 
2.51.0

