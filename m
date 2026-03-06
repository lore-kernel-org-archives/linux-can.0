Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCC3F23C3;
	Fri,  6 Mar 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814604; cv=none; b=EG+sHLrEPi63GB65e+KNLO9seMmBeEvqV6T61oZIRuzU15mkrbcCjJUoHTlvHBDmUezq/BoebCSXMuLFX+LcbXf7SIMX/1fHqgn/neSpBGNV93qtGy7iS2IQUMD1FHXFj70uaItcaHIvsuxwCIQyx3kLcFvxreZXPmhVj5mpqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814604; c=relaxed/simple;
	bh=TWkjM+UW5DAN4D6Oye0M3JdjP5FNkom4GCXrYZNNyIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Z34Z34sydfoCDaiSkgeDbH0VgNdr+3jMnjGZDyYsxzR1jHLHdfk0sizTNZ2OM5YV+4oL9XN+DyRuM4EK8cERZPfC84YANqcTCJT9FCxtLMOcrEmXEYg5BZz4q8PaoSnGAiv6oXAMU2PN9gEjEsFYh78U27z8RyfCeLmB/NUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=c5b96DyU reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="c5b96DyU"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhB0NFcz1FlZ4;
	Fri,  6 Mar 2026 17:29:46 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBh95XCCz1DDgW;
	Fri,  6 Mar 2026 17:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814585;
	bh=2u/dURyvkjbBiJ8Nb2RyMQrghcOhEN6vRgEdgLNCLOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5b96DyUUUccK8NotSzVnPpr2f/1enkVOHjzKeyvXnuhn/ReKVq4r/5OjgTKEOWre
	 Qm7Iyd3XuJfc1FqtUEdIDRh94cCsTYPoUfuKAcV5TlW9FI6MpcYg/UAazvmEMcn7rc
	 fpfZm166qlFii/zH8QJvUotXDmGdPu/qEpqywOJncy2MxXfjqcKzqmRPaCPJihn62a
	 8K2nCrUE4kGh6QDhwZ4QJ+fCKvjONHfjaMIqL25K3H4bUUclwjcHEOLcaRNh+4w6+i
	 VvDonhYD0ERqQMA70L+wmQfl/RUVrQF3q4xsDKKtMcY4kR22x5SjsSgekigmSgffCT
	 iFIlReeTiCXEQ==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v6 05/15] can: grcan: Replace bit timing macros with literal values
Date: Fri,  6 Mar 2026 17:29:24 +0100
Message-ID: <20260306162934.22955-6-arun.muthusamy@gaisler.com>
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

Refactor the bit timing constants in grcan_bittiming_const by replacing
macros with literal values.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index f3821e224f4f..12fd4911add2 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -36,6 +36,7 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitfield.h>
 
 #define DRV_NAME	"grcan"
 
@@ -93,16 +94,6 @@ struct grcan_registers {
 	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
 	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)
 
-#define GRCAN_CONF_RSJ_MIN	1
-#define GRCAN_CONF_RSJ_MAX	4
-#define GRCAN_CONF_PS1_MIN	1
-#define GRCAN_CONF_PS1_MAX	15
-#define GRCAN_CONF_PS2_MIN	2
-#define GRCAN_CONF_PS2_MAX	8
-#define GRCAN_CONF_SCALER_MIN	0
-#define GRCAN_CONF_SCALER_MAX	255
-#define GRCAN_CONF_SCALER_INC	1
-
 #define GRCAN_CONF_BPR_BIT	8
 #define GRCAN_CONF_RSJ_BIT	12
 #define GRCAN_CONF_PS1_BIT	20
@@ -392,14 +383,14 @@ static struct grcan_device_config grcan_module_config =
 
 static const struct can_bittiming_const grcan_bittiming_const = {
 	.name		= DRV_NAME,
-	.tseg1_min	= GRCAN_CONF_PS1_MIN + 1,
-	.tseg1_max	= GRCAN_CONF_PS1_MAX + 1,
-	.tseg2_min	= GRCAN_CONF_PS2_MIN,
-	.tseg2_max	= GRCAN_CONF_PS2_MAX,
-	.sjw_max	= GRCAN_CONF_RSJ_MAX,
-	.brp_min	= GRCAN_CONF_SCALER_MIN + 1,
-	.brp_max	= GRCAN_CONF_SCALER_MAX + 1,
-	.brp_inc	= GRCAN_CONF_SCALER_INC,
+	.tseg1_min	= 2,
+	.tseg1_max	= 16,
+	.tseg2_min	= 2,
+	.tseg2_max	= 8,
+	.sjw_max	= 4,
+	.brp_min	= 1,
+	.brp_max	= 256,
+	.brp_inc	= 1,
 };
 
 static int grcan_set_bittiming(struct net_device *dev)
-- 
2.51.0

