From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4 7/7] can: add bittiming check at interface open for
 CAN FD
Date: Sat, 22 Feb 2014 19:25:21 +0100
Message-ID: <5308EB91.1010409@hartkopp.net>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net> <1393009025-4903-8-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:64245 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaBVSZX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Feb 2014 13:25:23 -0500
Received: from [192.168.178.40] (p5B0B1610.dip0.t-ipconnect.de [91.11.22.16])
	by smtp.strato.de (RZmta 32.27 DYNA|AUTH)
	with ESMTPSA id U044ffq1MIPLQxl
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Sat, 22 Feb 2014 19:25:21 +0100 (CET)
In-Reply-To: <1393009025-4903-8-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org



On 21.02.2014 19:57, Oliver Hartkopp wrote:
> Additionally to have the second (data) bitrate available the data bitrate
> has to be greater or equal to the arbitration bitrate in CAN FD.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index d9f7281..9c3fb51 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -652,6 +652,14 @@ int open_candev(struct net_device *dev)
>  		return -EINVAL;
>  	}
>  
> +	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
> +	if ((priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&

Oops.

This has to be the 'living'

	priv->ctrlmode

instead of the 'constant'

	priv->ctrlmode_supported

Will send an update when there's some more feedback or ACKs ...

Regards,
Oliver



> +	    (!priv->data_bittiming.tq || !priv->data_bittiming.bitrate ||
> +	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {
> +		netdev_err(dev, "incorrect/missing data bit-timing\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Switch carrier on if device was stopped while in bus-off state */
>  	if (!netif_carrier_ok(dev))
>  		netif_carrier_on(dev);
> 
