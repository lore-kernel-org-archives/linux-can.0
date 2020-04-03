From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] net: can: remove "WITH Linux-syscall-note" from SPDX tag
 of C files
Date: Fri, 3 Apr 2020 16:35:30 +0200
Message-ID: <f45febfa-a19a-0d76-d545-6427e5f1ce1e@hartkopp.net>
References: <20200403073741.18352-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:33286 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOfy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 10:35:54 -0400
In-Reply-To: <20200403073741.18352-1-masahiroy@kernel.org>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org



On 03/04/2020 09.37, Masahiro Yamada wrote:
> The "WITH Linux-syscall-note" exception is intended for UAPI headers.
> 
> See LICENSES/exceptions/Linux-syscall-note
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Masahiro!


> ---
> 
>   net/can/bcm.c  | 2 +-
>   net/can/gw.c   | 2 +-
>   net/can/proc.c | 2 +-
>   net/can/raw.c  | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index c96fa0f33db3..d94b20933339 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /*
>    * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
>    *
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 65d60c93af29..49b4e3d91ad6 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /* gw.c - CAN frame Gateway/Router/Bridge with netlink interface
>    *
>    * Copyright (c) 2019 Volkswagen Group Electronic Research
> diff --git a/net/can/proc.c b/net/can/proc.c
> index e6881bfc3ed1..a4eb06c9eb70 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /*
>    * proc.c - procfs support for Protocol family CAN core module
>    *
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 59c039d73c6d..ab104cc18562 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   /* raw.c - Raw sockets for protocol family CAN
>    *
>    * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
> 
