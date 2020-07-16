From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Date: Thu, 16 Jul 2020 18:58:00 +0530
Message-ID: <20200716132800.GH3271@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
 <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPN2F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 09:28:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155DC061755
        for <linux-can@vger.kernel.org>; Thu, 16 Jul 2020 06:28:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so4849675pgc.8
        for <linux-can@vger.kernel.org>; Thu, 16 Jul 2020 06:28:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On Fri, Jun 26, 2020 at 04:41:53PM +0200, Marc Kleine-Budde wrote:
> On 6/26/20 3:32 PM, Manivannan Sadhasivam wrote:
> > On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
> >> This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
> >>
> >> Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> >> Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > Could you please split this patch into multiple ones? Having ~4k lines for a
> > patch makes it difficult to review. I know that some parts are difficult to
> > split (happened with my series as well) but anything below 1k should be fine.
> 
> For now I split the regmap and crc16 into one patch, the core file into a
> separate patch.
> 
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-45
> 
> If you want to have it in smaller pieces I'll need more time to figure out a
> sensible way to split the driver.
> 

Can you please post the split version here so that I can do a formal review?

Thanks,
Mani

> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
