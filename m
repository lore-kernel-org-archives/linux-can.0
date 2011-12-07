From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH 03/14] can: flexcan: only for bus error reporting
 enable berr interrupt
Date: Wed, 07 Dec 2011 16:08:18 +0100
Message-ID: <4EDF8162.6040907@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com> <1323269728-17491-4-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50164 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab1LGPIV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 10:08:21 -0500
In-Reply-To: <1323269728-17491-4-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, socketcan-users@lists.berlios.de, Reuben Dowle <Reuben.Dowle@navico.com>

On 12/07/2011 03:55 PM, Wolfgang Grandegger wrote:
> So far, the bus error (berr) interrupt source is always enabled,
> even if bus error reporting is not requested (via ctrlmode flag
> CAN_CTRLMODE_BERR_REPORTING). This is not necessay, at least on
> the Flexcan of the i.MX28 SOC and it avoids flooding with with
> bus error interrupts. State changes interrupts do still arrive
> as documented. The function flexcan_has_and_handle_berr() has
> been removed and error state changes and bus errors are now
> packed into one error message by a common poll function, like
> for other CAN controllers.
> 
> CC: Reuben Dowle <Reuben.Dowle@navico.com>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

... and here the subject and commit message should be:

[RFC PATCH 01/14] can: flexcan: fix irq flooding by clearing all interrupt sources

As pointed out by Reuben Dowle, the TWRN_INT, RWRN_INT, BOFF_INT
interrupt sources need to be cleared as well to avoid interrupt
flooding, at least for the Flexcan on i.MX28 SOCs.

CC: Reuben Dowle <Reuben.Dowle@navico.com>
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Sorry for the noise.

Wolfgang.


> ---
>  drivers/net/can/flexcan.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0ce914a..095b74b 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -705,7 +705,10 @@ static int flexcan_chip_start(struct net_device *dev)
>  	reg_ctrl = flexcan_read(&regs->ctrl);
>  	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
>  	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
> -		FLEXCAN_CTRL_ERR_STATE | FLEXCAN_CTRL_ERR_MSK;
> +		FLEXCAN_CTRL_ERR_STATE;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
>  
>  	/* save for later use */
>  	priv->reg_ctrl_default = reg_ctrl;

