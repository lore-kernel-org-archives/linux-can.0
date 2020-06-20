From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Sat, 20 Jun 2020 08:13:51 +0530
Message-ID: <20200620024351.GA18455@Mani-XPS-13-9360>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200618085533.GA26093@mani>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgFTCoB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jun 2020 22:44:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841BC06174E
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so4757347plo.12
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200618085533.GA26093@mani>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:25:33PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On 0611, Marc Kleine-Budde wrote:
> > On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series adds CAN network driver support for Microchip MCP25XXFD CAN
> > > Controller with MCP2517FD as the target controller version. This series is
> > > mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> > > I've trimmed down the parts which are not necessary for the initial version
> > > to ease review. Still the series is relatively huge but I hope to get some
> > > reviews (post -rcX ofc!).
> > > 
> > > Link to the origial series posted by Martin:
> > > https://www.spinics.net/lists/devicetree/msg284462.html
> > > 
> > > I've not changed the functionality much but done some considerable amount of
> > > cleanups and also preserved the authorship of Martin for all the patches he has
> > > posted earlier. This series has been tested on 96Boards RB3 platform by myself
> > > and Martin has tested the previous version on Rpi3 with external MCP2517FD
> > > controller.
> > 
> > I initially started looking at Martin's driver and it was not using several
> > modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> > was not working on the driver any more. Then I decided to rewrite the driver,
> > that is the one I'm hoping to mainline soon.
> > 
> 
> So how should we proceed from here? It is okay for me to work on adding some
> features and also fixing the issues you've reported so far. But I want to reach
> a consensus before moving forward.
> 
> If you think that it makes sense to go with your set of patches, then I need an
> estimate on when you'll post the first revision.
> 

Ping!

> > Can you give it a try?
> > 
> > https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41
> > 
> 
> Sure thing. Will do.
> 
> Thanks,
> Mani
> 
> > Marc
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
