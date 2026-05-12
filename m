Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910293905EE;
	Tue, 12 May 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591167; cv=none; b=CS0nYiXCBSEkUcldIypD3VNOuuuw2Loh1D+wQlSt1OnEb0n6cSCXnxFoIW+lH2nt+ha6Eod8wC3KIWU+BSVxmTtJsyuX8BK+v2Zigu3aqsSnBFR5b+ByMteo3BImdu29HgFkJT4AF8C7YQGhQk5lB6FZBGi0xzd2oFsaeiOAz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591167; c=relaxed/simple;
	bh=dwFBnLXsBSJhM0CEDgNPKRthY1LonLKx8Vv5G4u3TV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpGUK6AhYDfXhcFbf4fX/xSCTqslBFltnwPjITITvxpPm8k3leVzJwBkzd9OQO24sdiAskw6cu3TXgcuHD6H5CAcJq8QrOuIx1oNRJF5BbDHuiAIajSocoJYp1/4dQuQez4dLoIcbabtbHFzFmktNTU89/lu34Zk7Z0Mb7xq6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfidDW5F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfidDW5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591167; x=1810127167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwFBnLXsBSJhM0CEDgNPKRthY1LonLKx8Vv5G4u3TV8=;
  b=HfidDW5FfuJhrLX34jepDLrgSy6ROgkNmM5cvwQ9WuZlr6VS2grj/REp
   TUnR2PXEG09tSC1v4MQXZc3LIwkWEWaI9ESoTOYT5Q4UEELoBcsP7Jrbc
   WcJ7kTcBBtKbUP/pQD6xHRnqD9IrjLPdfhzQG4pmlB0VJOp+cJsxoFZab
   rE0WbfV0vhUuzVKiH8oCcuJSK3GhD4yNhToq5I5oF2xyD1BwRLvFw6ku3
   J++1CO365OzDmGNJJVJR4xhxx6Iy1NzLDVfVm68jTNoOYVdqrIN02xTj0
   TMk1/0vafPylnOC4igCf7Kc8bhaaKAM2NQ2xFBEhr8RFD81C/WVYDMl2j
   g==;
X-CSE-ConnectionGUID: dimG4HqYTNCN7qTCgi0thA==
X-CSE-MsgGUID: 6aIMw2EITjqhBaG41BG33g==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90600355"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90600355"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:00 -0700
X-CSE-ConnectionGUID: Y+1uMqVPSRezwEe6MW80Hw==
X-CSE-MsgGUID: cGT3AJYYR/q/bPajHAkS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233294181"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 12 May 2026 06:05:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7094699; Tue, 12 May 2026 15:05:55 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peng Fan <peng.fan@nxp.com>,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/5] phy: phy-can-transceiver: Check driver match and driver data against NULL
Date: Tue, 12 May 2026 15:01:49 +0200
Message-ID: <20260512130552.272476-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512130552.272476-1-andriy.shevchenko@linux.intel.com>
References: <20260512130552.272476-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every platform driver can be forced to match a device that doesn't
match its list of device IDs because of device_match_driver_override()
so platform drivers that rely on the existence of a device's driver
data need to verify its presence.

Accordingly, add requisite match and driver data checks against NULL
to the driver where they are missing.

Fixes: a4a86d273ff1 ("phy: phy-can-transceiver: Add support for generic CAN transceiver driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 2b52e47f247a..1808f903c057 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -162,6 +162,9 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	int err, i, num_ch = 1;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
+	if (!match || !match->data)
+		return -ENODEV;
+
 	drvdata = match->data;
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
 		num_ch = 2;
-- 
2.50.1

