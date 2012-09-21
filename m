From: "Vick, Matthew" <matthew.vick@intel.com>
Subject: RE: [can:master 110/171]
 drivers/net/ethernet/intel/igb/igb.h:347:25: error: field 'hwtstamp_config'
 has incomplete type
Date: Fri, 21 Sep 2012 23:38:12 +0000
Message-ID: <06DFBC1E25D8024DB214DC7F41A3CD34488EFFFC@ORSMSX101.amr.corp.intel.com>
References: <20120921121642.GA17278@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63622 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab2IUXiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 19:38:15 -0400
In-Reply-To: <20120921121642.GA17278@localhost>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Friday, September 21, 2012 5:17 AM
> To: Vick, Matthew
> Cc: kernel-janitors@vger.kernel.org; Kirsher, Jeffrey T; linux-
> can@vger.kernel.org
> Subject: [can:master 110/171]
> drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> 'hwtstamp_config' has incomplete type
> 
> Hi Matthew,
> 
> FYI, kernel build failed on
> 
> tree:   git://gitorious.org/linux-can/linux-can-next master
> head:   a1161bc7bdf4eedccb1b91e7479f303cf95af533
> commit: 3c89f6d0d4aa92ff252c17f8f6b5c8983ae2b77e [110/171] igb: Tidy up
> wrapping for CONFIG_IGB_PTP.
> config: x86_64-allyesdebian (attached as .config)
> 
> All related error/warning messages:
> 
> In file included from
> drivers/net/ethernet/intel/igb/igb_ethtool.c:41:0:
> drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> 'hwtstamp_config' has incomplete type
> --
> In file included from drivers/net/ethernet/intel/igb/e1000_mac.c:36:0:
> drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> 'hwtstamp_config' has incomplete type
> 
> vim +347 drivers/net/ethernet/intel/igb/igb.h
>    341		u8  tx_timeout_factor;
>    342		struct timer_list blink_timer;
>    343		unsigned long led_status;
>    344
>    345		/* OS defined structs */
>    346		struct pci_dev *pdev;
>  > 347		struct hwtstamp_config hwtstamp_config;
>    348
>    349		spinlock_t stats64_lock;
>    350		struct rtnl_link_stats64 stats64;
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology
> Centre
> Fengguang Wu, Yuanhan Liu                              Intel
> Corporation

Fengguang,

I'm not certain I understand how this issue came back to me. The patch in question doesn't touch that code, nor should it be changing anything that would cause a build error here. The offending line is also removed in the next patch (a79f4f88261d7fd492121daf85beafff663f1f01). I'm also unable to reproduce the error.

What would you like me to do with this?

Cheers,
Matthew
