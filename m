From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] can: mcp251x: Move diagnostic messages to dev_dbg()
Date: Sun, 23 Feb 2014 20:13:47 +0100
Message-ID: <530A486B.3040005@grandegger.com>
References: <1393048274-7949-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50211 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaBWTXJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 23 Feb 2014 14:23:09 -0500
In-Reply-To: <1393048274-7949-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>

On 02/22/2014 06:51 AM, Alexander Shiyan wrote:
> This patch moves diagnostic messages used for debugging purposes
> to dev_dbg().
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/net/can/mcp251x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index cdb9808..56e38a6 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -601,10 +601,10 @@ static int mcp251x_do_set_bittiming(struct net_device *net)
>  			  (bt->prop_seg - 1));
>  	mcp251x_write_bits(spi, CNF3, CNF3_PHSEG2_MASK,
>  			   (bt->phase_seg2 - 1));
> -	dev_info(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
> -		 mcp251x_read_reg(spi, CNF1),
> -		 mcp251x_read_reg(spi, CNF2),
> -		 mcp251x_read_reg(spi, CNF3));
> +	dev_dbg(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
> +		mcp251x_read_reg(spi, CNF1),
> +		mcp251x_read_reg(spi, CNF2),
> +		mcp251x_read_reg(spi, CNF3));
>  
>  	return 0;
>  }

It's common practice to show the bit-timing settings in the kernel log.
Therefore I prefer to keep this useful dev_info. If we change it, we
should update all other drivers as well.

> @@ -1155,7 +1155,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
>  

>  	devm_can_led_init(net);
>  
> -	dev_info(&spi->dev, "probed\n");
> +	dev_dbg(&spi->dev, "probed\n");

This one could even be removed.

Wolfgang.

