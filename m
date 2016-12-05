From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] can: raw: raw_setsockopt: limit number of can_filter that
 can be set
Date: Mon, 5 Dec 2016 12:34:44 +0100
Message-ID: <CAAeHK+wtKLZbS_VNyNby_fbAt6o=p2H1we+ZhErbHpyUOEvv7A@mail.gmail.com>
References: <20161205105536.23668-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35045 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbcLELey (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2016 06:34:54 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so92446527wmd.0
        for <linux-can@vger.kernel.org>; Mon, 05 Dec 2016 03:34:46 -0800 (PST)
In-Reply-To: <20161205105536.23668-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

On Mon, Dec 5, 2016 at 11:55 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> This patch adds a check to limit the number of can_filters that can be ser via
> setsockopt on CAN_RAW sockets.
>
> Otherwise allocations > MAX_ORDER are not prevented resulting in the following
> warning found by Andrey Konovalov:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 4009 at mm/page_alloc.c:3511
> __alloc_pages_slowpath+0x3d4/0x1bf0
> Modules linked in:
> CPU: 0 PID: 4009 Comm: a.out Not tainted 4.9.0-rc6+ #54
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>  ffff88006832f8a8 ffffffff81c73b14 0000000000000000 0000000000000000
>  ffffffff842c6320 0000000000000000 ffff88006832f8f0 ffffffff8123dc57
>  ffff880067d86000 ffffffff00000db7 ffffffff842c6320 0000000000000db7
> Call Trace:
>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>  [<ffffffff81c73b14>] dump_stack+0xb3/0x10f lib/dump_stack.c:51
>  [<ffffffff8123dc57>] __warn+0x1a7/0x1f0 kernel/panic.c:550
>  [<ffffffff8123de6c>] warn_slowpath_null+0x2c/0x40 kernel/panic.c:585
>  [<ffffffff81559b04>] __alloc_pages_slowpath+0x3d4/0x1bf0 mm/page_alloc.c:3511
>  [<ffffffff8155b8e2>] __alloc_pages_nodemask+0x5c2/0x710 mm/page_alloc.c:3781
>  [<ffffffff816236a4>] alloc_pages_current+0xf4/0x400 mm/mempolicy.c:2072
>  [<     inline     >] alloc_pages ./include/linux/gfp.h:469
>  [<ffffffff815a834f>] kmalloc_order+0x1f/0x70 mm/slab_common.c:1015
>  [<ffffffff815a83bf>] kmalloc_order_trace+0x1f/0x160 mm/slab_common.c:1026
>  [<     inline     >] kmalloc_large ./include/linux/slab.h:422
>  [<ffffffff81635e67>] __kmalloc_track_caller+0x227/0x2a0 mm/slub.c:4233
>  [<ffffffff8159932c>] memdup_user+0x2c/0xa0 mm/util.c:137
>  [<ffffffff8369e0de>] raw_setsockopt+0x1be/0x9f0 net/can/raw.c:506
>  [<     inline     >] SYSC_setsockopt net/socket.c:1757
>  [<ffffffff82ca10c4>] SyS_setsockopt+0x154/0x240 net/socket.c:1736
>  [<ffffffff840f2901>] entry_SYSCALL_64_fastpath+0x1f/0xc2
> arch/x86/entry/entry_64.S:209
> ---[ end trace bc80556cca970089 ]---
>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/uapi/linux/can.h | 1 +
>  net/can/raw.c            | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 9692cda5f8fc..c48d93a28d1a 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -196,5 +196,6 @@ struct can_filter {
>  };
>
>  #define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id */
> +#define CAN_RAW_FILTER_MAX 512 /* maximum number of can_filter set via setsockopt() */
>
>  #endif /* !_UAPI_CAN_H */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 972c187d40ab..b075f028d7e2 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -499,6 +499,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>                 if (optlen % sizeof(struct can_filter) != 0)
>                         return -EINVAL;
>
> +               if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
> +                       return -EINVAL;
> +
>                 count = optlen / sizeof(struct can_filter);
>
>                 if (count > 1) {
> --
> 2.10.2
>

Tested-by: Andrey Konovalov <andreyknvl@google.com>
