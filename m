Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185503EDABC;
	Fri,  6 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814605; cv=none; b=rd80q0EUndPgoROO7Va7eKH6bidkRJ8ErQXCOAc8z06TPbrkC3i61kOQ3xviu+UxYWF/0fQOAKgDTWnLHkijytBvNmn7tCi5PDKvrAnPLVbC4tndnTkBtLQShS7fB1a5kF8t13gyTk/7j6YWgwMr/rJhF4ln8AbuIR5hmyp+DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814605; c=relaxed/simple;
	bh=ajVC59DpGQnhF76fmIDA30+THs0hk+AI3phoAt+fkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKizlftvNhe7aS0zn7q+rxTxEID/M4bpjCTTRy0GkZ1oCbhR1mCK2HvlvBT7VYRuxdzSCF/6eVb3xPDTj32aX3SmYt1GzSkM4J99EuDJRs/a9mRncVFT54ZN/5J9grXU1yaYxarP/7ZvvuyRBSr7JLJbQeD1oNVUSKSxjJcBugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=A4IsRJ1r reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="A4IsRJ1r"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhC2Jjcz1Fljk;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhC0CGZz1DDgW;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814587;
	bh=upU4u1eJLfMz8n7CUAHXsVmudBTZqYBIgYsKLTy7nOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4IsRJ1rmCikNr1GeVaBfh0K7JcL2/esjolNiAfxP/pYY5R+srBFRa5kQkX+ZC+i5
	 NFsbwcuHC5zQsv0S8uHKfoEqmc2L7+tdg0d/mhDmBsDsaO9rbErMK8ZO4A/H5MRJSJ
	 ISv/bll7O8Qn0kQwz6eVrPK2CV9BFcnxJJ+gtBIGKxC3aU4qE4bNt6mr1ChepRCdkB
	 piwUIqtYinlTZ98xUdBcuVw+zHQ5fioemE5Z7RdS+oCkz4ZXwIt/IPMzuXwGKHU+j4
	 /EaWgOIG0n3oFkpputTex10ixAeux9o/PFuVzan3u1BmE0ufwJWE2y+0IQpwjoHShE
	 j3RlKtsDT98iw==
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
Subject: [PATCH v6 10/15] can: grcan: Reserve space between cap and next register to align with address layout
Date: Fri,  6 Mar 2026 17:29:29 +0100
Message-ID: <20260306162934.22955-11-arun.muthusamy@gaisler.com>
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

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 1cfc8d90573a..b51b4235b1e7 100644
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

