From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCHv2] can: at91_can: prepare and unprepare the clock
Date: Wed, 17 Sep 2014 20:34:44 +0200
Message-ID: <20140917203444.126dadcd@bbrezillon>
References: <1410956808-1964-1-git-send-email-davidcdueck@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55427 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755970AbaIQSfM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Sep 2014 14:35:12 -0400
In-Reply-To: <1410956808-1964-1-git-send-email-davidcdueck@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Dueck <davidcdueck@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, mkl@pengutronix.de, Anthony Harivel <anthony.harivel@emtrion.de>, wg@grandegger.com, linux-can@vger.kernel.org

On Wed, 17 Sep 2014 14:26:48 +0200
David Dueck <davidcdueck@googlemail.com> wrote:

> Make the driver work with the common clock framework.
> 
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> Changes since v1:
> - improve commit message
> - check return value of clk_prepare_enable
> 
>  drivers/net/can/at91_can.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index f07fa89..05e1aa0 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1123,7 +1123,9 @@ static int at91_open(struct net_device *dev)
>  	struct at91_priv *priv = netdev_priv(dev);
>  	int err;
>  
> -	clk_enable(priv->clk);
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		return err;
>  
>  	/* check or determine and set bittime */
>  	err = open_candev(dev);
> @@ -1149,7 +1151,7 @@ static int at91_open(struct net_device *dev)
>   out_close:
>  	close_candev(dev);
>   out:
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  
>  	return err;
>  }
> @@ -1166,7 +1168,7 @@ static int at91_close(struct net_device *dev)
>  	at91_chip_stop(dev, CAN_STATE_STOPPED);
>  
>  	free_irq(dev->irq, dev);
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  
>  	close_candev(dev);
>  



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
