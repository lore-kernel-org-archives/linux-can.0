From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: Propagate SO_PRIORITY of raw sockets to skbs
Date: Fri, 24 Jan 2014 21:12:21 +0100
Message-ID: <52E2C925.7050708@hartkopp.net>
References: <1390565857-10417-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:50488 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaAXUMZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2014 15:12:25 -0500
In-Reply-To: <1390565857-10417-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, lisovy@gmail.com



On 24.01.2014 13:17, Michal Sojka wrote:
> From: Rostislav Lisovy <lisovy@gmail.com>
> 
> This allows controlling certain queueing disciplines by setting the
> socket's SO_PRIORITY option.
> 
> For example, with the default pfifo_fast queueing discipline, which
> provides three priorities, socket priority TC_PRIO_CONTROL means
> higher than default and TC_PRIO_BULK means lower than default.
> 
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx Rostislav

> ---
>  net/can/raw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 641e1c8..01c5fbf 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -716,6 +716,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
>  
>  	skb->dev = dev;
>  	skb->sk  = sk;
> +	skb->priority = sk->sk_priority;
>  
>  	err = can_send(skb, ro->loopback);
>  
> 
