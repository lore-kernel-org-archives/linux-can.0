From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Thu, 18 Jun 2020 17:36:15 +0530
Message-ID: <20200618120615.GA3949@mani>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFRMGY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jun 2020 08:06:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893DC06174E
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2020 05:06:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so2819204pgn.7
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2020 05:06:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 0611, Marc Kleine-Budde wrote:
> On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds CAN network driver support for Microchip MCP25XXFD CAN
> > Controller with MCP2517FD as the target controller version. This series is
> > mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> > I've trimmed down the parts which are not necessary for the initial version
> > to ease review. Still the series is relatively huge but I hope to get some
> > reviews (post -rcX ofc!).
> > 
> > Link to the origial series posted by Martin:
> > https://www.spinics.net/lists/devicetree/msg284462.html
> > 
> > I've not changed the functionality much but done some considerable amount of
> > cleanups and also preserved the authorship of Martin for all the patches he has
> > posted earlier. This series has been tested on 96Boards RB3 platform by myself
> > and Martin has tested the previous version on Rpi3 with external MCP2517FD
> > controller.
> 
> I initially started looking at Martin's driver and it was not using several
> modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> was not working on the driver any more. Then I decided to rewrite the driver,
> that is the one I'm hoping to mainline soon.
> 
> Can you give it a try?
> 
> https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41
> 

Tested this version on my board with MCP2518FD and it works fine. I'm okay with
moving forward with your version and would like to contribute. Please let me
know how we can move forward.

Thanks,
Mani

> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
