Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7C34CFD0;
	Wed, 13 May 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709825; cv=none; b=UNkMkplTkYuoJ203zTYNjEEZgUrqFGNPY6hcxgSxnm9bgJvU6/Kw8pVBpDlknd5GFMruZaVr91ox0C+sP6NjtXC6hjUbzF7xnRXFNmGmgI/ql2wzVhlhyFZcDClEgjm3rMPsJB9f8eBUdSaM5/1Jlu9+54r+XRb9gMVVZVGsXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709825; c=relaxed/simple;
	bh=dwFBnLXsBSJhM0CEDgNPKRthY1LonLKx8Vv5G4u3TV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gggleze/y/sVYAWSmzZomdmdQh0vATcCztJ+IOpSpr5MgfK1tid4n42eohiM4Lv5HkTo7+yc9yhMMTgTO7JmCchhbTlm+ExfwcPczqOy4kjDP9RotMbaZHVtfbcrDdPwHQ/by/WlCEyAnY6tfTmjw4LcD6ZS00sU3sIHgZIqGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLsQAzn/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLsQAzn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709823; x=1810245823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwFBnLXsBSJhM0CEDgNPKRthY1LonLKx8Vv5G4u3TV8=;
  b=NLsQAzn/HFxZdNKAqqGSNXJ05VvlnHvmySNNDP5OniVgi0qafXXSkSH4
   mrXtFsaO3d/2qSsf+CwxHo+jTxZid+FcAAvPyZR6DBpz22/z1pmxiZLxM
   o6rgREP/q+sKqCAY6KgzoBb5kMeB3bvv5BDf1uGMY5j3Phrj80g8O4hvQ
   6igiW19EjqXaUVcuqLSINMeRnofgoiTJnyIyffA6vZBcR3Hz7gSwpXM2W
   B7E2sxDL/tIM0Ti1VGkvfLE5kcjDxabetzKlxl+oi9Irjy3kH1Xepzju1
   FCet0kEPxMvSKSfYPKeKkMmCkLOu0vnzXPrSym5I0qUm/8V7agFRmA5T3
   Q==;
X-CSE-ConnectionGUID: N+nTQ9VaQou7QOweRV9J3Q==
X-CSE-MsgGUID: Pl5gOI+2TvOOC+auZ1Yoig==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79600738"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79600738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:42 -0700
X-CSE-ConnectionGUID: HXaP3u2zSlmHvqU9Upj2Rw==
X-CSE-MsgGUID: VQ9ATF74QHWiC3PJQYuEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238447029"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 13 May 2026 15:03:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 93CBA98; Thu, 14 May 2026 00:03:38 +0200 (CEST)
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
Subject: [PATCH v5 1/6] phy: phy-can-transceiver: Check driver match and driver data against NULL
Date: Thu, 14 May 2026 00:01:26 +0200
Message-ID: <20260513220336.369628-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
References: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
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

