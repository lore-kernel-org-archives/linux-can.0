From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] can: at91_can: fix fall-through annotations
Date: Tue, 4 Sep 2018 17:29:33 +0200
Message-ID: <20180904152933.GJ13888@piout.net>
References: <20180903183618.GA6905@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180903183618.GA6905@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 03/09/2018 13:36:18-0500, Gustavo A. R. Silva wrote:
> Properly place the "fall through" annotations at the bottom of the case,
> which is what GCC is expecting to find.
> 
> This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough
> 
> Addresses-Coverity-ID: 1222851 ("Missing break in switch")
> Addresses-Coverity-ID: 402011 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Seems good to me (but I preferred the previous annotation ;))

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/can/at91_can.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c690..1718c20 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  				CAN_ERR_CRTL_TX_WARNING :
>  				CAN_ERR_CRTL_RX_WARNING;
>  		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>  		/*
>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>  		 * to  : ERROR_PASSIVE, BUS_OFF
> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  		netdev_dbg(dev, "Error Active\n");
>  		cf->can_id |= CAN_ERR_PROT;
>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>  		reg_ier = AT91_IRQ_ERRP;
>  		break;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
