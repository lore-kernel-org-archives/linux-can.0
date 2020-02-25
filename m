From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Tue, 25 Feb 2020 22:43:07 +0100
Message-ID: <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgBYVnO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 16:43:14 -0500
In-Reply-To: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>
Cc: =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 2/25/20 7:35 PM, Tim Harvey wrote:
> Some SPI host controllers such as the Cavium Thunder do not support
> full-duplex SPI. Using half-duplex transfers allows the driver to work
> with those host controllers.

There are several transfers left in the driver, where both rx_buf and
tx_buf are set. How does your host controller driver know which one to
handle?

Marc

> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/net/can/spi/mcp251x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 5009ff2..840c31c 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -290,23 +290,23 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
>  	priv->spi_tx_buf[0] = INSTRUCTION_READ;
>  	priv->spi_tx_buf[1] = reg;
>  
> -	mcp251x_spi_trans(spi, 3);
> -	val = priv->spi_rx_buf[2];
> +	spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
>  
>  	return val;
>  }
>  
>  static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
>  {
> +	u8 val[4] = {0};
>  	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>  
>  	priv->spi_tx_buf[0] = INSTRUCTION_READ;
>  	priv->spi_tx_buf[1] = reg;
>  
> -	mcp251x_spi_trans(spi, 4);
> +	spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
>  
> -	*v1 = priv->spi_rx_buf[2];
> -	*v2 = priv->spi_rx_buf[3];
> +	*v1 = val[0];
> +	*v2 = val[1];
>  }
>  
>  static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
> 

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
