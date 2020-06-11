From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Thu, 11 Jun 2020 18:26:19 +0200
Message-ID: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQ0a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jun 2020 12:26:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A090C08C5C1
        for <linux-can@vger.kernel.org>; Thu, 11 Jun 2020 09:26:30 -0700 (PDT)
In-Reply-To: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com
Cc: kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds CAN network driver support for Microchip MCP25XXFD CAN
> Controller with MCP2517FD as the target controller version. This series is
> mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> I've trimmed down the parts which are not necessary for the initial version
> to ease review. Still the series is relatively huge but I hope to get some
> reviews (post -rcX ofc!).
> 
> Link to the origial series posted by Martin:
> https://www.spinics.net/lists/devicetree/msg284462.html
> 
> I've not changed the functionality much but done some considerable amount of
> cleanups and also preserved the authorship of Martin for all the patches he has
> posted earlier. This series has been tested on 96Boards RB3 platform by myself
> and Martin has tested the previous version on Rpi3 with external MCP2517FD
> controller.

I initially started looking at Martin's driver and it was not using several
modern CAN driver infrastructures. I then posted some cleanup patches but Martin
was not working on the driver any more. Then I decided to rewrite the driver,
that is the one I'm hoping to mainline soon.

Can you give it a try?

https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
