From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Mon, 22 Jun 2020 13:47:52 +0200
Message-ID: <ccd98238-8480-ad05-a9e6-0a0536175753@pengutronix.de>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200618085533.GA26093@mani>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgFVLr4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 07:47:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5EC061794
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 04:47:56 -0700 (PDT)
In-Reply-To: <20200618085533.GA26093@mani>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/18/20 10:55 AM, Manivannan Sadhasivam wrote:
> So how should we proceed from here? It is okay for me to work on adding some
> features and also fixing the issues you've reported so far. But I want to reach
> a consensus before moving forward.
> 
> If you think that it makes sense to go with your set of patches, then I need an
> estimate on when you'll post the first revision.

Done, I've posted my current version, which is -41.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
