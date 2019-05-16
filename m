From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: gw: Fix error path of cgw_module_init
Date: Thu, 16 May 2019 18:24:40 +0200
Message-ID: <5e833f8b-537b-f4b0-4d7d-489936026cca@hartkopp.net>
References: <20190516155435.42376-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516155435.42376-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, mkl@pengutronix.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 16.05.19 17:54, YueHaibing wrote:
> This patch fix error path for cgw_module_init
> to avoid possible crash if some error occurs.
> 
> Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
>   net/can/gw.c | 46 +++++++++++++++++++++++++++++++---------------
>   1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 53859346..8b53ec7 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -1046,32 +1046,48 @@ static __init int cgw_module_init(void)
>   	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=%d\n",
>   		max_hops);
>   
> -	register_pernet_subsys(&cangw_pernet_ops);
> +	ret = register_pernet_subsys(&cangw_pernet_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = -ENOMEM;
>   	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
>   				      0, 0, NULL);
> -
>   	if (!cgw_cache)
> -		return -ENOMEM;
> +		goto out_cache_create;
>   
>   	/* set notifier */
>   	notifier.notifier_call = cgw_notifier;
> -	register_netdevice_notifier(&notifier);
> +	ret = register_netdevice_notifier(&notifier);
> +	if (ret)
> +		goto out_register_notifier;
>   
>   	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_GETROUTE,
>   				   NULL, cgw_dump_jobs, 0);
> -	if (ret) {
> -		unregister_netdevice_notifier(&notifier);
> -		kmem_cache_destroy(cgw_cache);
> -		return -ENOBUFS;
> -	}
> -
> -	/* Only the first call to rtnl_register_module can fail */
> -	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
> -			     cgw_create_job, NULL, 0);
> -	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
> -			     cgw_remove_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register1;
> +
> +	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
> +				   cgw_create_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register2;
> +	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
> +				   cgw_remove_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register2;
>   
>   	return 0;
> +
> +out_rtnl_register2:
> +	rtnl_unregister_all(PF_CAN);
> +out_rtnl_register1:
> +	unregister_netdevice_notifier(&notifier);
> +out_register_notifier:
> +	kmem_cache_destroy(cgw_cache);
> +out_cache_create:
> +	unregister_pernet_subsys(&cangw_pernet_ops);
> +
> +	return ret;
>   }
>   
>   static __exit void cgw_module_exit(void)
> 
