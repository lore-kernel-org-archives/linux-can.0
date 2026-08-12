Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B33A9E2;
	Wed, 12 Aug 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530592; cv=none; b=CNtydByQ8ay66HY1dBP3Yuc5jl9od9bDz1o/nYGkhvrsdKPZKJ7c/SJ8a/3fzaAHU+x7DeMsItpdxf5yanqErOr/3URq/TSbYGZFQVfKdl481IJFh9pPq/WoBopyhkz5JCcJaYygIN795b5WH+NmMPHzDQle9xjsXAzZF6zYARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530592; c=relaxed/simple;
	bh=zfCNvq//qRZ+PVYy6rvWvuJl3+hl+d8lic+l7PzQQkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq8+rSRZG75gduQlPyrNYOK8YeWCTpz3pbiE0877gk1BrFzxkE8/FthasfMRLlNhJJpckR0mmXs3FS/PYOOfNg2dv/4oVjx0TWKptSIsSYXaafepQtGzYwcbNqAfgfDIUmQZMV0Efzk0ITbyyzFkg7kOIyxR/ChCBYtG2rzOMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnL1Sv1T; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnL1Sv1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786530591; x=1818066591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zfCNvq//qRZ+PVYy6rvWvuJl3+hl+d8lic+l7PzQQkM=;
  b=WnL1Sv1TeeJ2WqHGxFOVJiWc7vgQd0NQxFHwkdFLmPklOcyUpmFmQVRk
   9vZ3LM65Rr7RDlsYUMjzK/NaZ/vYLEzYlI8l6lir4MfaIGe7ZMt0ULSRx
   aAYRK+w0F2nrH6QAVAMFfS4qNznap/T32em1aLCglih0d6p8BVsgdBr+O
   kR1w76BxH64h6KQ+npMN1WDI9HaueKTcP+vf3HQ8a4IDEpbE90QzQ2FAT
   zHBDni5M5CeotCZknSbzr1oOIInVc2PMabRFR5O9LMO9y3GR08PD6K98A
   i8RlCallIB5z8nG7ta3HHJoRDT602W3ec0SDLrpMO8t+xDn9tupt8qXY7
   A==;
X-CSE-ConnectionGUID: CCMpijGrQQaR9hof3dEzOQ==
X-CSE-MsgGUID: 6tKcEUQoSp60/B+51R5OSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87154617"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87154617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:29:50 -0700
X-CSE-ConnectionGUID: ZQcJcK+gSzeCez+2NaclQw==
X-CSE-MsgGUID: chQddBE/QsesaolPx6vUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="260982799"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Aug 2026 03:29:48 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wu6DR-00000000QLy-2S82;
	Wed, 12 Aug 2026 10:29:45 +0000
Date: Wed, 12 Aug 2026 18:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Nyekjaer <sean@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <202608121810.7mcuyYMc-lkp@intel.com>
References: <20260803101927.17122-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803101927.17122-1-sean@geanix.com>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkl-can-next/testing]
[also build test ERROR on linus/master v7.2-rc7 next-20260810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Nyekjaer/can-tcan4x5x-put-tcan-into-sleep-when-removing-driver/20260812-163135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20260803101927.17122-1-sean%40geanix.com
patch subject: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing driver
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260812/202608121810.7mcuyYMc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260812/202608121810.7mcuyYMc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608121810.7mcuyYMc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/can/m_can/tcan4x5x-core.c: In function 'tcan4x5x_can_remove':
>> drivers/net/can/m_can/tcan4x5x-core.c:552:35: error: passing argument 1 of 'tcan4x5x_power_enable' from incompatible pointer type [-Wincompatible-pointer-types]
     552 |         tcan4x5x_power_enable(priv->power, 0);
         |                               ~~~~^~~~~~~
         |                                   |
         |                                   struct regulator *
   drivers/net/can/m_can/tcan4x5x-core.c:214:56: note: expected 'struct tcan4x5x_priv *' but argument is of type 'struct regulator *'
     214 | static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
         |                                  ~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/tcan4x5x_power_enable +552 drivers/net/can/m_can/tcan4x5x-core.c

5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  545  
a0386bba70934d drivers/net/can/m_can/tcan4x5x-core.c Uwe Kleine-König  2022-01-23  546  static void tcan4x5x_can_remove(struct spi_device *spi)
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  547  {
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  548  	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  549  
ac33ffd3e2b037 drivers/net/can/m_can/tcan4x5x.c      Marc Kleine-Budde 2020-12-12  550  	m_can_class_unregister(&priv->cdev);
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  551  
c81d0b6ca66547 drivers/net/can/m_can/tcan4x5x.c      Marc Kleine-Budde 2020-08-10 @552  	tcan4x5x_power_enable(priv->power, 0);
c81d0b6ca66547 drivers/net/can/m_can/tcan4x5x.c      Marc Kleine-Budde 2020-08-10  553  
ac33ffd3e2b037 drivers/net/can/m_can/tcan4x5x.c      Marc Kleine-Budde 2020-12-12  554  	m_can_class_free_dev(priv->cdev.net);
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  555  }
5443c226ba9166 drivers/net/can/m_can/tcan4x5x.c      Dan Murphy        2019-05-09  556  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
