From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Wed, 26 Feb 2020 08:37:02 +0100
Message-ID: <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZHhJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 02:37:09 -0500
In-Reply-To: <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 2/25/20 11:25 PM, Tim Harvey wrote:
>> On 2/25/20 7:35 PM, Tim Harvey wrote:
>>> Some SPI host controllers such as the Cavium Thunder do not support
>>> full-duplex SPI. Using half-duplex transfers allows the driver to work
>>> with those host controllers.

Hmmm, at least none of the spi-cavium*.c have HALF_DUPLEX set....

I only find these ones:
> drivers/spi/spi-falcon.c:404:   master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-lp8841-rtc.c:194:       master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-mt7621.c:360:   master->flags = SPI_CONTROLLER_HALF_DUPLEX;
> drivers/spi/spi-mxs.c:576:      master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-omap-uwire.c:490:       master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-pic32-sqi.c:651:        master->flags           = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-pl022.c:1714:                           SSP_MICROWIRE_CHANNEL_HALF_DUPLEX)) {
> drivers/spi/spi-qcom-qspi.c:478:        master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-sprd-adi.c:521: ctlr->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-stm32.c:160:#define STM32H7_SPI_HALF_DUPLEX             3
> drivers/spi/spi-stm32.c:1469:           mode = STM32H7_SPI_HALF_DUPLEX;
> drivers/spi/spi-stm32.c:1472:           mode = STM32H7_SPI_HALF_DUPLEX;
> drivers/spi/spi-ti-qspi.c:758:  master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-xcomm.c:222:    master->flags = SPI_MASTER_HALF_DUPLEX;

>> There are several transfers left in the driver, where both rx_buf and
>> tx_buf are set. How does your host controller driver know which one to
>> handle?

I'm trying to answer my question:
I think the spi host controller sets SPI_MASTER_HALF_DUPLEX if it only
supports half duplex and the spi framework checks that only either TX or
RX is set during one transfer.

> Your right... there is the mcp251x_hw_rx_frame() call that also uses
> spi_rx_buf after a synchronous transfer (I didn't see any others).
> I'll look at this again.

Have you hardware to test your changes? I think the SPI framework would
return an -EINVAL in that case....though the return value is sometimes
not checked by the driver :/

> In general is it an ok approach to switch the driver to half-duplex
> for this issue without the need of complicating things with a
> module/dt param?

AFAICS the chip doesn't do real full duplex. It either send or receives
data at the same time. With splitting one pseudo full duplex transfer
into two half duplex transfers brings some minor overhead, but I think
that's hardly measurable.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
