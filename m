From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6] can: move can_stats.bus_off++ from can_bus_off into
 can_change_state
Date: Fri, 12 Dec 2014 14:00:41 +0100
Message-ID: <548AE6F9.8020306@grandegger.com>
References: <b032a1c3-b80d-41a4-998b-4fe0e5a8118b@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41968 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967589AbaLLNAo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Dec 2014 08:00:44 -0500
In-Reply-To: <b032a1c3-b80d-41a4-998b-4fe0e5a8118b@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 12/11/2014 03:15 PM, Andri Yngvason wrote:
> In order to be able to move the stats increment from can_bus_off() into
> can_change_state(), the increment had to be moved back into code that was using
> can_bus_off() but not can_change_state().
> 
> As a side-effect, this patch fixes the following bugs:
>  * Redundant call to can_bus_off() in c_can.
>  * Bus-off counted twice in xilinx_can.
> 
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/bfin_can.c                  | 1 +
>  drivers/net/can/c_can/c_can.c               | 2 +-
>  drivers/net/can/cc770/cc770.c               | 1 +
>  drivers/net/can/dev.c                       | 3 ++-
>  drivers/net/can/janz-ican3.c                | 1 +
>  drivers/net/can/m_can/m_can.c               | 1 +
>  drivers/net/can/pch_can.c                   | 1 +
>  drivers/net/can/rcar_can.c                  | 1 +
>  drivers/net/can/softing/softing_main.c      | 1 +
>  drivers/net/can/spi/mcp251x.c               | 1 +
>  drivers/net/can/ti_hecc.c                   | 1 +
>  drivers/net/can/usb/ems_usb.c               | 1 +
>  drivers/net/can/usb/esd_usb2.c              | 1 +
>  drivers/net/can/usb/peak_usb/pcan_usb.c     | 1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 1 +
>  drivers/net/can/usb/usb_8dev.c              | 1 +
>  16 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
> index 543ecce..7c89430 100644
> --- a/drivers/net/can/bfin_can.c
> +++ b/drivers/net/can/bfin_can.c
> @@ -352,6 +352,7 @@ static int bfin_can_err(struct net_device *dev, u16 isrc, u16 status)
>  		netdev_dbg(dev, "bus-off mode interrupt\n");
>  		state = CAN_STATE_BUS_OFF;
>  		cf->can_id |= CAN_ERR_BUSOFF;
> +		stats->bus_off++;
>  		can_bus_off(dev);
>  	}
>  
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index f94a9fa..70f77e9 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -866,7 +866,7 @@ static int c_can_handle_state_change(struct net_device *dev,
>  	case C_CAN_BUS_OFF:
>  		/* bus-off state */
>  		priv->can.state = CAN_STATE_BUS_OFF;
> -		can_bus_off(dev);
> +		priv->can.can_stats.bus_off++;
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index d837927..eea37cd 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -535,6 +535,7 @@ static int cc770_err(struct net_device *dev, u8 status)
>  		cc770_write_reg(priv, control, CTRL_INI);
>  		cf->can_id |= CAN_ERR_BUSOFF;
>  		priv->can.state = CAN_STATE_BUS_OFF;
> +		priv->can.can_stats.bus_off++;
>  		can_bus_off(dev);
>  	} else if (status & STAT_WARN) {
>  		cf->can_id |= CAN_ERR_CRTL;
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index b4ecb10..f652795 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -289,6 +289,8 @@ static void can_update_state_error_stats(struct net_device *dev,
>  		priv->can_stats.error_passive++;
>  		break;
>  	case CAN_STATE_BUS_OFF:
> +		priv->can_stats.bus_off++;
> +		break;
>  	default:
>  		break;
>  	};
> @@ -544,7 +546,6 @@ void can_bus_off(struct net_device *dev)
>  	netdev_dbg(dev, "bus-off\n");
>  
>  	netif_carrier_off(dev);
> -	priv->can_stats.bus_off++;
>  
>  	if (priv->restart_ms)
>  		mod_timer(&priv->restart_timer,
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index 2382c04..c68b9c0 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -1008,6 +1008,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
>  		if (status & SR_BS) {
>  			state = CAN_STATE_BUS_OFF;
>  			cf->can_id |= CAN_ERR_BUSOFF;
> +			mod->can.can_stats.bus_off++;
>  			can_bus_off(dev);
>  		} else if (status & SR_ES) {
>  			if (rxerr >= 128 || txerr >= 128)
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 10d571e..7202885 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -533,6 +533,7 @@ static int m_can_handle_state_change(struct net_device *dev,
>  		/* bus-off state */
>  		priv->can.state = CAN_STATE_BUS_OFF;
>  		m_can_disable_all_interrupts(priv);
> +		priv->can.can_stats.bus_off++;
>  		can_bus_off(dev);
>  		break;
>  	default:
> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index a67eb01..e187ca7 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
> @@ -505,6 +505,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
>  		pch_can_set_rx_all(priv, 0);
>  		state = CAN_STATE_BUS_OFF;
>  		cf->can_id |= CAN_ERR_BUSOFF;
> +		priv->can.can_stats.bus_off++;
>  		can_bus_off(ndev);
>  	}
>  
> diff --git a/drivers/net/can/rcar_can.c b/drivers/net/can/rcar_can.c
> index 1abe133..b88fc66 100644
> --- a/drivers/net/can/rcar_can.c
> +++ b/drivers/net/can/rcar_can.c
> @@ -331,6 +331,7 @@ static void rcar_can_error(struct net_device *ndev)
>  		priv->can.state = CAN_STATE_BUS_OFF;
>  		/* Clear interrupt condition */
>  		writeb(~RCAR_CAN_EIFR_BOEIF, &priv->regs->eifr);
> +		priv->can.can_stats.bus_off++;
>  		can_bus_off(ndev);
>  		if (skb)
>  			cf->can_id |= CAN_ERR_BUSOFF;
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
> index bacd236..566806a 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -261,6 +261,7 @@ static int softing_handle_1(struct softing *card)
>  				++priv->can.can_stats.error_passive;
>  			else if (can_state == CAN_STATE_BUS_OFF) {
>  				/* this calls can_close_cleanup() */
> +				++priv->can.can_stats.bus_off;
>  				can_bus_off(netdev);
>  				netif_stop_queue(netdev);
>  			}
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index c66d699..bf63fee 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -905,6 +905,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
>  		if (priv->can.state == CAN_STATE_BUS_OFF) {
>  			if (priv->can.restart_ms == 0) {
>  				priv->force_quit = 1;
> +				priv->can.can_stats.bus_off++;
>  				can_bus_off(net);
>  				mcp251x_hw_sleep(spi);
>  				break;
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index 258b9c4..6c775fa 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -715,6 +715,7 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
>  		hecc_clear_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
>  		/* Disable all interrupts in bus-off to avoid int hog */
>  		hecc_write(priv, HECC_CANGIM, 0);
> +		++priv->can.can_stats.bus_off;
>  		can_bus_off(ndev);
>  	}
>  
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 00f2534..539df07 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -347,6 +347,7 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
>  			dev->can.state = CAN_STATE_BUS_OFF;
>  			cf->can_id |= CAN_ERR_BUSOFF;
>  
> +			dev->can.can_stats.bus_off++;
>  			can_bus_off(dev->netdev);
>  		} else if (state & SJA1000_SR_ES) {
>  			dev->can.state = CAN_STATE_ERROR_WARNING;
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
> index b7c9e8b..29f40b2 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -250,6 +250,7 @@ static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
>  			case ESD_BUSSTATE_BUSOFF:
>  				priv->can.state = CAN_STATE_BUS_OFF;
>  				cf->can_id |= CAN_ERR_BUSOFF;
> +				priv->can.can_stats.bus_off++;
>  				can_bus_off(priv->netdev);
>  				break;
>  			case ESD_BUSSTATE_WARN:
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 925ab8e..13c737a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -488,6 +488,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
>  	switch (new_state) {
>  	case CAN_STATE_BUS_OFF:
>  		cf->can_id |= CAN_ERR_BUSOFF;
> +		mc->pdev->dev.can.can_stats.bus_off++;
>  		can_bus_off(mc->netdev);
>  		break;
>  
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index 263dd92..9a3564d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -635,6 +635,7 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
>  	switch (new_state) {
>  	case CAN_STATE_BUS_OFF:
>  		can_frame->can_id |= CAN_ERR_BUSOFF;
> +		dev->can.can_stats.bus_off++;
>  		can_bus_off(netdev);
>  		break;
>  
> diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
> index ef674ec..dd52c7a 100644
> --- a/drivers/net/can/usb/usb_8dev.c
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -377,6 +377,7 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
>  	case USB_8DEV_STATUSMSG_BUSOFF:
>  		priv->can.state = CAN_STATE_BUS_OFF;
>  		cf->can_id |= CAN_ERR_BUSOFF;
> +		priv->can.can_stats.bus_off++;
>  		can_bus_off(priv->netdev);
>  		break;
>  	case USB_8DEV_STATUSMSG_OVERRUN:
> 

Looks good now!

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Wolfgang.
