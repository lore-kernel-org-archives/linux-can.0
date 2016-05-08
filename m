From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 4/6] net: can: ifi: Treat CAN_CTRLMODE_FD_NON_ISO
 correctly
Date: Sun, 8 May 2016 20:26:10 +0200
Message-ID: <572F84C2.7040907@hartkopp.net>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
 <1462660456-6179-4-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:60763 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcEHS0Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 14:26:24 -0400
In-Reply-To: <1462660456-6179-4-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>



On 05/08/2016 12:34 AM, Marek Vasut wrote:
> The CAN_CTRLMODE_FD flag is set for both ISO and BOSCH CANFD mode,
> while the CAN_CTRLMODE_FD_NON_ISO is additional flag which is only
> set for CANFD-BOSCH mode. Fix the handling of the flags to reflect
> this.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Makes sense :-)

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>


> Cc: Wolfgang Grandegger <wg@grandegger.com>
> ---
>   drivers/net/can/ifi_canfd/ifi_canfd.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index 30dc3b6..5bd95dd 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -644,10 +644,11 @@ static void ifi_canfd_start(struct net_device *ndev)
>   	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>   		stcmd |= IFI_CANFD_STCMD_LOOPBACK;
>
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
> +	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
>   		stcmd |= IFI_CANFD_STCMD_ENABLE_ISO;
>
> -	if (!(priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO)))
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
>   		stcmd |= IFI_CANFD_STCMD_DISABLE_CANFD;
>
>   	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>
