From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change
 handling.
Date: Sun, 30 Nov 2014 21:23:57 +0100
Message-ID: <547B7CDD.2080202@grandegger.com>
References: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38845 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaK3UYA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 30 Nov 2014 15:24:00 -0500
In-Reply-To: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 11/28/2014 01:12 PM, Andri Yngvason wrote:
> Replacing error state change handling with the new mechanism.
> 
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
> Changes made since last proposal:
> can: flexcan: add FLEXCAN_HAS_BROKEN_ERR_STATE for i.MX6
> can: flexcan: adapt to newer can_change_state
> 
>  drivers/net/can/flexcan.c | 103 +++++++++-------------------------------------
>  1 file changed, 19 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 60f86bd..9f91735 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -266,7 +266,7 @@ static struct flexcan_devtype_data fsl_p1010_devtype_data = {
>  };
>  static struct flexcan_devtype_data fsl_imx28_devtype_data;
>  static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
> -	.features = FLEXCAN_HAS_V10_FEATURES,
> +	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_BROKEN_ERR_STATE,

Oops, this change is not related to the subject! Anyway, did it cure
your problems with state handling. Is it required for all i.MX6 cores then?

>  };
>  static struct flexcan_devtype_data fsl_vf610_devtype_data = {
>  	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
> @@ -577,98 +577,30 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
>  	return 1;
>  }
>  
> -static void do_state(struct net_device *dev,
> -		     struct can_frame *cf, enum can_state new_state)
> -{
> -	struct flexcan_priv *priv = netdev_priv(dev);
> -	struct can_berr_counter bec;
> -
> -	__flexcan_get_berr_counter(dev, &bec);
> -
> -	switch (priv->can.state) {
> -	case CAN_STATE_ERROR_ACTIVE:
> -		/*
> -		 * from: ERROR_ACTIVE
> -		 * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
> -		 * =>  : there was a warning int
> -		 */
> -		if (new_state >= CAN_STATE_ERROR_WARNING &&
> -		    new_state <= CAN_STATE_BUS_OFF) {
> -			netdev_dbg(dev, "Error Warning IRQ\n");
> -			priv->can.can_stats.error_warning++;
> -
> -			cf->can_id |= CAN_ERR_CRTL;
> -			cf->data[1] = (bec.txerr > bec.rxerr) ?
> -				CAN_ERR_CRTL_TX_WARNING :
> -				CAN_ERR_CRTL_RX_WARNING;
> -		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> -		/*
> -		 * from: ERROR_ACTIVE, ERROR_WARNING
> -		 * to  : ERROR_PASSIVE, BUS_OFF
> -		 * =>  : error passive int
> -		 */
> -		if (new_state >= CAN_STATE_ERROR_PASSIVE &&
> -		    new_state <= CAN_STATE_BUS_OFF) {
> -			netdev_dbg(dev, "Error Passive IRQ\n");

Maybe it's a good idea to have netdev_dbg's for state changes in
can_change_state() as well. Other opinions? Marc?

Apart from these to comments the patches 1-5 look good (but you should
drop the 6th).

Wolfgang.
