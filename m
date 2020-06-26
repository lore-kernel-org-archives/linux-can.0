From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Date: Fri, 26 Jun 2020 16:41:53 +0200
Message-ID: <fdb6e441-fed5-435e-553c-1fc0a6bfb8f7@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOl7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Jun 2020 10:41:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43853C03E979
        for <linux-can@vger.kernel.org>; Fri, 26 Jun 2020 07:41:59 -0700 (PDT)
In-Reply-To: <20200626133243.GA8333@Mani-XPS-13-9360>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On 6/26/20 3:32 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
>> This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
>>
>> Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Could you please split this patch into multiple ones? Having ~4k lines for a
> patch makes it difficult to review. I know that some parts are difficult to
> split (happened with my series as well) but anything below 1k should be fine.

For now I split the regmap and crc16 into one patch, the core file into a
separate patch.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-45

If you want to have it in smaller pieces I'll need more time to figure out a
sensible way to split the driver.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
