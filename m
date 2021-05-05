Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABEC433ED
	for <linux-can@archiver.kernel.org>; Wed,  5 May 2021 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B887B61222
	for <linux-can@archiver.kernel.org>; Wed,  5 May 2021 10:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhEEKOp (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 5 May 2021 06:14:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:62356 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhEEKOm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 5 May 2021 06:14:42 -0400
IronPort-SDR: ggwPz1PsP0h76l4orL1eWKGlUtDZ55fX9/dLh0oAkfM765QySENYivMAP6JnQOghrJq6UDfILW
 Ga6lGK4tIcrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="195051102"
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="195051102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 03:13:46 -0700
IronPort-SDR: pYKsr1hnKbkzRe6aFkCqPBhdoyOje4JHGiQ1MredtAr00vMgLaIupCFkwATjQqXH+vFTQgUvLz
 WrhLB+SLWEXg==
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="433742342"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 03:13:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1leEXF-009jyS-T8; Wed, 05 May 2021 13:13:41 +0300
Date:   Wed, 5 May 2021 13:13:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [can-nextc 1/2] can: mcp251x: mcp251x_can_probe(): silence clang
 warning
Message-ID: <YJJv1f95WfTeJXCZ@smile.fi.intel.com>
References: <20210504200520.1179635-1-mkl@pengutronix.de>
 <20210504200520.1179635-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504200520.1179635-2-mkl@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, May 04, 2021 at 10:05:19PM +0200, Marc Kleine-Budde wrote:
> This patch silences the following clang warning:
> 
> | drivers/net/can/spi/mcp251x.c:1333:17: warning: cast to smaller integer type
> | 'enum mcp251x_model' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |                 priv->model = (enum mcp251x_model)match;
> |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 8de29a5c34a5 ("can: mcp251x: Make use of device property API")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/spi/mcp251x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 492f1bcb0516..275b2ddab143 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1343,7 +1343,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
>  		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
>  	if (match)
> -		priv->model = (enum mcp251x_model)match;
> +		priv->model = (enum mcp251x_model)(kernel_ulong_t)match;

Usually we use uintptr_t, but either way
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

>  	else
>  		priv->model = spi_get_device_id(spi)->driver_data;
>  	priv->net = net;
> 
> base-commit: 9d31d2338950293ec19d9b095fbaa9030899dcb4
> prerequisite-patch-id: 2d99a92f9c04a76341ba84b5f4924c2ba03bdd88
> prerequisite-patch-id: 6dbb40c8b889604bf57aa2374f34290b247b7d28
> prerequisite-patch-id: 24ff9c746552e4a8e100200f13bb1732990392a3
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


