Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595C290DBB;
	Mon,  4 May 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878065; cv=none; b=f5wRHqfLyQn7lmOMyGR5/FDmwq7J1UnNIZfSQmQWsuW/VoU4BhLPseDIcTe+RTjp/0j1xbtNBTNjuOgOl/9JhS3N2dEocVgZfw3I0SlEspXo702XvL4XUfUyaoTBb64KcBpbloiU4Mnv0+zZGf4SJYhsONWySeV+SQ0Ct4J57aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878065; c=relaxed/simple;
	bh=vmfXkYj/cbNHIuC2J2arXddu7xxbUuXL5odOPc/oqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duw1VWUL6CQO3tcLxq+9quNEoochAJol4tZCpKx8xsjjyIJ1+O3nuuvNkfFcmHFiaLhZGjSv9q+JL2mgeEvTD+9uX9XP1eksvPq6ECz+fHQDMcbMsxuEO7y+fTMXmd9Oaj8l2AVGAcknmtkR7N5Jtu4BAg6Hmr7seddzHTuH6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB9Mm7dc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB9Mm7dc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777878065; x=1809414065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmfXkYj/cbNHIuC2J2arXddu7xxbUuXL5odOPc/oqgs=;
  b=NB9Mm7dccwKV7bpXBU0KV6DEzfz3Tk6shEUvzCUOEOP5EpEHmiG9agvN
   Twt0qnWpViFB8a++4ARj07h9X4+eVZU42zKtKeqebw94HgLVUsRcxOzSK
   zLg/8vOhjjeg/dB1TAwb5GMCJap+hZ0JieTtWfPpnzWSlu1pOmPKf/Xz6
   7+giOuMGp++HXF8ptO/SiG4YwOISLDSEYcWfhduyzhc7IJ1Akg3tSnzl+
   jCsRKT5YYRrhKTswycmD4pybMsyRUnHqcZAD1peb1hbFkz0dTHAZFZKFc
   nR/Qh2lPJX4xX7dY2HKrDHo5iLT7fld3f+7fz4FwQQCL6GiJS7/alv72q
   Q==;
X-CSE-ConnectionGUID: xEwqDW31S/mqX19gxSUYRA==
X-CSE-MsgGUID: Vunp3VDfQ9unnkDjLNvwXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82344151"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82344151"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:01:02 -0700
X-CSE-ConnectionGUID: Ji82LhtNSia3TD2t7c3YnQ==
X-CSE-MsgGUID: Yva7UI7zQPWcu65RAb89EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240422853"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 04 May 2026 00:00:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 427439E; Mon, 04 May 2026 09:00:58 +0200 (CEST)
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
Subject: [PATCH v3 4/4] phy: phy-can-transceiver: Drop unused include
Date: Mon,  4 May 2026 08:58:55 +0200
Message-ID: <20260504070054.29508-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
References: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file does not use the symbols from the legacy
<linux/gpio.h> header, so let's drop it.

Reviewed-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 238c7963724b..eeaad41ab924 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -5,12 +5,11 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
  *
  */
+#include <linux/gpio/consumer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
 #include <linux/mux/consumer.h>
 
 struct can_transceiver_data {
-- 
2.50.1

