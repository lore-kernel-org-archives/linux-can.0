From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH V4 1/4] net: can: ifi: Fix clock generator configuration
Date: Thu, 3 Mar 2016 21:18:39 +0100
Message-ID: <56D89C1F.9060504@hartkopp.net>
References: <1457034358-5515-1-git-send-email-marex@denx.de>
 <1457034358-5515-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:56872 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcCCUSu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Mar 2016 15:18:50 -0500
In-Reply-To: <1457034358-5515-2-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>

Hi Marek,

On 03/03/2016 08:45 PM, Marek Vasut wrote:

> @@ -545,32 +545,34 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
>  	u32 noniso_arg = 0;
>  	u32 time_off;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) {
> +	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
> +	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)) {
> +		time_off = IFI_CANFD_TIME_SJW_OFF_ISO;
> +	} else {
>  		noniso_arg = IFI_CANFD_TIME_SET_TIMEB_BOSCH |
>  			     IFI_CANFD_TIME_SET_TIMEA_BOSCH |
>  			     IFI_CANFD_TIME_SET_PRESC_BOSCH |
>  			     IFI_CANFD_TIME_SET_SJW_BOSCH;
>  		time_off = IFI_CANFD_TIME_SJW_OFF_BOSCH;
> -	} else {
> -		time_off = IFI_CANFD_TIME_SJW_OFF_ISO;
>  	}
>  

This may set time_off to IFI_CANFD_TIME_SJW_OFF_BOSCH in the case of

	!(priv->can.ctrlmode & CAN_CTRLMODE_FD)

(== CAN2.0) right?

I assume this is not intended.

I would suggest to initialize time_off first:

	u32 noniso_arg = 0;
	u32 time_off = IFI_CANFD_TIME_SJW_OFF_ISO;

	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
	    (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)) {
		noniso_arg = IFI_CANFD_TIME_SET_TIMEB_BOSCH |
			     IFI_CANFD_TIME_SET_TIMEA_BOSCH |
			     IFI_CANFD_TIME_SET_PRESC_BOSCH |
			     IFI_CANFD_TIME_SET_SJW_BOSCH;
		time_off = IFI_CANFD_TIME_SJW_OFF_BOSCH;
	}

Is my assumption correct? Or does the manual require other settings?

Regards,
Oliver
