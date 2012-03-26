From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix sparse warning for cgw_list
Date: Mon, 26 Mar 2012 06:04:40 +0200
Message-ID: <4F6FEAD8.3090203@hartkopp.net>
References: <1332716750-3455-1-git-send-email-dbaluta@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:40333 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2CZFEk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Mar 2012 01:04:40 -0400
In-Reply-To: <1332716750-3455-1-git-send-email-dbaluta@ixiacom.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dbaluta@ixiacom.com
Cc: davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>

On 26.03.2012 01:05, dbaluta@ixiacom.com wrote:

> From: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Make cgw_list static to remove the following sparse warning:
> net/can/gw.c:69:1: warning: symbol 'cgw_list' was not declared.
> Should it be static?
> 
> Signed-off-by: Daniel Baluta <dbaluta@ixiacom.com>


Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>



Hello Daniel,

cgw_list is indeed only a local structure. Don't know why i didn't declare it
to be static. If it silences a sparse warning the better :-)

Thanks,
Oliver


> ---
>  net/can/gw.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 3d79b12..b41acf2 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -66,7 +66,7 @@ MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>  MODULE_ALIAS("can-gw");
>  
> -HLIST_HEAD(cgw_list);
> +static HLIST_HEAD(cgw_list);
>  static struct notifier_block notifier;
>  
>  static struct kmem_cache *cgw_cache __read_mostly;


