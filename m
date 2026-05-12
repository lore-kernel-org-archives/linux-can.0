Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB03911D5;
	Tue, 12 May 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591170; cv=none; b=BiJgm79MNxj1h5U679gm5ZFVq/BensD7obUyYlEzJ+pXlrzHpvW87COpnQ63fYMRVWvS0I5WIfTjrQEpyeL3wobbA05Dj0dJZbOqyjJi6+y0fq8c/+ZSEVNx6RgyZ5N2rEhH4BYjuG2oK0W6EC4DuORdawxLr2d0o2/En0nWhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591170; c=relaxed/simple;
	bh=aWyJaQvi0RjHwj/BHyzTjrlBIlDr2rwbaqRKmtrI03w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyepy3LWDbCIwLvOHSTU+SQR7N3ppb/W7tvRMYkv8tYKMmzrbRjo9mUDJG4bllcKBkPWXnnpwLL+Ako8XCWQlaKdCaSNK1hChlmjcIYi01Kaq+uAFq1vpA2ezD/QuTC/SV7I8EspiE0QwTXVklfA/7bOL61KinLmyOMOH6PXc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fw9pmucW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw9pmucW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591170; x=1810127170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWyJaQvi0RjHwj/BHyzTjrlBIlDr2rwbaqRKmtrI03w=;
  b=fw9pmucWvHs3dYCdcIcb65Z4AmV4YmlRIiOvewAbkOPOlzxOkb3dpacT
   LmaVLufeF2CXaRbBOvwZeGRG5biwZBSBeODnOSdBcYHoitUnLlk0bSK+2
   LTWUoQS7Y10TksCh/D9g7oGOcpiVZI3K65EazTazlvtgaWvA44vf8oOjd
   3zzJtQ4x9yM30bxnK/PWUgY0V2zY0YGUCndH11jOtCeZZJ3gJkzorAkdC
   XKeiJWB4iU4rrpfvBEQnWlTUp38Llyln6MB3l8xPPIFm2DJrZdf3ygDWH
   CYMEyifWBy8Tl/OQbSV+oOjwYAPPNYWNGhZBvYtii1TCGozfY195keAqX
   w==;
X-CSE-ConnectionGUID: tztUK6ynSoGSO/x6I4SAWA==
X-CSE-MsgGUID: Mc3TIszZSmajRcxVvO4Qig==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90600382"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90600382"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:00 -0700
X-CSE-ConnectionGUID: mRMRMezYS/KqyfWN7E09fw==
X-CSE-MsgGUID: sf3sO/OxQ06rWeh6Hr3eLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233294183"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 12 May 2026 06:05:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7DD1C9E; Tue, 12 May 2026 15:05:55 +0200 (CEST)
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
Subject: [PATCH v4 4/5] phy: phy-can-transceiver: Don't check for specific errors when parsing properties
Date: Tue, 12 May 2026 15:01:52 +0200
Message-ID: <20260512130552.272476-5-andriy.shevchenko@linux.intel.com>
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

Instead of checking for the specific error codes (that can be considered
a layering violation to some extent) check for the property existence first
and then either parse it, or apply a default value.

With that, return an error when parsing of the existing property fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 23655956ace8..973cc7ce651f 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,8 +128,9 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
-	u32 max_bitrate = 0;
 	int err, i, num_ch = 1;
+	const char *propname;
+	u32 max_bitrate;
 
 	drvdata = device_get_match_data(dev);
 	if (drvdata)
@@ -151,9 +152,17 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
-	if ((err != -EINVAL) && !max_bitrate)
-		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	propname = "max-bitrate";
+	if (device_property_present(dev, propname)) {
+		err = device_property_read_u32(dev, propname, &max_bitrate);
+		if (err)
+			return dev_err_probe(dev, err, "failed to parse %s\n", propname);
+
+		if (max_bitrate == 0)
+			dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	} else {
+		max_bitrate = 0;
+	}
 
 	for (i = 0; i < num_ch; i++) {
 		can_transceiver_phy = &priv->can_transceiver_phy[i];
-- 
2.50.1

