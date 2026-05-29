Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02114A8B;
	Fri, 29 May 2026 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015460; cv=none; b=m/kUTxH8okyukdXH4qvt06WuwL4dK+AvllTvS9tTCT3FU4tmC0+KZ4gxVpAumFzYwprkHooWSBHSnOfaimR1p5ZKQczBdlOE9T5PRzil+IzwF2HFhcCK3WOPsKfmIMQyEqYhSIZo+VNtOvlvU9PZUotdV78usO5zqUyvJmaHZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015460; c=relaxed/simple;
	bh=zNzgnfJ3a45cpED8SGzfgLkvLRVzA8fRgxmHggWk5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHSBbiQwPzgNELynA4z5Ge+o2N8cQl+vcv4LxMxwPtb8PpZKMGfChSQXITZ5aDSnRVbJITV0RpBsjeOIcWNG4aaeNaoO1bgLQzWoRboNvvjc9EwKE2WGrsvtH7NiRaWC+/Bp3H95V4xkNQStPwY5+lyTlkowRIq246FDd3+L4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8vCDQKN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8vCDQKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780015459; x=1811551459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNzgnfJ3a45cpED8SGzfgLkvLRVzA8fRgxmHggWk5nc=;
  b=X8vCDQKNbRWC1FgAdObVjgv/cDxFvMZWn6gnnGUGDCTjBrp0tZ82x6jo
   xscgX8aNDw5hlG7SpjL10EF25Ny4oWlCQHNOGUpHKmc5yUZSeIxLat9IV
   2YINM3FfSiJ4pAhqepKdccAAALTc3FZVtlyr9WACUKYNq9ccTqPR28R79
   ZBtRrZHyA7oizAjlxWsc9bameaqFrbECEBs/DRmX+v9TbNHYbiTk8N8r0
   6BrgN2UpLH4e7QvsSOUWcl1Wei6l0jZl2EFIG+zDv4NYZIw5FFFQJboL1
   uOsUlGJUoWMqwImuNEJaD2TOra/R1T4XgEqYHXFz7qekvYuXL5CgBoK5r
   Q==;
X-CSE-ConnectionGUID: 8B4Q0MaPRQCvT7k89oHVFg==
X-CSE-MsgGUID: T2PrUebmSne+y29JPuCrUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91175595"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91175595"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 17:44:19 -0700
X-CSE-ConnectionGUID: Pw53IHidR4WMpX5WkFegkQ==
X-CSE-MsgGUID: tRqCjm1tQrih2B50vzzuiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247790756"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2026 17:44:17 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSlKg-000000006bW-2XHs;
	Fri, 29 May 2026 00:44:14 +0000
Date: Fri, 29 May 2026 08:43:38 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <202605290854.3UtkTrpM-lkp@intel.com>
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e7d700e14934e68f86338c5610cf2ae76798b663]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig-The-Capable-Hub/can-flexcan-Drop-unused-platform-driver-data/20260528-181620
base:   e7d700e14934e68f86338c5610cf2ae76798b663
patch link:    https://lore.kernel.org/r/20260528094540.1867783-2-u.kleine-koenig%40baylibre.com
patch subject: [PATCH v1] can: flexcan: Drop unused platform driver data
config: powerpc-randconfig-001-20260529 (https://download.01.org/0day-ci/archive/20260529/202605290854.3UtkTrpM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605290854.3UtkTrpM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605290854.3UtkTrpM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/flexcan/flexcan-core.c:296:42: warning: 'fsl_mcf5441x_devtype_data' defined but not used [-Wunused-const-variable=]
     296 | static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +/fsl_mcf5441x_devtype_data +296 drivers/net/can/flexcan/flexcan-core.c

4b702878afc375 drivers/net/can/flexcan.c              Marc Kleine-Budde 2020-09-22  295  
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02 @296  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  297  	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
c5c88591040ee7 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-01-07  298  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
d945346db1ef41 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-08-11  299  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
d945346db1ef41 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-08-11  300  		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  301  };
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  302  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
