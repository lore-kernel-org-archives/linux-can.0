From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/3] can: af_can: fix sparse warning for can_rx_alldev_list
Date: Wed, 20 Jun 2012 05:39:59 +0200
Message-ID: <4FE1460F.8040409@hartkopp.net>
References: <1340136320-30840-1-git-send-email-mkl@pengutronix.de> <1340136320-30840-4-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28531 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab2FTDkA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 23:40:00 -0400
In-Reply-To: <1340136320-30840-4-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 19.06.2012 22:05, Marc Kleine-Budde wrote:

> Make can_rx_alldev_list static to fix the following sparse warning:
> net/can/af_can.c:80:22: warning: symbol 'can_rx_alldev_list' was not
> declared. Should it be static?
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  net/can/af_can.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 821022a..ccef846 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -78,7 +78,7 @@ module_param(stats_timer, int, S_IRUGO);
>  MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:on)");
>  
>  /* receive filters subscribed for 'all' CAN devices */
> -struct dev_rcv_lists can_rx_alldev_list;
> +static struct dev_rcv_lists can_rx_alldev_list;
>  static DEFINE_SPINLOCK(can_rcvlists_lock);
>  
>  static struct kmem_cache *rcv_cache __read_mostly;


Hello Marc,

did you already compile this?

can_rx_alldev_list is used in af_can.c and proc.c :

$ grep can_rx_alldev_list *.c
af_can.c:struct dev_rcv_lists can_rx_alldev_list;
af_can.c:		return &can_rx_alldev_list;
af_can.c:	matches = can_rcv_filter(&can_rx_alldev_list, skb);
af_can.c:	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
proc.c:extern struct dev_rcv_lists can_rx_alldev_list;
proc.c:	d = &can_rx_alldev_list;
proc.c:	d = &can_rx_alldev_list;

So i wonder if making it static inside af_can.c is a good idea.

Is there no way to satisfy the sparse warning in another way?

Regards,
Oliver

