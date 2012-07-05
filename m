From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Thu, 05 Jul 2012 11:48:22 +0200
Message-ID: <4FF562E6.4090808@hartkopp.net>
References: <20120703232328.GD6616@ovro.caltech.edu> <4FF40A6E.1040709@grandegger.com> <20120704120736.GB417@vandijck-laurijssen.be> <4FF46E12.8060102@hartkopp.net> <20120704190733.GC4422@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:57511 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab2GEJsX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 05:48:23 -0400
In-Reply-To: <20120704190733.GC4422@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, linux-can@vger.kernel.org

On 04.07.2012 21:07, Ira W. Snyder wrote:


> Is the following patch what you have in mind? I tested it on my board,
> and it crashed after a few seconds, so there must be something wrong.
> Any ideas?
> 
> I won't have access to the machine to do more testing until tomorrow.
> 
> Ira
> 
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c5fe3a3..f112f77 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -348,6 +348,39 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
>  EXPORT_SYMBOL_GPL(can_get_echo_skb);
>  
>  /*
> + * Compare an skb with an existing echo skb
> + *
> + * This function will be used on devices which have a hardware loopback.
> + * On these devices, this function can be used to compare a received skb
> + * with the saved echo skbs so that the hardware echo skb can be dropped.
> + *
> + * Returns true if the skb's are identical, false otherwise.
> + */
> +bool can_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
> +		      unsigned int idx)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +	struct can_frame *cf = (struct can_frame *)skb->data;
> +
> +	BUG_ON(idx >= priv->echo_skb_max);
> +
> +	if (priv->echo_skb[idx]) {
> +		struct sk_buff *echo_skb = priv->echo_skb[idx];
> +		struct can_frame *echo_cf = (struct can_frame *)echo_skb->data;
> +		if (cf->can_id != echo_cf->can_id)
> +			return false;
> +
> +		if (cf->can_dlc != echo_cf->can_dlc)
> +			return false;
> +
> +		return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(can_cmp_echo_skb);


Partly :-)

The question is when you receive any CAN frame, how do you know to what
echo_skb[index] this should be compared?

AFAIK every CAN driver manages it's echo_skb[] array itself. E.g. the sja1000
driver only uses index '0' for that reason that i handles only one tx process
at a time.

If you have more than one element in the echo_skb[] array, i would think of

for (i = 0; i < DRVNAME_ECHO_SKB_MAX; i++) {

> +	/* check if this is an ECHO frame */
> +	if (can_cmp_echo_skb(skb, ndev, i)) {
> +		stats->txbytes += can_get_echo_skb(ndev, i);
> +		kfree_skb(skb);
> +		goto some_exit;
> +	}

}

Regards,
Oliver
