From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH v4 7/7] can: add bittiming check at interface open for
 CAN FD
Date: Wed, 26 Feb 2014 20:52:08 +0100
Message-ID: <20140226195208.GA10876@vandijck-laurijssen.be>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
 <1393009025-4903-8-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:51413 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753013AbaBZTwT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 14:52:19 -0500
Content-Disposition: inline
In-Reply-To: <1393009025-4903-8-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Fri, Feb 21, 2014 at 07:57:05PM +0100, Oliver Hartkopp wrote:
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
> +	    (!priv->data_bittiming.tq || !priv->data_bittiming.bitrate ||
> +	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {

This prevents to configure a data bitrate slower than the arbitration bitrate.
Such configuration is useless, but is it really "incorrect" or wrong?

> +		netdev_err(dev, "incorrect/missing data bit-timing\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Switch carrier on if device was stopped while in bus-off state */
>  	if (!netif_carrier_ok(dev))
>  		netif_carrier_on(dev);

Kind regards,
Kurt
