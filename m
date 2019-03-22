From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] can: af_can: Fix possible NULL pointer dereference in
 can_exit
Date: Fri, 22 Mar 2019 17:09:10 +0800
Message-ID: <95427ecd-2f2a-7b91-d097-284519aaaf59@huawei.com>
References: <20190309034331.17944-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309034331.17944-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, socketcan@hartkopp.net, mkl@pengutronix.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

ping...

On 2019/3/9 11:43, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Syzkaller report this:
> 
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 0 PID: 9400 Comm: syz-executor.0 Tainted: G         C        5.0.0-rc8+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> RIP: 0010:__list_del include/linux/list.h:105 [inline]
> RIP: 0010:__list_del_entry include/linux/list.h:120 [inline]
> RIP: 0010:list_del include/linux/list.h:125 [inline]
> RIP: 0010:__unregister_pernet_operations net/core/net_namespace.c:1075 [inline]
> RIP: 0010:unregister_pernet_operations+0x124/0x540 net/core/net_namespace.c:1137
> Code: 89 c1 48 c1 e9 03 80 3c 11 00 0f 85 38 03 00 00 48 8d 7d 08 48 ba 00 00 00 00 00 fc ff df 4d 8b 7c 24 08 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 02 03 00 00 48 8d 9c 24 b8 00 00 00 48 ba 00 00
> RSP: 0018:ffff8881b871fbb0 EFLAGS: 00010a06
> RAX: ffffffffc198c4c8 RBX: dffffc0000000000 RCX: 1bd5a00000000021
> RDX: dffffc0000000000 RSI: ffffc900014c4000 RDI: dead000000000108
> RBP: dead000000000100 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff8881b871fb30 R11: 0000000000000000 R12: ffffffffc198c4c0
> R13: ffff8881b871fbe8 R14: 1ffff110370e3f79 R15: dead000000000200
> FS:  00007f029df32700(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc85454218 CR3: 00000001e0ff4004 CR4: 00000000007606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  unregister_pernet_subsys+0x1d/0x30 net/core/net_namespace.c:1184
>  can_exit+0x3f/0x56 [can]
>  __do_sys_delete_module kernel/module.c:1018 [inline]
>  __se_sys_delete_module kernel/module.c:961 [inline]
>  __x64_sys_delete_module+0x3dc/0x5e0 kernel/module.c:961
>  do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462e99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f029df31c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f029df326bc
> R13: 00000000004bcca9 R14: 00000000006f6b48 R15: 00000000ffffffff
> 
> register_pernet_subsys may fails in can_init,then can_exit calls
> unregister_pernet_subsys when unloading, it can trigger a NULL
> pointer dereference while doing list_del.This patch fix error
> cleanup path of can_init to avoid this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/can/af_can.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1684ba5..5d75685 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -958,6 +958,8 @@ static struct pernet_operations can_pernet_ops __read_mostly = {
>  
>  static __init int can_init(void)
>  {
> +	int rc;
> +
>  	/* check for correct padding to be able to use the structs similarly */
>  	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
>  		     offsetof(struct canfd_frame, len) ||
> @@ -971,15 +973,31 @@ static __init int can_init(void)
>  	if (!rcv_cache)
>  		return -ENOMEM;
>  
> -	register_pernet_subsys(&can_pernet_ops);
> +	rc = register_pernet_subsys(&can_pernet_ops);
> +	if (rc)
> +		goto free_cache;
>  
>  	/* protocol register */
> -	sock_register(&can_family_ops);
> -	register_netdevice_notifier(&can_netdev_notifier);
> +	rc = sock_register(&can_family_ops);
> +	if (rc)
> +		goto unregister_pernet;
> +
> +	rc = register_netdevice_notifier(&can_netdev_notifier);
> +	if (rc)
> +		goto sock_unregister;
> +
>  	dev_add_pack(&can_packet);
>  	dev_add_pack(&canfd_packet);
>  
>  	return 0;
> +
> +sock_unregister:
> +	sock_unregister(PF_CAN);
> +unregister_pernet:
> +	unregister_pernet_subsys(&can_pernet_ops);
> +free_cache:
> +	kmem_cache_destroy(rcv_cache);
> +	return rc;
>  }
>  
>  static __exit void can_exit(void)
> 
