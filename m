From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 5/9] can: janz-ican3: cleanup of ican3_to_can_frame and
 can_frame_to_ican3
Date: Fri, 20 Jul 2012 08:39:34 -0700
Message-ID: <20120720153933.GA18481@ovro.caltech.edu>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
 <1342782709-4868-6-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:60315 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab2GTPjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 11:39:37 -0400
Content-Disposition: inline
In-Reply-To: <1342782709-4868-6-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Fri, Jul 20, 2012 at 01:11:45PM +0200, Marc Kleine-Budde wrote:
> This patch cleans up the ICAN3 to Linux CAN frame and vice versa
> conversion functions:
> 
> - RX: Use get_can_dlc() to limit the dlc value.
> - RX+TX: Don't copy the whole frame, only copy the amount of bytes
>   specified in cf->can_dlc.
> 
> Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

It looks good to me, and works perfectly.

Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>
Tested-by: Ira W. Snyder <iws@ovro.caltech.edu>

>  drivers/net/can/janz-ican3.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index 754b803..b19aca5 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -811,10 +811,10 @@ static void ican3_to_can_frame(struct ican3_dev *mod,
>  
>  		cf->can_id |= desc->data[0] << 3;
>  		cf->can_id |= (desc->data[1] & 0xe0) >> 5;
> -		cf->can_dlc = desc->data[1] & ICAN3_CAN_DLC_MASK;
> -		memcpy(cf->data, &desc->data[2], sizeof(cf->data));
> +		cf->can_dlc = get_can_dlc(desc->data[1] & ICAN3_CAN_DLC_MASK);
> +		memcpy(cf->data, &desc->data[2], cf->can_dlc);
>  	} else {
> -		cf->can_dlc = desc->data[0] & ICAN3_CAN_DLC_MASK;
> +		cf->can_dlc = get_can_dlc(desc->data[0] & ICAN3_CAN_DLC_MASK);
>  		if (desc->data[0] & ICAN3_EFF_RTR)
>  			cf->can_id |= CAN_RTR_FLAG;
>  
> @@ -829,7 +829,7 @@ static void ican3_to_can_frame(struct ican3_dev *mod,
>  			cf->can_id |= desc->data[3] >> 5;  /* 2-0   */
>  		}
>  
> -		memcpy(cf->data, &desc->data[6], sizeof(cf->data));
> +		memcpy(cf->data, &desc->data[6], cf->can_dlc);
>  	}
>  }
>  
> @@ -861,7 +861,7 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
>  	}
>  
>  	/* copy the data bits into the descriptor */
> -	memcpy(&desc->data[6], cf->data, sizeof(cf->data));
> +	memcpy(&desc->data[6], cf->data, cf->can_dlc);
>  }
>  
>  /*
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
