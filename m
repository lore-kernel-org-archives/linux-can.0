Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D5C433F5
	for <linux-can@archiver.kernel.org>; Wed,  9 Mar 2022 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCILQT (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiCILQT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 06:16:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9A13CA2B
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646824520; x=1678360520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tk17XVUpxEeDFnWj59KdqXFWoS0EsH1RJX0AneqtpU=;
  b=UrRscGFzdcTO/thS/cF8f2M+bVY99lXqGelmwfOtz09AVPsiD7qR7oPS
   zjwZlsc2euYyRp2PKbZdgaz+MeV/lFLE6BmacJ+Lgf6f8n7PdBdb3IDQl
   //V+TMfDbQ/RnaSVNtT5hfgw8i6apyPRq098m2rcXFytHUhtQylJZBPzZ
   WsV5L71htCBtdbWwXHnADMP//gI+cCmTUiMSHFcysrGnuJhSAVXqUcEHh
   MnwcgecZ7ShQEW6eBaT1t93PqoEp0ZJleLg+vdem9K8RUD1omsKy3hZZd
   DKytZ8MiLAbC49jwiPhFrV7fz02ehtYb+hG0eBlVT7VXyOY4ao5Qk07El
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254892293"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254892293"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 03:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="547591822"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2022 03:15:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRuHY-00039l-Se; Wed, 09 Mar 2022 11:15:04 +0000
Date:   Wed, 9 Mar 2022 19:14:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: [mkl-can-next:mcp251xfd-coalesce 13/13]
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c:15: warning: "DEBUG"
 redefined
Message-ID: <202203091937.M6ZzGYRk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git mcp251xfd-coalesce
head:   031271d0164fc7de0efbc0afa8d4fada3197b30e
commit: 031271d0164fc7de0efbc0afa8d4fada3197b30e [13/13] can: mcp251xfd: mcp251xfd-ring: enable DEBUG for now to print FIFO configuration overview during ifup
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091937.M6ZzGYRk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=031271d0164fc7de0efbc0afa8d4fada3197b30e
        git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
        git fetch --no-tags mkl-can-next mcp251xfd-coalesce
        git checkout 031271d0164fc7de0efbc0afa8d4fada3197b30e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/can/spi/mcp251xfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c:15: warning: "DEBUG" redefined
      15 | #define DEBUG
         | 
   <command-line>: note: this is the location of the previous definition


vim +/DEBUG +15 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c

    14	
  > 15	#define DEBUG
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
