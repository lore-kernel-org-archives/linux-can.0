From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 14/14] can: af_can: remove NULL-ptr checks from users of
 can_dev_rcv_lists_find()
Date: Thu, 24 Aug 2017 15:58:17 +0200
Message-ID: <4eec9641-2c4d-5742-ec55-fa963ecdc132@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-15-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:36786 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbdHXN6S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:58:18 -0400
In-Reply-To: <20170802174434.4689-15-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> Since using the "struct can_ml_priv" for the per device "struct
> dev_rcv_lists" the call can_dev_rcv_lists_find() cannot fail anymore.
> This patch simplifies af_can by removing the NULL pointer checks from
> the dev_rcv_lists returned by can_dev_rcv_lists_find().
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/af_can.c | 46 ++++++++++++++++------------------------------
>   1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index c3eac4ab74e9..f940030f797f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -486,28 +486,22 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
>   	spin_lock(&net->can.can_rcvlists_lock);
>   
>   	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
> -	if (dev_rcv_lists) {
> -		rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
> -
> -		rcv->can_id = can_id;
> -		rcv->mask = mask;
> -		rcv->matches = 0;
> -		rcv->func = func;
> -		rcv->data = data;
> -		rcv->ident = ident;
> -		rcv->sk = sk;
> -
> -		hlist_add_head_rcu(&rcv->list, rcv_list);
> -		dev_rcv_lists->entries++;
> -
> -		can_pstats->rcv_entries++;
> -		can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
> -						  can_pstats->rcv_entries);
> -	} else {
> -		kmem_cache_free(rcv_cache, rcv);
> -		err = -ENODEV;
> -	}
> +	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
> +
> +	rcv->can_id = can_id;
> +	rcv->mask = mask;
> +	rcv->matches = 0;
> +	rcv->func = func;
> +	rcv->data = data;
> +	rcv->ident = ident;
> +	rcv->sk = sk;
>   
> +	hlist_add_head_rcu(&rcv->list, rcv_list);
> +	dev_rcv_lists->entries++;
> +
> +	can_pstats->rcv_entries++;
> +	can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
> +					  can_pstats->rcv_entries);
>   	spin_unlock(&net->can.can_rcvlists_lock);
>   
>   	return err;
> @@ -556,13 +550,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>   	spin_lock(&net->can.can_rcvlists_lock);
>   
>   	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
> -	if (!dev_rcv_lists) {
> -		pr_err("BUG: receive list not found for "
> -		       "dev %s, id %03X, mask %03X\n",
> -		       DNAME(dev), can_id, mask);
> -		goto out;
> -	}
> -
>   	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
>   
>   	/*
> @@ -697,8 +684,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
>   
>   	/* find receive list for this device */
>   	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
> -	if (dev_rcv_lists)
> -		matches += can_rcv_filter(dev_rcv_lists, skb);
> +	matches += can_rcv_filter(dev_rcv_lists, skb);
>   
>   	rcu_read_unlock();
>   
> 
