From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 13/14] can: make use of preallocated can_ml_priv for per
 device struct can_dev_rcv_lists
Date: Thu, 24 Aug 2017 15:55:24 +0200
Message-ID: <190a854e-9264-0850-4d6a-8c0001016cc6@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-14-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:9910 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbdHXN6g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:58:36 -0400
In-Reply-To: <20170802174434.4689-14-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:

>   static struct can_dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
>   							struct net_device *dev)
>   {
> -	if (!dev)
> +	if (dev) {
> +		struct can_ml_priv *ml_priv = dev->ml_priv;
> +		return &ml_priv->dev_rcv_lists;
> +	} else {
>   		return net->can.can_rx_alldev_list;
> -	else
> -		return (struct can_dev_rcv_lists *)dev->ml_priv;
> +	}
>   }

I would not change the condition in the if-statement and the code order.

>   
>   /**
> @@ -589,12 +592,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>   	if (can_pstats->rcv_entries > 0)
>   		can_pstats->rcv_entries--;
>   
> -	/* remove device structure requested by NETDEV_UNREGISTER */
> -	if (dev_rcv_lists->remove_on_zero_entries && !dev_rcv_lists->entries) {
> -		kfree(dev_rcv_lists);
> -		dev->ml_priv = NULL;
> -	}
> -
>    out:
>   	spin_unlock(&net->can.can_rcvlists_lock);
>   
> @@ -827,7 +824,6 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
>   			void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> -	struct can_dev_rcv_lists *dev_rcv_lists;
>   
>   	if (dev->type != ARPHRD_CAN)
>   		return NOTIFY_DONE;
> @@ -835,33 +831,8 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
>   	switch (msg) {
>   
>   	case NETDEV_REGISTER:
> -
> -		/* create new dev_rcv_lists for this device */
> -		dev_rcv_lists = kzalloc(sizeof(*dev_rcv_lists), GFP_KERNEL);
> -		if (!dev_rcv_lists)
> -			return NOTIFY_DONE;
> -		BUG_ON(dev->ml_priv);
> -		dev->ml_priv = dev_rcv_lists;
> -
> -		break;
> -
> -	case NETDEV_UNREGISTER:
> -		spin_lock(&dev_net(dev)->can.can_rcvlists_lock);
> -
> -		dev_rcv_lists = dev->ml_priv;
> -		if (dev_rcv_lists) {
> -			if (dev_rcv_lists->entries)
> -				dev_rcv_lists->remove_on_zero_entries = 1;
> -			else {
> -				kfree(dev_rcv_lists);
> -				dev->ml_priv = NULL;
> -			}
> -		} else
> -			pr_err("can: notifier: receive list not found for dev "
> -			       "%s\n", dev->name);
> -
> -		spin_unlock(&dev_net(dev)->can.can_rcvlists_lock);
> -
> +		WARN(!dev->ml_priv,
> +		     "No CAN mid layer private allocated, please fix your driver and use alloc_candev()!\n");

Nice :-)

>   		break;
>   	}
>   
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index 4b77c7951f17..dc198a07a8d1 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -71,7 +71,6 @@ struct can_dev_rcv_lists {
>   	struct hlist_head rx[RX_MAX];
>   	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
>   	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
> -	int remove_on_zero_entries;
>   	int entries;
>   };
>   
> 
