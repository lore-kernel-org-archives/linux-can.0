From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 6/6] can: handle bus-off in =?UTF-8?Q?can=5Fchange?=  =?UTF-8?Q?=5Fstate=28=29?=
Date: Fri, 28 Nov 2014 13:21:53 +0100
Message-ID: <9cb398d87d94313de88eb421f75735b1@grandegger.com>
References: <d9f1108f-a284-4b48-9bd0-2a5906c954f3@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:36744 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaK1MV4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Nov 2014 07:21:56 -0500
In-Reply-To: <d9f1108f-a284-4b48-9bd0-2a5906c954f3@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On Fri, 28 Nov 2014 12:12:28 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/dev.c             |  1 +
>  drivers/net/can/flexcan.c         |  3 ---
>  drivers/net/can/mscan/mscan.c     | 11 +++++------
>  drivers/net/can/sja1000/sja1000.c |  3 ---
>  4 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 3e2da66..17fce72 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -340,6 +340,7 @@ void can_change_state(struct net_device *dev, struct
> can_frame *cf,
>  
>  	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
>  		cf->can_id |= CAN_ERR_BUSOFF;
> +		can_bus_off(dev);
>  		return;
>  	}
>  
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 9f91735..0823956 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -612,9 +612,6 @@ static int flexcan_poll_state(struct net_device
*dev,
> u32 reg_esr)
>  
>  	can_change_state(dev, cf, tx_state, rx_state);
>  
> -	if (unlikely(new_state == CAN_STATE_BUS_OFF))
> -		can_bus_off(dev);
> -
>  	netif_receive_skb(skb);
>  
>  	dev->stats.rx_packets++;
> diff --git a/drivers/net/can/mscan/mscan.c
b/drivers/net/can/mscan/mscan.c
> index e36b740..2eb84f1 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -362,11 +362,7 @@ static void mscan_get_err_frame(struct net_device
> *dev, struct can_frame *frame,
>  
>  	new_state = get_new_state(dev, canrflg);
>  	if (new_state != priv->can.state) {
> -		can_change_state(dev, frame,
> -				 state_map[MSCAN_STATE_TX(canrflg)],
> -				 state_map[MSCAN_STATE_RX(canrflg)]);
> -
> -		if (priv->can.state == CAN_STATE_BUS_OFF) {
> +		if (new_state == CAN_STATE_BUS_OFF) {
>  			/*
>  			 * The MSCAN on the MPC5200 does recover from bus-off
>  			 * automatically. To avoid that we stop the chip doing
> @@ -378,8 +374,11 @@ static void mscan_get_err_frame(struct net_device
> *dev, struct can_frame *frame,
>  				setbits8(&regs->canctl0,
>  					 MSCAN_SLPRQ | MSCAN_INITRQ);
>  			}
> -			can_bus_off(dev);
>  		}
> +
> +		can_change_state(dev, frame,
> +				 state_map[MSCAN_STATE_TX(canrflg)],
> +				 state_map[MSCAN_STATE_RX(canrflg)]);
>  	}
>  	priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
>  	frame->can_dlc = CAN_ERR_DLC;
> diff --git a/drivers/net/can/sja1000/sja1000.c
> b/drivers/net/can/sja1000/sja1000.c
> index 32bd7f4..37b6392 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -479,9 +479,6 @@ static int sja1000_err(struct net_device *dev,
uint8_t
> isrc, uint8_t status)
>  		rx_state = txerr <= rxerr ? state : 0;
>  
>  		can_change_state(dev, cf, tx_state, rx_state);
> -
> -		if(state == CAN_STATE_BUS_OFF)
> -			can_bus_off(dev);

Ah, no, that's wrong because not all devices use this function. I thought
just moving the counter incrementation out of can_bus_off() back to
the driver (for all drivers not yet using can_change_state). Sorry for
confusion.

Wolfgang.
