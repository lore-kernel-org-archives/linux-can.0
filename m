From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Date: Fri, 8 Feb 2019 21:55:26 +0300
Message-ID: <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
References: <20190208184444.GA28484@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208184444.GA28484@embeddedor>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello!

On 02/08/2019 09:44 PM, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Notice that, in this particular case, the /* fall through */
> comments are placed at the bottom of the case statement, which
> is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/can/at91_can.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c69045b17..1718c20f9c99 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  				CAN_ERR_CRTL_TX_WARNING :
>  				CAN_ERR_CRTL_RX_WARNING;
>  		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */

   Why do we need this comment at all? Just remove it, that's all.

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

   Again, we don;t need it here.

> +	case CAN_STATE_ERROR_WARNING:
>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>  		reg_ier = AT91_IRQ_ERRP;
>  		break;

MBR, Serfei
