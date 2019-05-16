From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: Fix error path of can_init
Date: Thu, 16 May 2019 18:25:49 +0200
Message-ID: <70bc346c-9328-d0a2-bd7e-af8dff748061@hartkopp.net>
References: <20190516143626.27636-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516143626.27636-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, mkl@pengutronix.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 16.05.19 16:36, YueHaibing wrote:
> This patch add error path for can_init to
> avoid possible crash if some error occurs.
> 
> Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
>   net/can/af_can.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1684ba5..a1781ea 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -958,6 +958,8 @@ static void can_pernet_exit(struct net *net)
>   
>   static __init int can_init(void)
>   {
> +	int rc;
> +
>   	/* check for correct padding to be able to use the structs similarly */
>   	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
>   		     offsetof(struct canfd_frame, len) ||
> @@ -971,15 +973,31 @@ static __init int can_init(void)
>   	if (!rcv_cache)
>   		return -ENOMEM;
>   
> -	register_pernet_subsys(&can_pernet_ops);
> +	rc = register_pernet_subsys(&can_pernet_ops);
> +	if (rc)
> +		goto out_pernet;
>   
>   	/* protocol register */
> -	sock_register(&can_family_ops);
> -	register_netdevice_notifier(&can_netdev_notifier);
> +	rc = sock_register(&can_family_ops);
> +	if (rc)
> +		goto out_sock;
> +	rc = register_netdevice_notifier(&can_netdev_notifier);
> +	if (rc)
> +		goto out_notifier;
> +
>   	dev_add_pack(&can_packet);
>   	dev_add_pack(&canfd_packet);
>   
>   	return 0;
> +
> +out_notifier:
> +	sock_unregister(PF_CAN);
> +out_sock:
> +	unregister_pernet_subsys(&can_pernet_ops);
> +out_pernet:
> +	kmem_cache_destroy(rcv_cache);
> +
> +	return rc;
>   }
>   
>   static __exit void can_exit(void)
> 
