Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824FC07E96
	for <linux-can@archiver.kernel.org>; Tue,  6 Jul 2021 10:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0241461879
	for <linux-can@archiver.kernel.org>; Tue,  6 Jul 2021 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGFKNn (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:13:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:30535 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGFKNn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Jul 2021 06:13:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="188769884"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="188769884"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:11:04 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="627635111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:11:03 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m0i2d-009HNu-1e; Tue, 06 Jul 2021 13:10:59 +0300
Date:   Tue, 6 Jul 2021 13:10:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] can: mcp251xfd: mcp251xfd_probe(): try to get
 crystal clock rate from property
Message-ID: <YOQsM4spPVfca4dE@smile.fi.intel.com>
References: <20210531084444.1785397-1-mkl@pengutronix.de>
 <YLS15VESjAVZ2w6G@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLS15VESjAVZ2w6G@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, May 31, 2021 at 01:09:41PM +0300, Andy Shevchenko wrote:
> On Mon, May 31, 2021 at 10:44:43AM +0200, Marc Kleine-Budde wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > In some configurations, mainly ACPI-based, the clock frequency of the
> > device is supplied by very well established 'clock-frequency'
> > property. Hence, try to get it from the property at last if no other
> > providers are available.

Is this series missed merge window?
I never saw it in Linux Next and nor in vanilla...

-- 
With Best Regards,
Andy Shevchenko


