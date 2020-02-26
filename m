From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Wed, 26 Feb 2020 11:19:26 +0100
Message-ID: <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46249 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKTe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 05:19:34 -0500
In-Reply-To: <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 2/26/20 8:37 AM, Marc Kleine-Budde wrote:
>> Your right... there is the mcp251x_hw_rx_frame() call that also uses
>> spi_rx_buf after a synchronous transfer (I didn't see any others).
>> I'll look at this again.
> 
> Have you hardware to test your changes? I think the SPI framework would
> return an -EINVAL in that case....though the return value is sometimes
> not checked by the driver :/

See https://elixir.bootlin.com/linux/v5.5.6/source/drivers/spi/spi.c#L3413

If you have really have HW with SPI_CONTROLLER_HALF_DUPLEX (a.k.a
SPI_MASTER_HALF_DUPLEX) restrictions, you need to convert _every_
mcp251x_spi_trans() call in the driver, as _always_ both rx_buf _and_
tx_buf are used.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
