From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 11/14] can: af_can: can_pernet_exit(): no need to iterate
 over and cleanup registered CAN devices
Date: Thu, 24 Aug 2017 15:48:30 +0200
Message-ID: <adaa1c5c-e584-4a88-fd14-48f7dcb77850@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-12-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:24366 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdHXNsc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:48:32 -0400
In-Reply-To: <20170802174434.4689-12-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> The networking core takes care and unregisters every network device in
> a namespace before calling the can_pernet_exit() hook. This patch
> removes the unneeded cleanup.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Huh.

IIRC this was introduced to make sure that the data structures are 
removed in the case one the af_can users (e.g. can-raw, can-bcm) crashes 
and does not remove its subscriptions for that reason.

So when unloading can.ko under these circumstances this code would just 
clean up the rubbish.

Not sure whether we would need to take care after your midlayer rework.

Regards,
Oliver

> ---
>   net/can/af_can.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index e3df12cd2cae..d781b9330f2c 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -906,27 +906,12 @@ static int can_pernet_init(struct net *net)
>   
>   static void can_pernet_exit(struct net *net)
>   {
> -	struct net_device *dev;
> -
>   	if (IS_ENABLED(CONFIG_PROC_FS)) {
>   		can_remove_proc(net);
>   		if (stats_timer)
>   			del_timer_sync(&net->can.can_stattimer);
>   	}
>   
> -	/* remove created dev_rcv_lists from still registered CAN devices */
> -	rcu_read_lock();
> -	for_each_netdev_rcu(net, dev) {
> -		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
> -			struct can_dev_rcv_lists *dev_rcv_lists = dev->ml_priv;
> -
> -			BUG_ON(dev_rcv_lists->entries);
> -			kfree(dev_rcv_lists);
> -			dev->ml_priv = NULL;
> -		}
> -	}
> -	rcu_read_unlock();
> -
>   	kfree(net->can.can_rx_alldev_list);
>   	kfree(net->can.can_stats);
>   	kfree(net->can.can_pstats);
> 
