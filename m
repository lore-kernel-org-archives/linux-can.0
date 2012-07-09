From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/3] can: make the echo stack keep packet information
 longer
Date: Mon, 09 Jul 2012 23:09:46 +0200
Message-ID: <4FFB489A.1050908@hartkopp.net>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu> <1341863790-5645-2-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:55434 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab2GIVJj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 17:09:39 -0400
In-Reply-To: <1341863790-5645-2-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

On 09.07.2012 21:56, Ira W. Snyder wrote:

> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> 
> In order for the can_cmp_echo_skb() function to be able to detect
> packets received via the hardware loopback feature, all packets must be
> saved. This means we cannot drop non-loopback packets until reception
> time.
> ---
>  drivers/net/can/dev.c |   41 +++++++++++++++++++++--------------------
>  1 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c5fe3a3..98e6c50 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -282,12 +282,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  
>  	BUG_ON(idx >= priv->echo_skb_max);
>  
> -	/* check flag whether this packet has to be looped back */
> -	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
> -		kfree_skb(skb);
> -		return;
> -	}
> -
>  	if (!priv->echo_skb[idx]) {
>  		struct sock *srcsk = skb->sk;
>  
> @@ -303,12 +297,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  
>  		skb->sk = srcsk;
>  
> -		/* make settings for echo to reduce code in irq context */
> -		skb->protocol = htons(ETH_P_CAN);
> -		skb->pkt_type = PACKET_BROADCAST;
> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> -		skb->dev = dev;
> -
>  		/* save this skb for tx interrupt echo handling */
>  		priv->echo_skb[idx] = skb;
>  	} else {
> @@ -329,21 +317,34 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
> +	struct sk_buff *skb = priv->echo_skb[idx];
> +	struct can_frame *cf;
> +	u8 dlc;
>  
>  	BUG_ON(idx >= priv->echo_skb_max);
>  
> -	if (priv->echo_skb[idx]) {
> -		struct sk_buff *skb = priv->echo_skb[idx];
> -		struct can_frame *cf = (struct can_frame *)skb->data;
> -		u8 dlc = cf->can_dlc;
> +	if (!skb)
> +		return 0;
>  
> -		netif_rx(priv->echo_skb[idx]);
> -		priv->echo_skb[idx] = NULL;
> +	priv->echo_skb[idx] = NULL;
> +	cf = (struct can_frame *)skb->data;
>  
> -		return dlc;
> +	/* check flag whether this packet has to be looped back */
> +	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
> +		kfree_skb(skb);
> +		return 0;
>  	}
>  
> -	return 0;
> +	/* make settings for echo to reduce code in irq context */


This comment became pointless :-)

> +	skb->protocol = htons(ETH_P_CAN);
> +	skb->pkt_type = PACKET_BROADCAST;
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	skb->dev = dev;


Hm - it's proably worth to check, if we really need to set all these values or if

	skb->pkt_type = PACKET_BROADCAST;

would just be enough.

Will do so - but this is not relevant for your current patch.

> +
> +	dlc = cf->can_dlc;
> +	netif_rx(skb);
> +
> +	return dlc;
>  }
>  EXPORT_SYMBOL_GPL(can_get_echo_skb);
>  


Regards,
Oliver

