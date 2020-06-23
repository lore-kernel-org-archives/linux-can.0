From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 0/3] can: add mcp25xxfd support
Date: Tue, 23 Jun 2020 18:16:49 +0530
Message-ID: <20200623124649.GC13669@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWMq4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 08:46:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1EC061573
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 05:46:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so4583117pgc.5
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 05:46:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200622114603.965371-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On Mon, Jun 22, 2020 at 01:46:00PM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> this series adds support for the Microchip MCP25xxFD SPI CAN controller family.
> 
> The series is available at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-41
> 

Tested this series on an SM8250 based board connected to MCP2518FD over SPI.
Hence,

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> regards,
> Marc
> 
> 
