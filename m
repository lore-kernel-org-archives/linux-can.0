Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3D4F5E0;
	Mon,  4 May 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878063; cv=none; b=HM7sPQer+7Xqirp0hlE8DCslF19uqPvcfBGvSMBZsu4/bQZYaCQ3o+cVx1z6GfrpDYCmyTGzeiPz/6Vnf60oGT2WCXA9pRqLBcbxYOiXMmjUuot4/i0zTSTe3ZqYs85PZOFzwphWTEFCQ+0yMkm/pJRtjUlva6jq5bbG3Ipsh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878063; c=relaxed/simple;
	bh=KxWs9qmEPOEiZlGqedJKlS+its/yHjm1HTMluZhe4cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhX/4p3O3KAjmriG0sNME20uIm7f6GC/kkQ7wajt8McXDO4Yk9Q94WkpfmXUjS5AQgx2Bn0s4XWGzO3HEmzj63ay/0TOS3Hj7DLwbAIYU6EqH78Chub550hjAUI0jBoyiHwnLkjGJNWmJ3wLNj0f7kgJwa1Khc7YAIfwHSQnbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDeV+tbd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDeV+tbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777878062; x=1809414062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxWs9qmEPOEiZlGqedJKlS+its/yHjm1HTMluZhe4cA=;
  b=mDeV+tbdtQIV6TJO7XLr+x2DycTeB9dZxMTazg3L5Y5Av8br0CmMLXRG
   GnWjdJ/nwWrS/NPMZ8of0+kQjG3/h222NNRCYHkdtD+/0ZS24eGURszir
   HcDlUglly5eCIe5QFhdDe/OncPAGcWy+Det2fcNuQe4QMUsjxE1DLzAca
   LWxCITehSwDVSMurIXm4CfYkU1iL9djA4DYeZ4dUBaWWHNrH8qlMCSoue
   5ItNcu8GCHdMKRqUsWTEMJQX/GBvknBqTF8oE96AQbl7SwwHqMlVKKE4i
   S8llv3gkAs5ZSdXXBxahRkbMNeyZJgMfS5UiFYtTEpUKaeTJWFV2PbOof
   A==;
X-CSE-ConnectionGUID: K0YQaQ9URKepIFa0r/mMCA==
X-CSE-MsgGUID: 1YO/cASASji+ZanT1rJO5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82582122"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82582122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:01:01 -0700
X-CSE-ConnectionGUID: lFWrn2JwSOmCqoVduvuxxQ==
X-CSE-MsgGUID: tAtiDNAMTouiBbaFYNoCFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239409099"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 04 May 2026 00:00:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3DFE09D; Mon, 04 May 2026 09:00:58 +0200 (CEST)
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
Subject: [PATCH v3 3/4] phy: phy-can-transceiver: Don't check for specific errors when parsing properties
Date: Mon,  4 May 2026 08:58:54 +0200
Message-ID: <20260504070054.29508-4-andriy.shevchenko@linux.intel.com>
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

Instead of checking for the specific error codes (that can be considered
a layering violation to some extent) check for the property existence first
and then either parse it, or apply a default value.

With that, return an error when parsing of the existing property fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 8411d36b463b..238c7963724b 100644
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
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
@@ -148,8 +149,15 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
-	if ((err != -EINVAL) && !max_bitrate)
+	propname = "max-bitrate";
+	if (device_property_present(dev, propname)) {
+		err = device_property_read_u32(dev, propname, &max_bitrate);
+		if (err)
+			return dev_err_probe(dev, err, "failed to parse %s\n", propname);
+	} else {
+		max_bitrate = 0;
+	}
+	if (max_bitrate == 0)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 
 	for (i = 0; i < num_ch; i++) {
-- 
2.50.1

