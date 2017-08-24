From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 01/14] can: af_can: can_pernet_init(): add missing error
 handling for kzalloc returning NULL
Date: Thu, 24 Aug 2017 14:42:16 +0200
Message-ID: <8ec07d87-eef5-e054-f8c5-50c4ca4737ab@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-2-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34344 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdHXMmS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 08:42:18 -0400
In-Reply-To: <20170802174434.4689-2-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch adds the missing check and error handling for out-of-memory
> situations, when kzalloc cannot allocate memory.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/af_can.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 88edac0f3e36..0896e2facd50 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -875,9 +875,14 @@ static int can_pernet_init(struct net *net)
>   	spin_lock_init(&net->can.can_rcvlists_lock);
>   	net->can.can_rx_alldev_list =
>   		kzalloc(sizeof(struct dev_rcv_lists), GFP_KERNEL);
> -
> -	net->can.can_stats = kzalloc(sizeof(struct s_stats), GFP_KERNEL);
> -	net->can.can_pstats = kzalloc(sizeof(struct s_pstats), GFP_KERNEL);
> +	if (!net->can.can_rx_alldev_list)
> +		goto out;
> +	net->can.can_stats = kzalloc(sizeof(struct can_stats), GFP_KERNEL);
> +	if (!net->can.can_stats)
> +		goto out_free_alldev_list;
> +	net->can.can_pstats = kzalloc(sizeof(struct can_pstats), GFP_KERNEL);
> +	if (!net->can.can_pstats)
> +		goto out_free_can_stats;
>   
>   	if (IS_ENABLED(CONFIG_PROC_FS)) {
>   		/* the statistics are updated every second (timer triggered) */
> @@ -892,6 +897,13 @@ static int can_pernet_init(struct net *net)
>   	}
>   
>   	return 0;
> +
> + out_free_can_stats:
> +	kfree(net->can.can_stats);
> + out_free_alldev_list:
> +	kfree(net->can.can_rx_alldev_list);
> + out:
> +	return -ENOMEM;
>   }
>   
>   static void can_pernet_exit(struct net *net)
> 
